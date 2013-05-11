//
//  SGButtonCell.m
//  Signal
//
//  Created by Graham Ramsey on 1/17/13.
//  Copyright (c) 2013 Seismic Technologies, All rights reserved.
//

#import "SGButtonCell.h"
#import "SGAppDelegate.h"

@implementation SGButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setEnabled:(BOOL)enabled{
    if(enabled){
        self.userInteractionEnabled = YES;
        [_buttonText setTextColor:[SGAppDelegate colorFromHexString:@"#004080"]];
    }
    else{
        self.userInteractionEnabled = NO;
        [_buttonText setTextColor:[UIColor lightGrayColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
