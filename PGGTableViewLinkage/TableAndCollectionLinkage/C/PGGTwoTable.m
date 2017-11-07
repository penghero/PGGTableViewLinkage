//
//  PGGTwoTable.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/4.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import "PGGTwoTable.h"
#import "PGGModel.h"
#import <YYModel.h>

static NSString *provinceCellID = @"provinceCellID";
static NSString *cityCellID = @"cityCellID";
@interface PGGTwoTable ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * provinceTableView;//省级列表
@property(strong,nonatomic)UITableView * cityTableView;//市级列表
@property(strong,nonatomic)NSMutableArray * allDataArray;//省级总数据
@property(strong,nonatomic)NSMutableArray * cityDataArray;//市级总数据

@end

@implementation PGGTwoTable
#pragma mark 懒加载
- (NSMutableArray *)allDataArray {
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
- (NSMutableArray *) cityDataArray {
    if (_cityDataArray == nil) {
        _cityDataArray  = [NSMutableArray array];
    }
    return _cityDataArray;
}
- (UITableView *)provinceTableView {
    if (_provinceTableView == nil) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_H)];
        _provinceTableView.dataSource = self;
        _provinceTableView.delegate = self;
        _provinceTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _provinceTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _provinceTableView.showsVerticalScrollIndicator = NO;
        [_provinceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:provinceCellID];
    }
    return _provinceTableView;
}
- (UITableView *) cityTableView {
    if (_cityTableView == nil) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, SCREEN_H)];
        _cityTableView.dataSource = self;
        _cityTableView.delegate = self;
        _cityTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _cityTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _cityTableView.showsVerticalScrollIndicator = NO;
        [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCellID];
    }
    return _cityTableView;
}

#pragma mark delegate
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.provinceTableView) {
        return 50;
    }else{
        return 40;
    }
}
//设置表头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.cityTableView){
        return 20;
    }else{
        return 0;
    }
}
    //设置表头显示内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.cityTableView) {
        UILabel *headerview = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/2, 0, self.cityTableView.frame.size.width, 10)];
        headerview.backgroundColor = [UIColor lightGrayColor];
        PGGModel *model = self.allDataArray[section];
        headerview.text = model.ProvinceName;
        return headerview;
    }
    return nil;
}
//点击响应方法 处理点击左侧 改变右侧显示位置
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        // 判断是否为 左侧 的 tableView
    if (tableView == self.provinceTableView) {
            // 计算出 右侧 tableView 将要 滚动的 位置
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
            // 将 rightTableView 移动到对应的 位置
//        注：动画属性一定要设置为NO 否则 左边显示不准确
        [self.cityTableView scrollToRowAtIndexPath:moveToIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}
#pragma mark UIScrollViewDelegate
//    处理右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        // 如果是 左侧的 tableView 直接return
    if (scrollView == self.provinceTableView) return;
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
    NSIndexPath *topHeaderViewIndexpath = [[self.cityTableView indexPathsForVisibleRows] firstObject];
        // 左侧 talbelView 移动到的位置 indexPath
    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
        // 移动 左侧 tableView 到 指定 indexPath 居中显示
    [self.provinceTableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark datasource
//行数返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.provinceTableView) {
        return self.allDataArray.count;
    }else{
        
        return [self.cityDataArray[section] count];
    }
}
//组数返回
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.provinceTableView) {
        return 1;
    }else {
        return self.allDataArray.count;
    }
}
//cell显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.provinceTableView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:provinceCellID];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:provinceCellID];
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        PGGModel *model = self.allDataArray[indexPath.row];
        cell.textLabel.text = model.ProvinceName;
        return cell;
    }else{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cityCellID];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellID];
    }
        PGGCityModel *cityModel = self.cityDataArray[indexPath.section][indexPath.row];
        cell.textLabel.text = cityModel.CityName;
        return cell;
    }
}
#pragma mark YYModel 解析plist文件
- (void) analysisPlistUse_YYModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Provineces" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in array) {
        PGGModel *proModel = [PGGModel yy_modelWithJSON:dict];
        [self.allDataArray addObject:proModel];
        NSArray *arr = dict [@"cities"];
        NSMutableArray *cityArr = [NSMutableArray array];
        for ( NSDictionary *dic in arr) {
            PGGCityModel *cityModel = [PGGCityModel yy_modelWithJSON:dic];
            [cityArr addObject:cityModel];
        }
        [self.cityDataArray addObject:cityArr];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"TableView联动";
    [self analysisPlistUse_YYModel];
    [self.view addSubview:self.provinceTableView];
    [self.view addSubview:self.cityTableView];
    [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
