//
//  GH_TableViewController.m
//  GH_SearchViewDemo
//
//  Created by 秦国华 on 2017/5/19.
//  Copyright © 2017年 秦国华. All rights reserved.
//

#import "GH_TableViewController.h"
#import "GH_SearchView.h"
#import "SCLAlertView.h"
@interface GH_TableViewController ()<GH_searchDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)SCLAlertView *alertView;
@property(strong,nonatomic)GH_SearchView *searchView;
@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic)NSMutableArray *searchDataArray;

@end

@implementation GH_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"有tableView放的视图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.alertView = [[SCLAlertView alloc]init];
    
    
    CGFloat IPHONE_WIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat IPHONE_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.searchView = [[GH_SearchView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 44.f) withTarget:self backgroundColor:[UIColor redColor] placeholderContent:@"请输入搜索内容" searchImage:@"GH_search"];
    
    //自定制取消按钮字体颜色
    [self.searchView  setCancelButtonTitleColor:[UIColor blueColor]];
    //设置背景色透明度
    [self.searchView setBackgroundColorWithAlphaComponent:0.5];
    
    self.tableView.tableHeaderView = self.searchView;
    
    
}

#pragma mark --lazyLoad
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"PS",@"Dash",@"Eavrnote",@"Reeder",@"Google",@"SUbline Text", nil];
    }
    return _dataArray;
}

-(NSMutableArray *)searchDataArray
{
    if (!_searchDataArray) {
        _searchDataArray = [[NSMutableArray alloc]init];
    }
    return _searchDataArray;
}

#pragma mark ---tabeViewDelagate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchView.isSearchActive ? self.searchDataArray.count : self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GH_tableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (self.searchView.isSearchActive) {
        cell.textLabel.text = self.searchDataArray[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark --GH_searchdelegate 

#pragma mak ---搜索非必需实现协议
/*
//开始输入
-(void)searchDidBeginEditing:(NSString *)content
{
    NSLog(@"开始编辑。。。");
}
//结束输入
-(void)searchDidEndEditing:(NSString *)content
{
    NSLog(@"编辑结束！！！");
   
    
}
//实时搜索
-(void)searchBoxContentDidChange:(NSString *)content
{
    NSLog(@"实时搜索：%@",content);
    
}
*/
#pragma mak ---搜索必需实现协议
//点击搜索按钮事件
-(void)searchClickedWithContent:(NSString *)content
{
    
    if (content.length == 0 ) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        alert.backgroundType = SCLAlertViewBackgroundBlur;
        [alert showNotice:self title:@"提示" subTitle:@"请输入搜索内容！" closeButtonTitle:@"OK" duration:0.0f];
    }
    
    self.alertView.showAnimationType = SCLAlertViewHideAnimationSlideOutToCenter;
    self.alertView.hideAnimationType = SCLAlertViewHideAnimationSlideOutFromCenter;
    
    self.alertView.backgroundType = SCLAlertViewBackgroundTransparent;
    [self.alertView showWaiting:self title:@"Waiting..." subTitle:@"正在搜索，请耐心等待" closeButtonTitle:@"取消" duration:3.f];
    
    //这里是延迟加载方法，实现搜索非必需协议时，把这个延迟方法去掉。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *result = [NSString stringWithFormat:@"搜索结果%u",arc4random()%100];
        [self.searchDataArray addObject:result];
        [self.tableView reloadData];
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
