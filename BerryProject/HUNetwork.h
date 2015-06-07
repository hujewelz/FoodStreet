//
//  HUNetwork.h
//  GoCourse
//
//  Created by jewelz on 14-11-16.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HOST @"yunounou.eicp.net:8080/berry"
typedef void(^BLOCK)(NSDictionary *result);// 定义一个block对象

@interface HUNetwork : NSObject
{
    NSDictionary *_dict;
}

@property (nonatomic, copy) BLOCK block;

- (void)startRequestWithPath:(NSString *)path Params:(NSDictionary *)params completion:(BLOCK)block errorHandler:(void(^)())errorBlock;





@end
