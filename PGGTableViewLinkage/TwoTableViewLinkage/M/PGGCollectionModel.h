//
//  PGGCollectionModel.h
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/6.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 商品模型
 */
@interface PGGCollectionModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *order;
@property (nonatomic,copy) NSString *status;
@property(strong,nonatomic)NSMutableArray * subcategories;

@end

@interface PGGCollectionNextModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *order;
@property (nonatomic,copy) NSString *icon_url;

@end
