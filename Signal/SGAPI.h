//
//  SGAPI.h
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGAPI : NSObject

+ (id) call:(NSString*) api_name withParams:(NSString*) params;
+ (id) call:(NSString*) api_name withDictParams:(NSDictionary*) params;
@end
