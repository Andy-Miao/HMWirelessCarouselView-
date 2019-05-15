//
//  HMNews.h
//  HMCustomView
//
//  Created by 胡苗 on 2016/4/15.
//  Copyright © 2016年 humiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNews : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (id)hm_newsWithDict : (NSDictionary *) dict;

@end
