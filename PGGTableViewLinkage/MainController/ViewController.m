//
//  ViewController.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/2.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import "ViewController.h"
#import "PGGTwoTable.h"
#import "PGGTableAndCollecton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    createNavUI(self);
    [self pggPushNextViewController];
}

static void createNavUI(ViewController *object) {
    object.navigationItem.title =@"鹏哥哥联动";
        //    设标题上文字颜色
    [object.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    object.navigationController.navigationBar.translucent = NO;
        //    去掉返回按钮的文字 保留<符号
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = nil;
    object.navigationItem.backBarButtonItem = backButtonItem;
    object.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
        //    设置状态栏
    object.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        //    设置导航控制器背景颜色
    object.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    object.view.backgroundColor = [UIColor whiteColor];
}

- (void)pggPushNextViewController{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 50)];
    [btn setTitle:@"TableView联动" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor darkGrayColor]];
    [btn addTarget:self action:@selector(tableNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btncollection = [[UIButton alloc] initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 50)];
    [btncollection setTitle:@"Collection联动" forState:UIControlStateNormal];
    [btncollection setBackgroundColor:[UIColor darkGrayColor]];
    [btncollection addTarget:self action:@selector(collectionNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btncollection];
    
    UIButton *text = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50-64, self.view.frame.size.width, 50)];
    [text setTitle:@"关注鹏哥哥Github 有你想要的 ！！！" forState:UIControlStateNormal];
    [text setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:text];

}

- (void)tableNext{
    PGGTwoTable *table = [PGGTwoTable new];
    [self.navigationController pushViewController:table animated:YES];
}
- (void)collectionNext{
    PGGTableAndCollecton *tableAndC = [PGGTableAndCollecton new];
    [self.navigationController pushViewController:tableAndC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
