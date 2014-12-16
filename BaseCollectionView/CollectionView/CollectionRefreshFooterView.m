//
//  CollectionFooterView.m
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "CollectionRefreshFooterView.h"

@interface CollectionRefreshFooterView ()

@end

@implementation CollectionRefreshFooterView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config {
    //这里我用你最习惯的方式写
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_indicatorView];
    }
    
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 22) / 2, self.frame.size.width, 22)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.text = @"加载更多";
        _statusLabel.textColor = [UIColor grayColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_statusLabel];
    }
}

#pragma mark - Setter

- (void)setStatus:(PullUpRefreshStatus)status {
    switch (status) {
        case PullUpRefreshNormal:
            _statusLabel.text = @"加载更多";
            [_indicatorView stopAnimating];
            break;
        case PullUpRefreshLoading:
            _statusLabel.text = @"加载中，请稍后...";
            CGSize size = [_statusLabel.text sizeWithFont:_statusLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 22)];
            _indicatorView.frame = CGRectMake((self.frame.size.width - size.width) / 2 - 10 - 30, (self.frame.size.height - 25) / 2, 25, 25);
            [_indicatorView startAnimating];
            break;
        case PullUpRefreshLoadingAll:
            _statusLabel.text = @"已全部加载完成";
            [_indicatorView stopAnimating];
            break;
        default:
            break;
    }
    _status = status;
}
@end
