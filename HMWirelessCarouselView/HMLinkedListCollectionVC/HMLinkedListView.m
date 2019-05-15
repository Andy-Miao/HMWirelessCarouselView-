//
//  HMLinkedListView.m
//  HMWirelessCarouselView
//
//  Created by 胡苗 on 2019/4/16.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMLinkedListView.h"
#import "HMImageView.h"
#import "HMLinkedList.h"

@interface HMLinkedListView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) HMImageView *leftImageView;
@property (nonatomic, strong) HMImageView *centerImageView;
@property (nonatomic, strong) HMImageView *rightImageView;

@property (nonatomic, assign) BOOL isMove;
@property (nonatomic, assign) BOOL isLocalImage;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) HMLinkedList *ptr;
@property (nonatomic, strong) HMLinkedList *nowPtr;
@property (nonatomic, copy) ClickedImageBlock cellClickblock;
//轮播
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation HMLinkedListView

#pragma mark-------------------初始化方法----
//image数组初始化
+ (instancetype)hm_initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:YES imgArrs:imageArr titArr:nil clickBlock:block];
}
+ (instancetype)hm_initWithFrame:(CGRect)frame imageArrs:(NSArray<UIImage *> *)imageArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:YES imgArrs:imageArr titArr:titleArr clickBlock:block];
}

//url数组初始化
+ (instancetype)hm_initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:NO imgArrs:urlArr titArr:nil clickBlock:block];
}
+ (instancetype)hm_initWithFrame:(CGRect)frame imageUrlArrs:(NSArray<NSString *> *)urlArr titles:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    return [[self alloc] initWithFrame:frame isLocalImage:NO imgArrs:urlArr titArr:titleArr clickBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame isLocalImage:(BOOL)isLocalImage imgArrs:(NSArray *)urlArr titArr:(NSArray *)titleArr clickBlock:(ClickedImageBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _isLocalImage = isLocalImage;
        _dataCount = urlArr.count;
        _cellClickblock = block;
        _totalItemsCount = urlArr.count;
        
        NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < urlArr.count; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
            [dic setObject:urlArr[i] forKey:IMAGE_KEY];
            if (titleArr == nil || titleArr == (NSArray *) [NSNull null]) {
                [dic setObject:@"" forKey:TITLE_KEY];
            } else {
                [dic setObject:titleArr[i] forKey:TITLE_KEY];
            }
            [dataArr addObject:dic];
        }
        _ptr = [HMLinkedList hm_createLinkListWithURLsArray:dataArr];
   
        [self initData];
        [self createView];
    }
    return self;
}

- (void)initData {
    _isMove = NO;
    _nowPtr = nil;
    _autoScroll = YES;
    _autoScrollTimeInterval = 5.f;
}

- (void)createView {
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _myScrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _myScrollView.backgroundColor = [UIColor clearColor];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.delegate = self;
    _myScrollView.scrollsToTop = NO;
    [self addSubview:_myScrollView];
    
    _leftImageView = [[HMImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self hm_controlView:_leftImageView data:_ptr.last];
    [_myScrollView addSubview:_leftImageView];
    _centerImageView = [[HMImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self hm_controlView:_centerImageView data:_ptr];
    [_myScrollView addSubview:_centerImageView];
    _rightImageView = [[HMImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    [self hm_controlView:_rightImageView data:_ptr.next];
    [_myScrollView addSubview:_rightImageView];
    
    [_myScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    _dataCount == 1 ? [_myScrollView setScrollEnabled:NO] : [self hm_setupTimer];
    _dataCount == 1 ? :[self hm_createPageControl];
    
    UITapGestureRecognizer * tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlockAction)];
    [self addGestureRecognizer:tapAction];
}

- (void)hm_createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 10 - 60, self.bounds.size.height - 10 - 20, 60, 20)];
    pageControl.numberOfPages = _dataCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = _ptr.index;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)hm_controlView:(HMImageView *)imageV data:(HMLinkedList *)listPoint {
    if (_isLocalImage) {
        imageV.imageDic = listPoint.data;
    } else {
        imageV.imageUrlDic = listPoint.data;
    }
}

- (void)clickBlockAction {
    if (_cellClickblock) {
        _cellClickblock(_ptr.index);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x <= 0 || scrollView.contentOffset.x >= 2 * self.bounds.size.width) {
        if (!_isMove) {
            _isMove = YES;
            _nowPtr = _ptr;
        }
        
        if (scrollView.contentOffset.x <= 0) {
            _ptr = _nowPtr.last;
        } else {
            _ptr = _nowPtr.next;
        }
        [self hm_controlView:_leftImageView data:_ptr.last];
        [self hm_controlView:_centerImageView data:_ptr];
        [self hm_controlView:_rightImageView data:_ptr.next];
        
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO]; //切换到下标1的cell
        _isMove = NO;
        _pageControl.currentPage = _ptr.index;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self hm_invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self hm_setupTimer];
    }
}

#pragma mark - actions

- (void)hm_setupTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(hm_automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)hm_automaticScroll {
    if (0 == _totalItemsCount) return;
    [_myScrollView setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
}

- (void)hm_invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - setter/getter
- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    [self hm_invalidateTimer];
    
    if (_autoScroll) {
        [self hm_setupTimer];
    }
}

- (void)setPageControl:(UIPageControl *)pageControl {
    [_pageControl removeFromSuperview];
    _pageControl = nil;
    _pageControl = pageControl;
    _pageControl.numberOfPages = _dataCount;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPage = _ptr.index;
    [self addSubview:_pageControl];
}

- (void)setShowPageControl:(BOOL)showPageControl {
}

@end
