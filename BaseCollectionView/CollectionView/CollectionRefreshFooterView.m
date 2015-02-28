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
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_indicatorView];
    }
    
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _statusLabel.text = @"加载更多";
        _statusLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _statusLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_statusLabel];
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_statusLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
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
