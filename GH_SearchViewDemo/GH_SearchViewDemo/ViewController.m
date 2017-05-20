//
//  ViewController.m
//  GH_SearchViewDemo
//
//  Created by 秦国华 on 2017/5/19.
//  Copyright © 2017年 秦国华. All rights reserved.
//

#import "ViewController.h"
#import "GH_ViewController.h"
#import "GH_TableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *buttonTitlesArray = @[@"GH_ViewController",@"GH_TableViewController"];
    
    CGFloat IPHONE_WIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnSpace = 20.f;
    CGFloat btnHeight = 50.f;
    CGFloat originY  = 150.f;
    CGFloat btnWidth = IPHONE_WIDTH - btnSpace*2;
    
    
    for (NSInteger i = 0; i< buttonTitlesArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(btnSpace, originY+(originY+ btnHeight)*i , btnWidth, btnHeight)];
        
        [button setTitle:buttonTitlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius  = 5.f;
        button.clipsToBounds = YES;
        button.tag = 100+i;
        [button addTarget:self action:@selector(btClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
}

-(void)btClicked:(UIButton *)sender
{
    if (sender.tag == 100) {
        GH_ViewController *VC = [[GH_ViewController alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        GH_TableViewController *tableViewVC = [[GH_TableViewController alloc]init];
        
        [self.navigationController pushViewController:tableViewVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
