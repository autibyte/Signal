//
//  SGAPI.m
//  Signal
//
//  Created by Graham Ramsey on 5/10/13.
//  Copyright (c) 2013 Seismic Technologies. All rights reserved.
//

#import "SGAPI.h"

#define API_BASE "http://signal.seismic.so/api/"

@implementation SGAPI

+ (id) call:(NSString*) api_name withParams:(NSString*) params{
    
    // create the URL request to be sent to the API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@/", API_BASE, api_name]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    // the request string is in param1=val&param2=val2 format
    NSData *requestBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    // response data is collected into response_string
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *response_string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    // return a JSONified object
    NSData *data = [response_string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

//  same as normal call: method, but takes a NSMutableDictionary instead of a string
+ (id) call:(NSString*) api_name withDictParams:(NSDictionary*) params{
    
    NSMutableString *param_string = [[NSMutableString alloc] init];
    
    // for each key->value pair, create the POST param string
    int i = 0;
    for(id key in params){
        if(i!=0)
            [param_string appendFormat:@"&"];
        [param_string appendFormat:@"%@=%@", key, [params valueForKey:key]];
        i++;
    }
    
    // return the call method now that we have a correctly formated param string
    return [self call:api_name withParams:param_string];
    
}


@end
