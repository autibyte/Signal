//
//  SGJoinViewController.h
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGJoinViewController : UITableViewController
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *tagField;
- (void) hideKeyboard;
@end
