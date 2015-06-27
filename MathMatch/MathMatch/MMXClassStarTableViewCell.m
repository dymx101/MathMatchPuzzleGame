//
//  MMXClassStarTableViewCell.m
//  MathMatch
//
//  Created by Kyle O'Brien on 2014.5.18.
//  Copyright (c) 2014 Computer Lab. All rights reserved.
//

#import "MMXClassStarTableViewCell.h"

@interface MMXClassStarTableViewCell () {
    UIView      *_bottomLine;
}

@property (nonatomic, strong) CustomBadge     *badge;

@end

@implementation MMXClassStarTableViewCell


-(void)awakeFromNib {
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.contentView addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(20);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.height.equalTo(@0.5);
    }];
    
    _badge = [CustomBadge customBadgeWithString:@" "];
    [self.contentView addSubview:_badge];
    [_badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_trailing).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

-(void)setBadgeText:(NSString *)text {
    if (text.length > 0) {
        _badge.hidden = NO;
        [_badge autoBadgeSizeWithString:text];
    } else {
        _badge.hidden = YES;
    }
}

@end
