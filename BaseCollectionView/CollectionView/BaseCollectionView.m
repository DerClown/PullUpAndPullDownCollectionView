//
//  BaseCollectionView.m
//  BaseCollectionView
//
//  Created by Dong on 11/6/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "BaseCollectionView.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface BaseCollectionView ()<EGORefreshTableHeaderDelegate>

@end

@implementation BaseCollectionView

- (void)pullDownDidFinishLoading {
    _isPullDownLoading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)pullUpDidFinishLoadingWithStatus:(PullUpRefreshStatus)status {
    _isPullUpLoading = NO;
    _refreshFooterView.status = status;
}

- (void)startPullDown {
    [UIView animateWithDuration:0.25 animations:^{
        [self setContentOffset:CGPointMake(0, -65) animated:NO];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDragging:self willDecelerate:NO];
    }];
}

#pragma mark UIScrollViewDelegate

/**
 *  下面两个是方法是用于EGO判断拖拽的ScrollView到达一定的高度时候，才改变加载的状态，去出发加载数据的协议方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     *  egoRefresh did scroll
     */
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    /**
     *  pull up did scroll
     */
    [self pullUpScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

/**
 *  上拉加载数据
 *
 *  @param scrollView self
 */
- (void)pullUpScrollViewDidScroll:(UIScrollView *)scrollView {
    /**
     *  判断当前是否正在加载中，yes就返回；或者判断是否所有数据都加在完成，加载完成就返回！不触发上拉加载协议方法
     */
    if (!_isPullUpLoading && _refreshFooterView.status != PullUpRefreshLoadingAll) {
        
        //scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 25) 这个我来说明一下scrollView.contentSize.height - scrollView.frame.size.height这段剪出来的就是CollctionView的固定高度；加上25就是为了让scrollView.contentOffset.y 超过 CollctionView的固定高度 + 25个像素的时候，就触发上拉加载协议方法
        
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 50)) {
            if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(collectionViewStartPullUpLoading:)]) {
                [self.aDelegate collectionViewStartPullUpLoading:self];
            }
            [_refreshFooterView setStatus:PullUpRefreshLoading];
        }
    }
}

#pragma mark EGORefreshTableHeaderDelegate Methods
/**
 *  开始拖拽UICollctionView，判断协议是否有实现，如果实现就执行下拉加载数据协议
 */
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    _isPullDownLoading = YES;
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(collectionViewStartPullDownLoading:)]) {
        [self.aDelegate collectionViewStartPullDownLoading:self];
    }
}

/**
 *  设置当前加载的状态为loading，数据还没有加载完成时，再次上拉的时候，不会出发第二次下拉加载数据
 *
 */
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _isPullDownLoading;
}

/**
 *  设置更新的时间，直接返回一个日期就可以！日期格式可以在EGO里面修改
 */
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

#pragma mark - Privates

/**
 *  创建下拉加载控件方法
 */
- (void)createRefreshHeaderView {
    if (_isShowRefreshHeaderView) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        _refreshHeaderView.delegate = self;
        [self addSubview:_refreshHeaderView];
    } else {
        [_refreshHeaderView removeFromSuperview];
        _refreshHeaderView = nil;
    }
}

/**
 *  创建上拉加载刷新控件方法
 */
- (void)createRefreshFooterView {
    if (_isShowRefreshFooterView) {
        [self registerClass:[CollectionRefreshFooterView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:CHTCollectionElementKindSectionFooter];
    } else {
        [_refreshFooterView removeFromSuperview];
        _refreshFooterView = nil;
    }
}

#pragma mark - Setter

- (void)setIsShowRefreshHeaderView:(BOOL)isShowRefreshHeaderView {
    _isShowRefreshHeaderView = isShowRefreshHeaderView;
    [self createRefreshHeaderView];
}

- (void)setIsShowRefreshFooterView:(BOOL)isShowRefreshFooterView {
    _isShowRefreshFooterView = isShowRefreshFooterView;
    [self createRefreshFooterView];
}

@end
