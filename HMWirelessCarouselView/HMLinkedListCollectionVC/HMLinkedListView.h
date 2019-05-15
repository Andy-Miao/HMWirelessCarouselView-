//
//  HMLinkedListView.h
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickedImageBlock)(NSInteger currentIndex);
@interface HMLinkedListView : UITableViewCell

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, assign) BOOL autoScroll;                //是否自动滚动,默认Yes
@property (nonatomic, assign) CGFloat autoScrollTimeInterval; //自动滚动间隔时间,默认5s
//image数组初始化
+ (instancetype)hm_initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr clickBlock:(ClickedImageBlock)block;
+ (instancetype)hm_initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block;

//url数组初始化
+ (instancetype)hm_initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr clickBlock:(ClickedImageBlock)block;
+ (instancetype)hm_initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block;

@end
