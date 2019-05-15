//
//  HMLinkedList.h
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMLinkedList : NSObject

@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) id data;
@property(nonatomic, strong) HMLinkedList *next;
@property(nonatomic, strong) HMLinkedList *last;

+ (HMLinkedList *)hm_createLinkList;

+ (HMLinkedList *)hm_createLinkListWithURLsArray:(NSArray *)urlArr;

@end
