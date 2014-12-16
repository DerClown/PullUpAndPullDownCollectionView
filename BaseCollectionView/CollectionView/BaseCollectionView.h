//
//  BaseCollectionView.h
//  BaseCollectionView
//
//  Created by Dong on 11/6/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "CollectionRefreshFooterView.h"

typedef void (^CollectionCellSelectBlock)(NSIndexPath *indexPath);

@class BaseCollectionView;

@protocol BaseCollectionViewDelegate <NSObject>

/**
 *  开始下拉， 在VC中实现该协议，然后执行加载数据方法
 *
 *  @param collectionView BaseCollectionView对象本身
 */
- (void)collectionViewStartPullDownLoading:(BaseCollectionView *)collectionView;

/**
 *  开始上拉，在VC中实现该协议， 然后执行上拉加载数据方法
 *
 *  @param collectionView BaseCollectionView对象本身
 */
- (void)collectionViewStartPullUpLoading:(BaseCollectionView *)collectionView;

/**
 *  选中第几个cell
 *
 *  @param baseCollectionView UICollectionView对象本身
 *  @param indexPath          选中的是第几个对象
 */
- (void)collectionView:(BaseCollectionView *)baseCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseCollectionView : UICollectionView {
    /**
     *  第三方下拉控件;这里也可以使用系统的UIRefreshControl（这个也比较简单，效果也还可以；下次实现）
     */
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    /**
     *  上拉控件 集成UICollectionReusAbleView
     */
    CollectionRefreshFooterView *_refreshFooterView;
    
    /**
     *  判断是否正在下拉加载中，如果加载中继续上拉的时候，不出再次出发加载数据方法
     */
    BOOL _isPullDownLoading;
    
    /**
     *  判断是否正在上拉加载中，如果加载中，再次上拉加载的时候，不会出发上拉记在数据方法
     */
    BOOL _isPullUpLoading;
}

@property (nonatomic, strong) NSArray *valueContexts;
/**
 *  如果为yes,则打开下拉，反着为no
 */
@property (nonatomic, assign) BOOL isShowRefreshHeaderView;

/**
 *  如果为yes，则打开上拉刷新
 */
@property (nonatomic, assign) BOOL isShowRefreshFooterView;

@property (nonatomic, assign) id<BaseCollectionViewDelegate>aDelegate;

@property (nonatomic, copy) CollectionCellSelectBlock block;

/**
 *  上拉加载完成调用
 */
- (void)pullDownDidFinishLoading;

/**
 *  下拉数据加载完成调用
 *
 *  @param status 通过设置状态修改当提示字符
 */
- (void)pullUpDidFinishLoadingWithStatus:(PullUpRefreshStatus)status;

@end
