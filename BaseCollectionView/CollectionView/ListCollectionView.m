//
//  ListCollectionView.m
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "ListCollectionView.h"
#import "BaseCollectionCell.h"
#import "CollectSectionHeaderView.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface ListCollectionView()<CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ListCollectionView

- (id)initWithFrame:(CGRect)frame delegate:(id<BaseCollectionViewDelegate>)delegate {
    CHTCollectionViewWaterfallLayout *collectionLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    collectionLayout.columnCount = 2;
    collectionLayout.headerHeight = 50;
    collectionLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    return [self initWithFrame:frame collectionViewLayout:collectionLayout delegate:delegate];
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout delegate:(id<BaseCollectionViewDelegate>)delegate {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self registerClass:[BaseCollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [self registerClass:[CollectSectionHeaderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:CHTCollectionElementKindSectionHeader];
        self.aDelegate = delegate;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UICollectionView Delegate && Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

/**
 *  section返回cell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else{
        return self.valueContexts.count;
    }
}

/**
 *  返回UICollectionViewCell
 *
 *  @param collectionView UICollectionView本身
 *  @param indexPath      返回的cell在那个位置（section， row）
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionCell *cell = (BaseCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

/**
 *  这个就是返回一个footView 或者是一个SectionHeaderView
 *
 *  @param collectionView UICollectionView本身
 *  @param kind           通过判断这个king字符串判断是footView还是SectionheaderView
 *  @param indexPath      这个可以拿到section和section中第几个cell，通过这个可是设置sectionheadview一些信息
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView;
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHTCollectionElementKindSectionFooter forIndexPath:indexPath];
        _refreshFooterView = (CollectionRefreshFooterView *)reusableView;
    } else {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CHTCollectionElementKindSectionHeader forIndexPath:indexPath];
    }
    
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.aDelegate collectionView:self didSelectItemAtIndexPath:indexPath];
    }
    
    self.block(indexPath);
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/**
 *  这个方法就是设置UICollectionViewCell的大小
 *
 *  @param collectionView       UICollectionView本身
 *  @param collectionViewLayout 这个UIColletionView的Layout，自适应
 *  @param indexPath            第几个cell
 *
 *  @return 返回UICollectionViewCell 的大小：size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.frame.size.width - 30) / 2, 100);
}

@end
