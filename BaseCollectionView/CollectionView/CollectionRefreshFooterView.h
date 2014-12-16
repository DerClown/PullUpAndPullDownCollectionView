//
//  CollectionFooterView.h
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PullUpRefreshNormal = 0,    //正常状态
    PullUpRefreshFailed,        //网络加载超时、失败
    PullUpRefreshLoading,       //正在加载中
    PullUpRefreshLoadingAll,        //数据全部加载完成
}PullUpRefreshStatus;       //这个判断上拉加载数据的状态

@interface CollectionRefreshFooterView : UICollectionReusableView {
    UIActivityIndicatorView *_indicatorView; //风火轮
    UILabel *_statusLabel;  //提示当前加载的状态
}

@property (nonatomic, assign) PullUpRefreshStatus status;

@end
