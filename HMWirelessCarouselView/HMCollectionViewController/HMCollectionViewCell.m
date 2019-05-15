//
//  HMCollectionViewCell.m
//  HMCustomView
//
//  Created by 胡苗 on 2016/4/15.
//  Copyright © 2016年 humiao. All rights reserved.
//

#import "HMCollectionViewCell.h"
#import "HMNews.h"

@interface HMCollectionViewCell ()

@property (nonatomic, strong)  UILabel *titleL;
@property (nonatomic, strong)  UIImageView *imageView;

@end
@implementation HMCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
      
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleL];
    }
    return self;
}

- (void)setNews:(HMNews *)news {
    _news = news;
    self.titleL.text = _news.title;
    self.imageView.image = [UIImage imageNamed:_news.icon];
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(0, 0, CURREENT_SCREEN_WIDTH, CGRectGetHeight(self.frame));
    self.imageView.frame = CGRectMake(0, 0, CURREENT_SCREEN_WIDTH, CGRectGetHeight(self.frame));
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:30];
        _titleL.textColor = [UIColor whiteColor];
       _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
