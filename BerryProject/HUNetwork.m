//
//  HUNetwork.m
//  GoCourse
//
//  Created by jewelz on 14-11-16.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "HUNetwork.h"

@implementation HUNetwork

- (void)startRequestWithPath:(NSString *)path Params:(NSDictionary *)params completion:(BLOCK)block errorHandler:(void (^)())errorBlock
{
    self.block = block;
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST customHeaderFields:nil];
    MKNetworkOperation *operation = [engine operationWithPath:path params:params httpMethod:@"POST"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSData *data = [completedOperation responseData];
        _dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"redict:%@", _dict);
        
        self.block(_dict);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"请求错误! %@", [error localizedDescription]);
        errorBlock();
    }];
    
    [engine enqueueOperation:operation];
 
}



@end
