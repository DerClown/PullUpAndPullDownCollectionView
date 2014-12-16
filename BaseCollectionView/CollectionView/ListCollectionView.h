//
//  ListCollectionView.h
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "BaseCollectionView.h"

@interface ListCollectionView : BaseCollectionView

/**
 *  初始化方法；默认的设置，不需要设置
 *
 *  @param frame    CHTCollectionViewWaterfallLayout
 *  @param delegate 上拉、下拉和选中协议
 *
 *  @return 返回一个UICollectionView
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<BaseCollectionViewDelegate>)delegate;
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout delegate:(id<BaseCollectionViewDelegate>)delegate;

@end
