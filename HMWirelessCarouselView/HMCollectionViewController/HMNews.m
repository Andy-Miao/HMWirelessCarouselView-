//
//  HMNews.m
//  HMCustomView
//
//  Created by 胡苗 on 2016/4/15.
//  Copyright © 2016年 humiao. All rights reserved.
//

#import "HMNews.h"

@implementation HMNews

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (id)hm_newsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
