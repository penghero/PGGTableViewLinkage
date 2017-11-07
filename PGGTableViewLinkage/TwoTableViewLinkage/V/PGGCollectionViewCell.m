//
//  PGGCollectionViewCell.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/6.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGTableViewLinkage.git
#import "PGGCollectionViewCell.h"
#import "PGGCollectionModel.h"
#import <UIImageView+WebCache.h>
@interface PGGCollectionViewCell ()

@property(strong,nonatomic)UIImageView * icon_Img;
@property(strong,nonatomic)UILabel * name;

@end
@implementation PGGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.icon_Img = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.icon_Img.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.icon_Img];
        self.name = [[UILabel alloc] initWithFrame:CGRectZero];
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}
//set方法 重写
- (void)setIsGrid:(BOOL)isGrid{
    if (isGrid) {
        self.icon_Img.frame = CGRectMake(5, 5,self.bounds.size.width-10  , self.bounds.size.height-30);
        self.name.frame = CGRectMake(5 , self.bounds.size.height-30 ,self.bounds.size.width -10, 30);
    }else{
        self.icon_Img.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 30);
        self.name.frame = CGRectMake(5,self.bounds.size.height- 30,self.bounds.size.width-10 ,30);;
    }
}
- (void) setModel:(PGGCollectionNextModel *)model {
    [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.name.text = model.name;
}

@end
