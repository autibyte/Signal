//
//  SGJoinViewController.m
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import "SGJoinViewController.h"
#import "SGAPI.h"

@interface SGJoinViewController ()

@end

@implementation SGJoinViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == _fullNameField){
        [_emailAddressField becomeFirstResponder];
    }else if(textField == _emailAddressField){
        [_passwordField becomeFirstResponder];
    }else if(textField == _passwordField){
        [_usernameField becomeFirstResponder];
    }else{
        [self join];
    }
    return YES;
}

- (IBAction)checkFilled:(id)sender {
    if(_usernameField.text.length == 0||_passwordField.text.length == 0||_emailAddressField.text.length == 0){
        [_joinButton setEnabled:NO];
    }
    else{
        [_joinButton setEnabled:YES];
    }
}

- (void) join{
    
    /* API we will use */
    SGAPI* api = [[SGAPI alloc] init];
    
    if(!api.isConnected)
        return;
    
    /* disable login button */
    [_joinButton setEnabled:NO];
    
    /* disable fields & starting */
    _fullNameField.enabled = NO;
    _usernameField.enabled = NO;
    _emailAddressField.enabled = NO;
    _passwordField.enabled= NO;
    [_joinButton.textLabel setText:@"Creating Account..."];
    
    /* any error occuring during the join process */
    __block NSString* problem = @"Something went wrong when trying to create an account. Try again?";
    __block NSString* problem_title = @"Whoops!";
    
    /* user id returned from API */
    __block NSString* user_id = @"0";
    
    dispatch_async(SGBACKGROUND, ^{
        
        NSString* full_name = _fullNameField.text;
        NSString* email = _emailAddressField.text;
        NSString* password = _passwordField.text;
        NSString* username = _usernameField.text;
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                                full_name, @"full_name",
                                email, @"email",
                                password, @"password",
                                username, @"username",
                                nil];
        NSDictionary* join = [api call:@"join" withDictParams:params];
        
        if(join!=nil){
            problem = [join objectForKey:@"problem"];
            problem_title = [join objectForKey:@"problem_title"];
            user_id = [join objectForKey:@"id"];
        }
        
        dispatch_async(SGMAIN, ^{
            
            [api endConnection];
            
            /* re-enable required fields */
            _fullNameField.enabled = YES;
            _usernameField.enabled = YES;
            _emailAddressField.enabled = YES;
            _passwordField.enabled= YES;
            [_joinButton setEnabled:YES];
            [_joinButton.textLabel setText:@"Create Account"];
            
            if([join objectForKey:@"id"]==nil){
                
                /* there is an error */
                [SGAPI showAlertWithMessage:problem andTitle:problem_title];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate didJoinWithUserID:user_id];
            }
            
        });
    });

}

- (void)viewDidLoad
{
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    [self checkFilled:self];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) hideKeyboard{
    [self.tableView endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [_fullNameField becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    if(indexPath.row==4&&indexPath.section==0){
        [self join];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
