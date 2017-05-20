//
//  GH_ViewController.m
//  GH_SearchViewDemo
//
//  Created by 秦国华 on 2017/5/19.
//  Copyright © 2017年 秦国华. All rights reserved.
//

#import "GH_ViewController.h"
#import "GH_SearchView.h"
#import "SCLAlertView.h"
@interface GH_ViewController ()<GH_searchDelegate>

@property(strong,nonatomic)SCLAlertView *alertView;

@end

@implementation GH_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无tableView的视图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.alertView = [[SCLAlertView alloc]init];
    
    
    CGFloat IPHONE_WIDTH = [UIScreen mainScreen].bounds.size.width;
    
    GH_SearchView *searchView_1 = [[GH_SearchView alloc]initWithFrame:CGRectMake(10, 80, IPHONE_WIDTH-20, 44.f) withTarget:self backgroundColor:[UIColor redColor] placeholderContent:@"请输入搜索内容" searchImage:@"GH_search" withTableView:nil];
    
    //自定制取消按钮字体颜色
    [searchView_1  setCancelButtonTitleColor:[UIColor blueColor]];
    //设置背景色透明度
    [searchView_1 setBackgroundColorWithAlphaComponent:0.5];
    
    [self.view addSubview:searchView_1];
    
    
    
    GH_SearchView *searchView_2 = [[GH_SearchView alloc]initWithFrame:CGRectMake(0, 200, IPHONE_WIDTH, 44.f) withTarget:self backgroundColor:[UIColor grayColor] placeholderContent:@"搜索关键字" searchImage:@"GH_search"];
    
    //自定制取消按钮字体颜色
    [searchView_2  setCancelButtonTitleColor:[UIColor redColor]];
    //设置背景色透明度
    [searchView_2 setBackgroundColorWithAlphaComponent:0.5];
    
    [self.view addSubview:searchView_2];
    
}

#pragma mark --GH_searchdelegate

-(void)searchDidBeginEditing:(NSString *)content
{
    NSLog(@"开始编辑。。。");
}

-(void)searchDidEndEditing:(NSString *)content
{
    NSLog(@"编辑结束！！！");
}

-(void)searchBoxContentDidChange:(NSString *)content
{
    NSLog(@"实时搜索：%@",content);
}

-(void)searchClickedWithContent:(NSString *)content
{
    self.alertView.showAnimationType = SCLAlertViewHideAnimationSlideOutToCenter;
    self.alertView.hideAnimationType = SCLAlertViewHideAnimationSlideOutFromCenter;
    
    self.alertView.backgroundType = SCLAlertViewBackgroundTransparent;
    [self.alertView showWaiting:self title:@"Waiting..." subTitle:@"正在搜索，请耐心等待" closeButtonTitle:@"取消" duration:3.f];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
