//
//  BusinessLogic.h
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessAction <NSObject>

- (void)findAllCompletion:(void(^)(NSArray *))block errorHandle:(void(^)())error;
- (void)searchFromeName:(NSString *)name Completion:(void(^)(NSArray *))block;

@end
@interface BusinessLogic : NSObject

@property (nonatomic, assign) id<BusinessAction> delegate;

- (id)initWithDelegate:(id<BusinessAction>)delegate;
+ (id)businessWithDelegate:(id<BusinessAction>)delegate;

- (void)findAllSucceed:(void(^)(NSArray *))block failed:(void(^)())failed;
-(void)searchFromeName:(NSString *)name Completion:(void (^)(NSArray *))block;


@end
