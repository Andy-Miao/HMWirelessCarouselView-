//
//  HMCollectionViewController.m
//  HMCustomView
//
//  Created by humiao on 2016/4/15.
//  Copyright © 2016年 humiao. All rights reserved.
//

#import "HMCollectionViewController.h"
#import "HMCollectionViewCell.h"
#import "HMNews.h"

@interface HMCollectionViewController ()
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *hmNewses;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation HMCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSUInteger const MAX_SECTIONS = 2;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self hm_setupView];
 
}

- (void)hm_setupView {
    self.collectionView.frame = CGRectMake(0, NAV_STATE_HEIGHT, CURREENT_SCREEN_WIDTH, FIT_HEIGHT(480));
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[HMCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MAX_SECTIONS/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, NAV_STATE_HEIGHT + FIT_HEIGHT(480) - 40, CURREENT_SCREEN_WIDTH, 40);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = COLOR_FROM_RGB(0xc5c5c5);
    pageControl.enabled = NO;
    pageControl.numberOfPages = _hmNewses.count;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    [self hm_addTimer];
}

#pragma mark 添加定时器
-(void)hm_addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hm_nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}

#pragma mark 删除定时器
-(void)hm_removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)hm_nextpage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MAX_SECTIONS/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.hmNewses.count) {
        nextItem=0;
        nextSection++;
    }
    if (nextSection == MAX_SECTIONS) {
        [self hm_removeTimer];
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}

#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MAX_SECTIONS;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hmNewses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(!cell){
        cell = [[HMCollectionViewCell alloc] init];
    }
    cell.news = self.hmNewses[indexPath.item];
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self hm_removeTimer];
}

#pragma mark 当用户停止的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self hm_addTimer];
}

#pragma mark 设置页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.hmNewses.count;
    self.pageControl.currentPage =page;
}


- (NSArray *)hmNewses {
    if (!_hmNewses) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path =[bundle pathForResource:@"resource.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _hmNewses = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [_hmNewses addObject:[HMNews hm_newsWithDict:dict]];
        }
    }
    return  _hmNewses;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
