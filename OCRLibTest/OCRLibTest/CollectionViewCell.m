//
//  CollectionViewCell.m
//  SNLights
//
//  Created by linkiing on 17/3/14.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _albumImageview = [[UIImageView alloc] init];
        _albumImageview.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.8);
        _albumImageview.layer.cornerRadius = 3;
        _albumImageview.clipsToBounds = YES;
        _albumImageview.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_albumImageview];
        
        _albumTitleLabel = [[UILabel alloc] init];
        _albumTitleLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame)*0.8, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.2);
        _albumTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        _albumTitleLabel.textAlignment = NSTextAlignmentCenter;
        _albumTitleLabel.textColor = [UIColor whiteColor];
        _albumTitleLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:_albumTitleLabel];
    }
    return self;
}

@end
