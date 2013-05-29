//
//  SGLoginViewController.h
//  Signal
//
//  Created by Graham Ramsey on 5/9/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGButtonCell.h"
#import "SGJoinViewController.h"

@interface SGLoginViewController : UITableViewController<UITextFieldDelegate, SGJoinViewControllerDelegate>{
    BOOL view_is_up;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIControl *headerView;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *userstringField;
@property (weak, nonatomic) IBOutlet SGButtonCell *loginButton;
- (IBAction)checkFilled:(id)sender;
- (IBAction)headerTouched:(id)sender;
-(void)moveTableView:(BOOL)up;
-(void)login;
-(void)proceedAfterLoginWithUserID:(NSString*)user_id;

@end
