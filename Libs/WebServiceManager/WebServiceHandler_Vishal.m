//
//  WebServiceHandler_Vishal.m
//  GoTabibi
//
//  Created by Divyesh on 7/14/15.
//  Copyright (c) 2015 gotabibi. All rights reserved.
//

#import "WebServiceHandler_Vishal.h"
#import "AFHTTPSessionManager.h"

//#import "VSPinger.h"

@implementation WebServiceHandler_Vishal
@synthesize delegate;

- (void)setDelegate:(id)aDelegate {
    delegate = aDelegate; /// Not retained
}

+ (WebServiceHandler_Vishal*) sharedSingleton
{
    static WebServiceHandler_Vishal* theInstance = nil;
    if (theInstance == nil)
    {
        theInstance = [[self alloc] init];
    }
    return theInstance;
}

- (void)call_webApi_Post:(NSString *)_url :(success) success :(failed)failed{
    
    AFHTTPSessionManager* sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSString *url = [NSString stringWithFormat:@"%@",_url];
    [sessionManager POST:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        //NSString *responce = [NSString stringWithFormat:@"%@",responseObject];
        success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed (error);
    }];
}

- (void)call_webApi_Get:(NSString *)_url :(success) success :(failed)failed{
    
    AFHTTPSessionManager* sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSString *url = [NSString stringWithFormat:@"%@",_url];
    [sessionManager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        //NSString *responce = [NSString stringWithFormat:@"%@",responseObject];
        success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed (error);
    }];
}


@end

