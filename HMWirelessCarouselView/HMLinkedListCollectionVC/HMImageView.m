//
//  HMImageView.m
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMImageView.h"

NSString * const IMAGE_KEY = @"imageKey";
NSString * const TITLE_KEY = @"titleKey";
@implementation HMImageView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self hm_setupView];
    }
    return self;
}

- (void)hm_setupView {
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 30, self.bounds.size.width - 80, 20)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}
- (void)setImageDic:(NSDictionary *)imageDic {
    _imageDic = imageDic;
    
    [_imageView setImage:(UIImage *)_imageDic[IMAGE_KEY]];
    if ([_imageDic[TITLE_KEY] isEqualToString:@""]) {
        _titleLabel.hidden = YES;
    } else {
        _titleLabel.hidden = NO;
        _titleLabel.text = _imageUrlDic[TITLE_KEY];
    }
}
- (void)setImageUrlDic:(NSDictionary *)imageUrlDic {
    _imageUrlDic = imageUrlDic;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlDic[IMAGE_KEY]]];
     if ([_imageUrlDic[TITLE_KEY] isEqualToString:@""]) {
         _titleLabel.hidden = YES;
     } else {
         _titleLabel.hidden = NO;
         _titleLabel.text = _imageUrlDic[TITLE_KEY];
     }
}
     

@end
