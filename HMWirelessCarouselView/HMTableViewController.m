//
//  HMTableViewController.m
//  HMWirelessCarouselView
//
//  Created by humiao on 2019/4/15.
//  Copyright © 2019年 humiao. All rights reserved.
//

#import "HMTableViewController.h"
#import "HMScrollViewController.h"
#import "HMCollectionViewController.h"
#import "HMLinkedListCollectionVC.h"

static NSString *cell_id = @"cell_id";
@interface HMTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *classNames;
@end

@implementation HMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    
    self.dataSource = @[@"HMScrollView轮播",@"HMCollectionView轮播",@"HMLinkedLis轮播"];
    self.classNames = @[@"HMScrollViewController",@"HMCollectionViewController",@"HMLinkedListCollectionVC"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 1) {
        UIViewController *vc = [NSClassFromString(self.classNames[indexPath.row]) new];
        vc.navigationItem.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CURREENT_SCREEN_WIDTH, FIT_HEIGHT(480));
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        UICollectionViewController *vc = [[NSClassFromString(self.classNames[indexPath.row]) alloc] initWithCollectionViewLayout:flowLayout];
        vc.navigationItem.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
