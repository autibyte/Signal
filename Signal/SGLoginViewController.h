//
//  SGLoginViewController.h
//  Signal
//
//  Created by Graham Ramsey on 5/9/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGLoginViewController : UITableViewController<UITextFieldDelegate>{
    BOOL view_is_up;
}
-(void)moveTableView:(BOOL)up;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIControl *headerView;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *tagOrEmailField;
- (IBAction)headerTouched:(id)sender;

@end
