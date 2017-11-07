//
//  PGGCollectionReusableView.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/6.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import "PGGCollectionReusableView.h"
#import "PGGCollectionModel.h"
@interface PGGCollectionReusableView()

@end

@implementation PGGCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self ) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        self.name.font = [UIFont boldSystemFontOfSize:14];
        self.name.backgroundColor = [UIColor lightGrayColor];
        self.name.alpha = 0.8;
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
    }
    return self;
}
- (void)setName:(UILabel *)name{
    _name = name;
    _name.text = name.text;
}
@end
