//
//  PGGModel.h
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/4.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGTableViewLinkage.git
#import <Foundation/Foundation.h>

@interface PGGModel : NSObject

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *ProvinceName;
@property(strong,nonatomic)NSArray * cities;
@end

@interface PGGCityModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *PID;
@property (nonatomic,copy) NSString *ZipCode;
@property (nonatomic,copy) NSString *CityName;
@end
