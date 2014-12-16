//
//  CollectSectionHeaderView.m
//  BaseCollectionView
//
//  Created by Dong on 11/10/14.
//  Copyright (c) 2014 liuxudong. All rights reserved.
//

#import "CollectSectionHeaderView.h"

@implementation CollectSectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)config {
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 20)/ 2, self.frame.size.width, 20)];
    testLabel.font = [UIFont boldSystemFontOfSize:20];
    testLabel.textColor = [UIColor blackColor];
    testLabel.backgroundColor = [UIColor clearColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.text = @"分组";
    [self addSubview:testLabel];
}

@end
