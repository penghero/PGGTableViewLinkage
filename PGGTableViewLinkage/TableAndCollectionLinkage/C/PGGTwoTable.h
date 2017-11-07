//
//  PGGTwoTable.h
//  PGGTableViewLinkage
//
//  Created by 陈鹏 on 2017/11/4.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 tableview的联动实现方式一
 通过这两个方法分别处理左侧滑动与右侧滑动相互关联
 这中实现方法较为简单 但是用的时候有弊病 就是 必须要先滑动右侧 触发ecrollviewdelegate的代理方法 然后在点击左侧tableview才会较为准确的展示联动，如果先点击左侧，这样会不准确 会差一个section的位置 ，还有就是开头的前三到4个section和结尾的三到四个section有时候会没有响应效果，也可能是我处理的不对，实际开发并不推荐用这种方式，虽说实现简单，但是效果不佳，推荐使用下一个 tableview与collection的联动实现方式。
 
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
 */
@interface PGGTwoTable : UIViewController

@end
