//
//  HMCarouselView.h
//  ManagementPlatform
//
//  Created by 胡苗 on 2017/9/13.
//  Copyright © 2017年 ITUser. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCallBack)(int imageViewTag);
@interface HMCarouselView : UIView

@property (nonatomic, copy) clickCallBack clickBlock;

- (instancetype)initViewWithFrame:(CGRect)frame autoPlayTime:(NSTimeInterval)PlayTime imageArr:(NSArray *)imageArr clickCallBack:(clickCallBack)clickCallBack;


@end
