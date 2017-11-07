//
//  PGGTableAndCollecton.m
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/4.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGTableViewLinkage.git
#import "PGGTableAndCollecton.h"
#import "PGGCollectionModel.h"
#import "PGGCollectionViewCell.h"
#import "PGGCollectionReusableView.h"
#import <YYModel.h>
static NSString *tableViewCellID = @"tableViewCellID";
static NSString *collectionViewCellID = @"collectionViewCellID";
static NSString *CollectionViewHeaderViewID = @"CollectionViewHeaderViewID";
@interface PGGTableAndCollecton ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;//左侧列表
@property (nonatomic, strong) UICollectionView *collectionView;//右侧详细数据列表
@property (nonatomic, strong) NSMutableArray *dataSource; //总数据
@property (nonatomic, strong) NSMutableArray *collectionDatas;//右侧详细列表数据
@property(strong,nonatomic)UIButton * rightButton;;//tabbarItem的自定义按钮

@end

@implementation PGGTableAndCollecton
{
    BOOL _isGrid; //网格与列表切换
    NSInteger _selectIndex;//记录位置
    BOOL _isScrollDown;//滚动方向
}
#pragma mark 懒加载
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)collectionDatas {
    if (_collectionDatas == nil) {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}
- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        [_rightButton setTitle:@"列表" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(isGrilAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/3, SCREEN_H)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = 55;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.separatorColor = [UIColor clearColor];
//        注册
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellID];
        }
    return _tableView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowlayout.minimumInteritemSpacing = 2;
        flowlayout.minimumLineSpacing = 2;
        flowlayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_W/3 , 0 , SCREEN_W/3*2, SCREEN_H) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
//            注册cell
        [_collectionView registerClass:[PGGCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
//            注册分区头标题
        [_collectionView registerClass:[PGGCollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:CollectionViewHeaderViewID];
        }
    return _collectionView;
}
#pragma mark tableViewDelegate And dataSource
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    PGGCollectionModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
// 选中 处理collectionView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    CGRect headerRect = [self frameForHeaderForSection:_selectIndex];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (CGRect)frameForHeaderForSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}
#pragma mark collectionDelegte And dataSource
// 设置组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
// 设置section数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionDatas[section] count];
}
// 设置cell显示内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PGGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    PGGCollectionNextModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    cell.isGrid = _isGrid;
    cell.model = model;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
// 设置cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isGrid) {
        return CGSizeMake((SCREEN_W/3*2 -6) / 2, (SCREEN_W/3*2 - 6) / 2 + 40);
    } else {
        return CGSizeMake(SCREEN_W/3*2-3 , (SCREEN_W/3*2 - 6) / 4 + 80);
    }
}
//分区视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PGGCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CollectionViewHeaderViewID forIndexPath:indexPath];
        PGGCollectionModel *model = self.dataSource[indexPath.section];
        view.name.text = model.name;
        reusableview = view;
        }
    return reusableview;
}
// 设定collectionView的分区头视图frame
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_W/3*2-2, 30);
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//         当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
//         当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}
// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UIScrollView Delegate
//     标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
//滑动动画
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGAffineTransform tran = CGAffineTransformMakeTranslation(cell.transform.tx, cell.transform.ty + 70);
    cell.transform = tran;
    [UIView animateWithDuration:0.8 animations:^{
        cell.transform = CGAffineTransformMakeTranslation(cell.transform.tx, cell.transform.ty - 70);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    _isGrid = NO;
    _selectIndex = 0;
    _isScrollDown = YES;
    self.navigationItem.title = @"TableAndCollection联动";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    [self analysisPlistUse_YYModel];

    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark  使用YYModel对数据进行解析
- (void)analysisPlistUse_YYModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dict[@"data"][@"categories"];
    for (NSDictionary *dict in array) {
        PGGCollectionModel *model = [PGGCollectionModel yy_modelWithJSON:dict];
        [self.dataSource addObject:model];
        NSArray *arr = dict [@"subcategories"];
        NSMutableArray *collectionArr = [NSMutableArray array];
        for ( NSDictionary *dic in arr) {
            PGGCollectionNextModel *cityModel = [PGGCollectionNextModel yy_modelWithJSON:dic];
            [collectionArr addObject:cityModel];
        }
        [self.collectionDatas addObject:collectionArr];
    }
}
- (void)isGrilAction:(UIButton *)sender {
    _isGrid = !_isGrid;
    [self.collectionView reloadData];
    if (_isGrid) {
        [self.rightButton setTitle:@"网格" forState:UIControlStateNormal];
    } else {
        [self.rightButton setTitle:@"列表" forState:UIControlStateNormal];
    }

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
