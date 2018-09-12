//
//  WebServiceHandler_Vishal.h
//  GoTabibi
//
//  Created by Vishal on 7/14/15.
//  Copyright (c) 2015 gotabibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol webServiceDelegate <NSObject>

- (void)returnSuccess:(NSDictionary *)_result :(NSString *)_apiname;
- (void)returnFail;

@end


typedef void(^success)(NSDictionary *);
typedef void(^failed)(NSError *);

@interface WebServiceHandler_Vishal : NSObject{
    
    id delegate;
    
}
@property (strong,nonatomic) id delegate;
+ (WebServiceHandler_Vishal*) sharedSingleton;

- (void)setDelegate:(id)delegate;
- (void)call_webApi_Post:(NSString *)_url :(success) success :(failed)failed;
- (void)call_webApi_Get:(NSString *)_url :(success) success :(failed)failed;

@end
