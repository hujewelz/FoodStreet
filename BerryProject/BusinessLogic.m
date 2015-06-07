//
//  BusinessLogic.m
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "BusinessLogic.h"

@implementation BusinessLogic

- (id)initWithDelegate:(id<BusinessAction>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}
+ (id)businessWithDelegate:(id<BusinessAction>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}

- (void)findAllSucceed:(void (^)(NSArray *))block failed:(void (^)())failed
{
    [self.delegate findAllCompletion:^(NSArray *result) {
        block(result);
        //NSLog(@"business result:%@", result);
    } errorHandle:^{
        failed();
    }];
}

-(void)searchFromeName:(NSString *)name Completion:(void (^)(NSArray *))block
{
    return [self.delegate searchFromeName:name Completion:^(NSArray * result) {
        block(result);
    }];
}

@end
