//
//  SGButtonCell.m
//  Signal
//
//  Created by Graham Ramsey on 1/17/13.
//  Copyright (c) 2013 Seismic Technologies, All rights reserved.
//

#import "SGButtonCell.h"
#import "SGAppDelegate.h"

#define ENABLED_COLOR [SGAppDelegate mainBlueColor]
#define DISABLED_COLOR [UIColor lightGrayColor]

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
        [self.textLabel setTextColor:ENABLED_COLOR];
    }
    else{
        self.userInteractionEnabled = NO;
        [self.textLabel setTextColor:DISABLED_COLOR];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
