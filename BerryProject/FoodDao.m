//
//  FoodDao.m
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "FoodDao.h"
#import "HUNetwork.h"

@implementation FoodDao

- (id)init
{
    self = [super init];
    if (self) {
        netWork = [[HUNetwork alloc] init];
    }
    return self;
}

- (void)findAllCompletion:(void (^)(NSArray *))block errorHandle:(void (^)())error
{
    NSString *path = @"/PersonServlet";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:2] forKey:@"action"];
    
    [netWork startRequestWithPath:path Params:params completion:^(NSDictionary *result) {
        
        //NSNumber *resultCode = [result objectForKey:@"ResultCode"];
        
        //if ([resultCode intValue] >= 0) {
            listDataArray = [result objectForKey:@"Record"];
            //NSLog(@"listDataArray:%@", listDataArray);
            block(listDataArray);
        //}

    } errorHandler:^{
        error();
        
    }];
    
    
    
    
}


- (void)searchFromeName:(NSString *)name Completion:(void (^)(NSArray *))block
{
    NSString *path = @"/PersonServlet";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:2] forKey:@"action"];
    [params setObject:name forKey:@"name"];
    
    [netWork startRequestWithPath:path Params:params completion:^(NSDictionary *result) {
        
        //NSNumber *resultCode = [result objectForKey:@"ResultCode"];
        
        //if ([resultCode intValue] >= 0) {
        listDataArray = [result objectForKey:@"Record"];
        //NSLog(@"listDataArray:%@", listDataArray);
        block(listDataArray);
        //}
        
    } errorHandler:nil];
    
}
@end
