//
//  HMLinkedList.m
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMLinkedList.h"

@implementation HMLinkedList
+ (HMLinkedList *)hm_createLinkList {
    HMLinkedList *head = [[HMLinkedList alloc] init];
    head.data = [NSNumber numberWithInt:0];
    HMLinkedList *ptr = head;
    for (int i=1; i<10; i++){
        HMLinkedList *node = [[HMLinkedList alloc] init];
        node.data = [NSNumber numberWithInt:i];
        ptr.next = node;
        node.last = ptr;
        ptr = node;
    }
    head.last = ptr;
    ptr.next = head;
    return head;
}

+ (HMLinkedList *)hm_createLinkListWithURLsArray:(NSArray *)urlArr {
    HMLinkedList *head = [[HMLinkedList alloc] init];
    head.data = [urlArr firstObject];
    head.index = 0;
    HMLinkedList *ptr = head;
    for (int i=1; i<urlArr.count; i++){
        HMLinkedList *node = [[HMLinkedList alloc] init];
        node.index = i;
        node.data = [urlArr objectAtIndex:i];
        ptr.next = node;
        node.last = ptr;
        ptr = node;
    }
    head.last = ptr;
    ptr.next = head;
    return head;
}

@end
