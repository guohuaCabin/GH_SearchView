# GH_SearchView
简易封装的一个搜索框

对于iOS自带的搜索框，其实我用着也挺好的，但低版本的使用：  高版本的使用:UISearchController，两个难有个统一。很多项目中都是将着两套代码都写入项目中去，这样做难免显得代码冗余。所以就简单的自定义个搜索框。

使用时实现起来也很简单，一句代码创建：

```
GH_SearchView *searchView_1 = [[GH_SearchView alloc]initWithFrame:CGRectMake(10, 80, IPHONE_WIDTH-20, 44.f) withTarget:self backgroundColor:[UIColor redColor] placeholderContent:@"请输入搜索内容" searchImage:@"GH_search" withTableView:nil];
 
//自定制取消按钮字体颜色
[searchView_1  setCancelButtonTitleColor:[UIColor blueColor]];
//设置背景色透明度
[searchView_1 setBackgroundColorWithAlphaComponent:0.5];
//设置激活状态
[searchView_1 setSearchActiveState:YES];
    
[self.view addSubview:searchView_1];
//或者
//self.tableView.tableHeaderView = self.searchView;
```
使用时需遵守<code>GH_searchDelegate</code>协议。
其中必需实现的协议方法有一种:

```
/**
 搜索按钮

 @param content 搜索的内容
 */
-(void)searchClickedWithContent:(NSString *)content;
```

可选的协议方法有三种:

```
/**
 实时搜索协议方法

 @param content 搜索的内容
 */
-(void)searchBoxContentDidChange:(NSString *)content;

/**
 搜索框开始输入

 @param content 搜索的内容
 */
-(void)searchDidBeginEditing:(NSString *)content;

/**
 搜索框输入结束

 @param content 搜索的内容
 */
-(void)searchDidEndEditing:(NSString *)content;
```
效果图如下：
无tableView情况下：
![GH_searchView_1](http://obzx0h1re.bkt.clouddn.com/GH_searchView_1.png)

有tableView情况下：
![GH_searchView_2](http://obzx0h1re.bkt.clouddn.com/GH_searchView_2.png)




