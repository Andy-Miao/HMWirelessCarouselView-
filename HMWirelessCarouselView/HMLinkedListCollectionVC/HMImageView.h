//
//  HMImageView.h
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const IMAGE_KEY;
FOUNDATION_EXPORT NSString *const TITLE_KEY;
@interface HMImageView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSDictionary *imageUrlDic;
@property (nonatomic, strong) NSDictionary *imageDic;
@end
