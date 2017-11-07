//
//  PGGModel.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/4.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGTableViewLinkage.git
#import "PGGModel.h"

@implementation PGGModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cities" : @"PGGCityModel"};
}
@end


@implementation PGGCityModel

@end
