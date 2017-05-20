//
//  GH_SearchView.h
//  IdealMobileOffice
//
//  Created by 秦国华 on 2017/5/18.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GH_searchDelegate;

@interface GH_SearchView : UIView

@property(strong,nonatomic)UITextField *searchTextField;

@property(assign,nonatomic)BOOL isSearchActive;

@property(weak,nonatomic)id <GH_searchDelegate>searchDelegate;

/**
 搜索初始化方法

 @param frame frame
 @param target 代理
 @param color 搜索视图背景色
 @param placeholderContent placeholder
 @param searchImageName imageName
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame withTarget:(id)target backgroundColor:(UIColor *)color placeholderContent:(NSString *)placeholderContent  searchImage:(NSString *)searchImageName ;

/**
 搜索初始化方法

 @param frame frame
 @param target 代理
 @param color 搜索视图背景色
 @param placeholderContent placeholder
 @param searchImageName imageName
 @param tableView tableView
 @return self
 */
-(id)initWithFrame:(CGRect)frame withTarget:(id)target backgroundColor:(UIColor *)color placeholderContent:(NSString *)placeholderContent searchImage:(NSString *)searchImageName withTableView:(UITableView *)tableView;



/**
 设置搜索框的激活状态

 @param isSearchActive 激活状态（YES or NO）
 */
-(void)setSearchActiveState:(BOOL)isSearchActive;

/**
 设置取消按钮的字体颜色

 @param cancelButtonTitleColor titleColor
 */
-(void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor;

/**
 设置搜索框的

 @param alphaComponent 返回一个带透明度的UIColor
 */
-(void)setBackgroundColorWithAlphaComponent:(CGFloat)alphaComponent;


@end

@protocol GH_searchDelegate <NSObject>

@required//必需实现协议方法

/**
 搜索按钮

 @param content 搜索的内容
 */
-(void)searchClickedWithContent:(NSString *)content;

@optional//可选协议方法

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


@end






