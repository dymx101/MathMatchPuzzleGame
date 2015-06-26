//
//  MMXLessonTableViewCell.m
//  MathMatch
//
//  Created by Kyle O'Brien on 2014.5.19.
//  Copyright (c) 2014 Computer Lab. All rights reserved.
//

#import "MMXLessonTableViewCell.h"

@interface MMXLessonTableViewCell () {
    UIView      *_bottomLine;
}

@end

@implementation MMXLessonTableViewCell


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
}

@end
