//
//  SGLoginViewController.m
//  Signal
//
//  Created by Graham Ramsey on 5/9/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import "SGLoginViewController.h"
#import "SGAPI.h"

#define IS_568H ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0)

@interface SGLoginViewController ()

@end

@implementation SGLoginViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    view_is_up = NO;
    if(!IS_568H){
        CGRect theFrame = _headerView.frame;
        theFrame.size.height -= 40.f;
        _headerView.frame = theFrame;
    }
    
    [_userstringField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"login_userstring"]];
    
    [self checkFilled:self];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveTableView:(BOOL)up{
    float move_distance = 55.f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    UIEdgeInsets insets = self.tableView.contentInset;
    if(view_is_up&&!up){
        insets.top += move_distance;
        view_is_up = NO;
    }
    else if(!view_is_up&&up){
        insets.top -= move_distance;
        view_is_up = YES;
    }
    self.tableView.contentInset = insets;
    [UIView commitAnimations];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
       [self moveTableView:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _userstringField){
        [_passwordField becomeFirstResponder];
    }else{
        [self login];
    }
    return YES;
}

-(void)login{
    
    /* API we will use */
    SGAPI* api = [[SGAPI alloc] init];
    
    if(!api.isConnected)
        return;
    
    /* disable login button */
    [_loginButtonCell setEnabled:NO];
    
    /* disable fields & starting */
    _userstringField.enabled = NO;
    _passwordField.enabled = NO;
    [_loginButtonCell.textLabel setText:@"Logging in..."];
    
    /* any error occuring during the login process */
    __block NSString* problem = @"Something went wrong when logging in. Try again?";
    __block NSString* problem_title = @"Whoops!";
    
    /* element to highlight if there is one */
    __block NSString* highlight_element = @"userstring";
    
    /* user id returned from API */
    __block NSString* user_id = @"0";
    
    dispatch_async(SGBACKGROUND, ^{
        
        NSString* userstring = _userstringField.text;
        NSString* password = _passwordField.text;
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userstring, @"userstring", password, @"password", nil];
        NSDictionary* login = [api call:@"auth" withDictParams:params];
        
        if(login!=nil){
            problem = [login objectForKey:@"problem"];
            problem_title = [login objectForKey:@"problem_title"];
            highlight_element = [login objectForKey:@"highlight_element"];
            user_id = [[login objectForKey:@"id"] stringValue];
        }
    
        dispatch_async(SGMAIN, ^{
            
            [api endConnection];
            
            /* re-enable required fields */
            _userstringField.enabled = YES;
            _passwordField.enabled = YES;
            [_passwordField setText:@""];
            [_loginButtonCell setEnabled:YES];
            [_loginButtonCell.textLabel setText:@"Login"];
            [[NSUserDefaults standardUserDefaults] setObject:_userstringField.text forKey:@"login_userstring"];
            
            if([login objectForKey:@"id"]==nil){
                
                /* there is an error */
                [SGAPI showAlertWithMessage:problem andTitle:problem_title];
                if([highlight_element isEqual:@"userstring"])
                    [_userstringField becomeFirstResponder];
                if([highlight_element isEqual:@"password"])
                    [_passwordField becomeFirstResponder];
                
            }else{
                
                [self proceedAfterLoginWithUserID:user_id];
            }
            
        });
    });

}

-(void)proceedAfterLoginWithUserID:(NSString*)user_id{
    
    /* update NSUserDefaults */
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"id"];
    
    /* proceed with segue */
    [self performSegueWithIdentifier:@"login" sender:self];
}

- (void) didJoinWithUserID:(NSString*)user_id{
    if (![self.presentingViewController isBeingDismissed]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [self proceedAfterLoginWithUserID:user_id];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"join"]){
        UINavigationController* nav = segue.destinationViewController;
        [nav.viewControllers[0] setDelegate:self];
    }
}

- (IBAction)checkFilled:(id)sender {
    if(_userstringField.text.length == 0||_passwordField.text.length == 0){
        [_loginButtonCell setEnabled:NO];
    }
    else{
        [_loginButtonCell setEnabled:YES];
    }
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if(indexPath.row==2&&indexPath.section==0){
        [self login];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)headerTouched:(id)sender {
    [self.tableView endEditing:YES];
    [self moveTableView:NO];
}
@end
