# PGGTableViewLinkage
代码下载地址 https://github.com/penghero/PGGTableViewLinkage.git
鹏哥哥联动   如果对您有所帮助 请去上面github送我一个星星呗 感谢您！
# 演示Gif
![image](https://github.com/penghero/PGGTableViewLinkage/blob/master/gif/Untitle2.gif)
# 功能点
先介绍一下 功能点：<br>
1.tableview与tableview的联动实现<br>
2.tableview与collectionview的联动实现<br>
3.collection中列表与网格视图的转换<br>
4.使用YYModel对数据进行解析并转成模型 <br>
5.使用SDWebImage对图片进行处理<br>
6.使用cocoapods对三方库的方便管理<br>
7.对plist文件和json文件的解析处理<br>
8.自定义控件的使用与简单布局<br>
重点来了！！！<br>
要想实现联动 首先创建左侧tableview 与右侧tableview或者是collectionview ，其次 对其进行初始化和布局，先实现数据的分别展示，前面这些这两种方式都一样，
到重点了<br>
联动的实现方式 （其实通用）<br>
第一种 也就是tableview与tableview的联动实现 <br>
在tableview的didSelectRowAtIndexPath代理方法中处理点击左侧视图  改变右侧显示位置 代码中注释较为详细 仔细看<br>
```
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 //判断是否为 左侧 的 tableView
 if (tableView == self.provinceTableView) {
 //计算出 右侧 tableView 将要 滚动的 位置
 NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
 //将 rightTableView 移动到对应的 位置
 //注：动画属性一定要设置为NO 否则 左边显示不准确
 [self.cityTableView scrollToRowAtIndexPath:moveToIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
 }
 ```
 左侧联动处理完 下面处理右侧滑动 ，从而带动左侧跳转到响应位置 这个是通过scrollview的scrollViewDidScroll代理方法实现
  //    处理右边滑动时跟左边的联动
  ```
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
 ```
 这样就实现了联动。但是，这中实现方法较为简单 但是用的时候有弊病 就是 必须要先滑动右侧 触发ecrollviewdelegate的代理方法 <br>
 然后在点击左侧tableview才会较为准确的展示联动，如果先点击左侧，这样会不准确 会差一个section的位置 ，<br>
 还有就是开头的前三到4个section和结尾的三到四个section有时候会没有响应效果，也可能是我处理的不对，<br>
 注：：：实际开发并不推荐用这种方式，虽说实现简单，但是效果不佳，推荐使用下一个 tableview与collection的联动实现方式。<br>
 联动实现 方式二：（推荐使用）<br>
先将TableView关联CollectionView，点击TableViewCell，右边的CollectionView跳到相应的分区列表头部。<br>
```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;//记录位置
    //核心方法 根据NSIndexPath跳转到指定位置
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
```
再将CollectionView关联TableView，标记一下RightTableView的滚动方向，然后分别在CollectionView分区标题即将展示和展示结束的代理函数里面处理逻辑。<br>
1.在CollectionView分区标题即将展示里面，判断 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的），<br>
如果二者都成立，那么TableView的选中行就是CollectionView的当前section。<br>
2.在CollectionView分区标题展示结束里面，判断当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的，如果二者都成立，那么TableView的选中行就是CollectionView的当前section-1。<br>
// 标记一下CollectionView的滚动方向，是向上还是向下
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView)    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
```
```
// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}
// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
```
注：该两种实现方式的核心方法
```[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle]
```
代码实现，千变万化，只要用户体验好，怎么实现效果都可以<br>

