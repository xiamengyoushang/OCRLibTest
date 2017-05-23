//
//  CollectionReusableView.m
//  OCR-LKTest
//
//  Created by linkiing on 2017/4/6.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sectionLabel = [[UILabel alloc] init];
        _sectionLabel.frame = CGRectMake(15, 5, CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)-10);
        [self addSubview:_sectionLabel];
    }
    return self;
}


@end
