//
//  PGGCollectionModel.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/6.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGTableViewLinkage.git
#import "PGGCollectionModel.h"

@implementation PGGCollectionModel
//yymodel的方法 解析完成后调用 返回指定数据类型
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"subcategories" : @"PGGCollectionNextModel"};
}
@end


@implementation PGGCollectionNextModel

@end
