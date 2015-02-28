//
//  ViewController.m
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "ViewController.h"
#import "BaseCollectionView.h"
#import "ListCollectionView.h"

@interface ViewController ()<BaseCollectionViewDelegate>

@property (nonatomic, strong)ListCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _collectionView = [[ListCollectionView alloc] initWithFrame:self.view.bounds delegate:self];
    //_collectionView.scrollEnabled = YES;
    _collectionView.isShowRefreshFooterView = YES;
    //_collectionView.isShowRefreshHeaderView = YES;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    _collectionView.valueContexts = @[@"1",@"1",@"2",@"1",@"1",@"2",@"1",@"1",@"2",@"1",@"2",@"1",@"1",@"2"];
    __block UIAlertView *alert;
    __block NSArray *array = _collectionView.valueContexts;
    _collectionView.block = ^(NSIndexPath *indexPath) {
        alert = [[UIAlertView alloc] initWithTitle:@"" message:array[indexPath.row] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[_collectionView startPullDown];
}

#pragma mark - BaseCollectionViewDelegate

- (void)collectionViewStartPullDownLoading:(BaseCollectionView *)collectionView {
    //开始加载数据的方法，[self loadingData]; 暂时又下面的方法代替
    [self performSelector:@selector(refreshFinish) withObject:nil afterDelay:5];
}

/**
 *  下拉数据加载成功的时候调用
 */
- (void)refreshFinish {
    [_collectionView pullDownDidFinishLoading];
}

- (void)collectionViewStartPullUpLoading:(BaseCollectionView *)collectionView {
    //下拉同理
    [self performSelector:@selector(pullupFinish) withObject:nil afterDelay:3];
}

/**
 *  这里多试一试那个下拉完成的状态；这个的作用就是上拉加载数据完成的时候调用
 */
- (void)pullupFinish {
    [_collectionView pullUpDidFinishLoadingWithStatus:PullUpRefreshNormal];
}

- (void)collectionView:(BaseCollectionView *)baseCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
