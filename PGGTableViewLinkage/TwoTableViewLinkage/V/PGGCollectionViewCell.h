//
//  PGGCollectionViewCell.h
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/6.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PGGCollectionNextModel;
@interface PGGCollectionViewCell : UICollectionViewCell
/**
 自定义的cell   0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isGrid;

@property(strong,nonatomic)PGGCollectionNextModel * model;

@end
