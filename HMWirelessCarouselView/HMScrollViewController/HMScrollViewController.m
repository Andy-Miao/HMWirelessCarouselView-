//
//  HMScrollViewController.m
//  HMWirelessCarouselView
//
//  Created by humiao on 2019/4/15.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMScrollViewController.h"
#import "HMCarouselView.h"

@interface HMScrollViewController () {
    NSArray *_imageNames;
}

@property (nonatomic, strong) HMCarouselView *carouselView;
@end

@implementation HMScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageNames = @[@"cat1",@"cat2",@"cat3",@"cat4",@"cat5"];
//    _imageNames = @[@"live_bg",@"live_bg",@"live_bg",@"live_bg",@"live_bg"];
    
    [self.view addSubview:self.carouselView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HMCarouselView *)carouselView {
    if (!_carouselView) {
        _carouselView = [[HMCarouselView  alloc] initViewWithFrame:CGRectMake(0,NAV_STATE_HEIGHT, CURREENT_SCREEN_WIDTH, FIT_HEIGHT(480)) autoPlayTime:5 imageArr:_imageNames clickCallBack:^(int imageViewTag) {
            NSLog(@"当前点击的图片:%d",imageViewTag);
        }];
    }
    return _carouselView;
}

@end
