//
//  SGButton
//  Signal
//
//  Created by Graham Ramsey on 1/17/13.
//  Copyright (c) 2013 Seismic Technologies, All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *buttonText;
-(void) setEnabled:(BOOL) enabled;
@end