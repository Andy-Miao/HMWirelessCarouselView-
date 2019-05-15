//
//  HMLinkedListCollectionVC.m
//  HMWirelessCarouselView
//
//  Created by humiao on 2019/4/15.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMLinkedListCollectionVC.h"
#import "HMLinkedListView.h"
#import "HMNews.h"
@interface HMLinkedListCollectionVC ()
@property (nonatomic, strong) HMLinkedListView *listView;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation HMLinkedListCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HMLinkedListView *)listView {
    if (!_listView) {
        _listView = [HMLinkedListView hm_initWithFrame:CGRectMake(0, NAV_STATE_HEIGHT, CURREENT_SCREEN_WIDTH, FIT_HEIGHT(480)) imageArrs:self.images clickBlock:^(NSInteger currentIndex) {
            NSLog(@"hm___当前点击的：%ld",(long)currentIndex);
        }];
    }
    return _listView;
}

- (NSMutableArray *)images {
    if (!_images) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path =[bundle pathForResource:@"resource.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _images = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            HMNews *hmNew = [HMNews hm_newsWithDict:dict];
            [_images addObject:[UIImage imageNamed:hmNew.icon]];
        }
    }
    return _images;
}
@end
