//
//  HMCarouselView.m
//  ManagementPlatform
//
//  Created by 胡苗 on 2017/9/13.
//  Copyright © 2017年 ITUser. All rights reserved.
//

#import "HMCarouselView.h"

@interface HMCarouselView () <UIScrollViewDelegate>{
    
    NSTimeInterval _delayTime;
    NSArray *_imagesArray;
    NSMutableArray *_imageViews;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@end
@implementation HMCarouselView

- (instancetype)initViewWithFrame:(CGRect)frame autoPlayTime:(NSTimeInterval)playTime imageArr:(NSArray *)imageArr clickCallBack:(clickCallBack)clickCallBack {
    
    if (self = [super initWithFrame:frame]) {
        
        _delayTime = playTime? :1;
        self.clickBlock = clickCallBack;
        _imagesArray = imageArr;
        
        [self hm_creatContentView];        
        [self hm_startTimer];
    }
    return self;
}

#pragma mark Creat UI
- (void)hm_creatContentView {
    
    if (_imagesArray.count == 0) {
        return ;
    }
    _imageViews = [NSMutableArray array];
    [self addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(CURREENT_SCREEN_WIDTH * i, 0, CURREENT_SCREEN_WIDTH,CGRectGetHeight(self.frame));
        imageView.tag = (_imagesArray.count - 1 + i)%_imagesArray.count;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hm_imageViewClicked:)];
        [imageView addGestureRecognizer:tap];
        [self hm_setImageWithImageView:imageView];
        [_imageViews addObject:imageView];
        [self.scrollView addSubview:imageView];
        
    }
    
    [self addSubview:self.pageControl];
}

- (void)hm_setImageWithImageView:(UIImageView *)imageView {
    UIImage *image = [UIImage imageNamed:_imagesArray[imageView.tag]];
    imageView.image = image;
}

#pragma mark - add NStimer
- (void)hm_startTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:_delayTime target:self selector:@selector(hm_nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (void)hm_stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hm_stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self hm_startTimer];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self hm_updateImageViewsAndPageControl];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self hm_updateImageViewsAndPageControl];
}


#pragma mark - 更新图片和分页控件的当前页
- (void)hm_updateImageViewsAndPageControl {
    
    if (_imageViews.count == 0) {
        return;
    }
    
    int flag = 0;
    if (self.scrollView.contentOffset.x > CURREENT_SCREEN_WIDTH) {
        flag = 1;
    } else if (self.scrollView.contentOffset.x == 0) {
        flag = -1;
    } else {
        return;
    }

    for (UIImageView *imageView in _imageViews) {
        NSInteger index = imageView.tag + flag ;
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        [self hm_setImageWithImageView:imageView];
    }
    
    self.pageControl.currentPage = [_imageViews[1] tag];
    self.scrollView.contentOffset = CGPointMake(CURREENT_SCREEN_WIDTH, 0);
}


#pragma mark - event
- (void)hm_imageViewClicked:(UITapGestureRecognizer *)tap
{
    int index = (int)tap.view.tag;
    if (_clickBlock) {
        _clickBlock(index);
    }
}

- (void)hm_nextPage {
    [self.scrollView setContentOffset:CGPointMake(CURREENT_SCREEN_WIDTH*2, 0) animated:YES];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(CURREENT_SCREEN_WIDTH * 3, FIT_HEIGHT(CGRectGetHeight(self.frame)));
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentOffset = CGPointMake(CURREENT_SCREEN_WIDTH, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 20, CURREENT_SCREEN_WIDTH, 20)];
        _pageControl.numberOfPages = _imagesArray.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = COLOR_FROM_RGB(0xc5c5c5);
        _pageControl.enabled = NO;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

@end
