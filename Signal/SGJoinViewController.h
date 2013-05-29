//
//  SGJoinViewController.h
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGButtonCell.h"

@protocol SGJoinViewControllerDelegate
- (void) didJoinWithUserID:(NSString*)user_id;
@end

@interface SGJoinViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet SGButtonCell *joinButton;
@property (weak, nonatomic) id delegate;

-(void)join;
- (IBAction)cancel:(id)sender;
- (IBAction)checkFilled:(id)sender;
- (void) hideKeyboard;
@end
