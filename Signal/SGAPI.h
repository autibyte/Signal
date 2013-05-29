//
//  SGAPI.h
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SGBACKGROUND dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define SGMAIN dispatch_get_main_queue()

@interface SGAPI : NSObject{
    BOOL connected;
}

- (void) checkInternetConnection;
- (BOOL) isConnected;
- (id) call:(NSString*) api_name withParams:(NSString*) params;
- (id) call:(NSString*) api_name withDictParams:(NSDictionary*) params;
- (void) endConnection;

+ (void) showAlertWithMessage:(NSString*)message;
+ (void) showAlertWithMessage:(NSString *)message andTitle:(NSString*) title;

@end
