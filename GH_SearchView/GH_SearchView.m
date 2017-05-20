//
//  GH_SearchView.m
//  IdealMobileOffice
//
//  Created by 秦国华 on 2017/5/18.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "GH_SearchView.h"

@interface GH_SearchView()<UITextFieldDelegate>

@property(strong,nonatomic)UIView *baseView;

@property(strong,nonatomic)UIImageView *searchImageView;

@property(strong,nonatomic)UIButton *cancelButton;
@property(strong,nonatomic)UITableView *self_tableView;

@property(assign,nonatomic)CGRect self_frame;
@property(strong,nonatomic)UIColor *self_bcakgroundColor;
@property(assign,nonatomic)CGFloat self_alphaComponent;
@property(copy,nonatomic)NSString *placeholderContent;

@property(copy,nonatomic)NSString *self_searchImageName;

@property(assign,nonatomic)CGFloat baseViewWidth;
@property(assign,nonatomic)CGFloat searchTextFieldWidth;
@property(assign,nonatomic)CGFloat searchImageViewX;



@end

@implementation GH_SearchView
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame withTarget:(id)target backgroundColor:(UIColor *)color placeholderContent:(NSString *)placeholderContent  searchImage:(NSString *)searchImageName
{
    self = [super initWithFrame: frame];
    if (self) {
        self.self_frame = frame;
        
        self.self_bcakgroundColor = color;
        self.self_alphaComponent = 1.0;
        self.placeholderContent = placeholderContent;
        self.self_searchImageName = searchImageName;
        self.searchDelegate = target;
        self.isSearchActive = NO;
        [self initContentView];
    }
    return self;
}
//初始化方法
-(id)initWithFrame:(CGRect)frame withTarget:(id)target backgroundColor:(UIColor *)color placeholderContent:(NSString *)placeholderContent searchImage:(NSString *)searchImageName withTableView:(UITableView *)tableView
{
    self = [super initWithFrame: frame];
    if (self) {
        self.self_frame = frame;
        self.self_bcakgroundColor = color;
        self.self_alphaComponent = 1.0;
        self.placeholderContent = placeholderContent;
        self.self_searchImageName = searchImageName;
        self.searchDelegate = target;
        self.isSearchActive = NO;
        _self_tableView = tableView;
        [self initContentView];
    }
    return self;
}

//lazy button
-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(_self_frame.size.width - 50.f, 4, 50, 36.f)];
        self.cancelButton.frame = CGRectMake(_self_frame.size.width - 50.f, 4, 50, 36.f);
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
    }
    return _cancelButton;
}

#pragma mark -- 初始化内容视图
-(void)initContentView
{
    
    self.backgroundColor = [_self_bcakgroundColor colorWithAlphaComponent:_self_alphaComponent];
    self.cancelButton.hidden = YES;
    
    CGFloat self_Width = self.self_frame.size.width;
    
    //搜索栏
    CGFloat searchViewHeight = 44.f;
    CGFloat viewSpace = 10.f;
    CGFloat searchImageViewHeight = 20.f;
    _baseViewWidth = self_Width - viewSpace*2;
    CGFloat viewHeight = searchViewHeight - 8.f;
    
    _searchTextFieldWidth = self.baseViewWidth - searchImageViewHeight - viewSpace;
    _searchImageViewX = _searchTextFieldWidth + 5.f;
    CGFloat searchImageViewSpace = (viewHeight-searchImageViewHeight)/2;
    
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(viewSpace, 4, self.baseViewWidth, viewHeight)];
    
    [self addSubview:self.baseView];
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, _searchTextFieldWidth, self.baseView.frame.size.height)];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.placeholder = _placeholderContent;
    self.searchTextField.delegate = self;
    self.searchTextField.clipsToBounds = YES;
    self.searchTextField.layer.cornerRadius  = 10.f;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.baseView addSubview:self.searchTextField];
    
    self.searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_searchImageViewX, searchImageViewSpace, searchImageViewHeight, searchImageViewHeight)];
    self.searchImageView.image = [UIImage imageNamed:_self_searchImageName];
    self.searchImageView.userInteractionEnabled = YES;
    [self.baseView addSubview:self.searchImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTapClicked:)];
    
    [self.searchImageView addGestureRecognizer:tap];
}

#pragma mark ---实时监听输入内容
-(void)textFieldDidChange:(UITextField *)textField
{
    if (self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchBoxContentDidChange:)]) {
        [self.searchDelegate searchBoxContentDidChange:textField.text];
    }
 
    
}

#pragma mark --textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.isSearchActive = YES;
    if (self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchDidBeginEditing:)]) {
        [self.searchDelegate searchDidBeginEditing:textField.text];
    }
    if (self.searchTextField.isFirstResponder) {
        [self showCancelButton:nil];
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.isSearchActive = NO;
    if (self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchDidEndEditing:)]) {
        [self.searchDelegate searchDidEndEditing:textField.text];
    }
    if (self.searchTextField.isFirstResponder) {
        [self showCancelButton:nil];
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.searchTextField) {
        [textField resignFirstResponder];
        [self searchTapClicked:nil];
    }
 
    return YES;
}

#pragma mark -- search button clicked
-(void)searchTapClicked:(UITapGestureRecognizer *)tap
{
    
    [self.searchTextField resignFirstResponder];
    self.isSearchActive = YES;
    
    NSString *searchContent = self.searchTextField.text ? self.searchTextField.text:@"";
    
    if (self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(searchClickedWithContent:)]) {
        [self.searchDelegate searchClickedWithContent:searchContent];
    }
    
    [self.searchTextField resignFirstResponder];

}
#pragma mark ---show cancelButton
- (void)showCancelButton:(NSNotification *) Notification{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect baseViewFrame = self.baseView.frame;
        baseViewFrame.size.width = _baseViewWidth - 50;
        self.baseView.frame = baseViewFrame;
        
        CGRect textFieldFrame = self.searchTextField.frame;
        textFieldFrame.size.width = _searchTextFieldWidth - 50;
        self.searchTextField.frame = textFieldFrame;
        
        
        CGRect searchImageViewFrame = self.searchImageView.frame;
        searchImageViewFrame.origin.x = _searchImageViewX - 50;
        self.searchImageView.frame = searchImageViewFrame;

    } completion:^(BOOL finished) {

        self.cancelButton.hidden = NO;
    }];
    
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview;
        [tableView reloadData];
    }
}

#pragma mark --- cancel button clicked
-(void)cancelButtonClicked:(UIButton *)sender
{
    self.isSearchActive = NO;
    self.searchTextField.text = @"";
    [self.searchTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.cancelButton setHidden:YES];
        
        CGRect textFieldFrame = self.searchTextField.frame;
        textFieldFrame.size.width = _searchTextFieldWidth;
        self.searchTextField.frame = textFieldFrame;
        
        CGRect baseViewFrame = self.baseView.frame;
        baseViewFrame.size.width = _baseViewWidth;
        self.baseView.frame = baseViewFrame;
        
        CGRect searchImageViewFrame = self.searchImageView.frame;
        searchImageViewFrame.origin.x = _searchImageViewX;
        self.searchImageView.frame = searchImageViewFrame;

    }];
    
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview;
        [tableView reloadData];
    }
    
}

-(void)setIsSearchActive:(BOOL)isSearchActive
{
    _isSearchActive = isSearchActive;
}

// set search active state
-(void)setSearchActiveState:(BOOL)isSearchActive
{
    self.isSearchActive = isSearchActive;
    if (isSearchActive == YES) {
        [self.searchTextField becomeFirstResponder];
        [self showCancelButton:nil];
    }else{
        
        [self.searchTextField resignFirstResponder];
        
        if (self.cancelButton) {
            [self.cancelButton setHidden:YES];
            self.cancelButton.frame = CGRectZero;
            [self.cancelButton removeFromSuperview];
            
            CGRect textFieldFrame = self.searchTextField.frame;
            textFieldFrame.size.width = _searchTextFieldWidth;
            self.searchTextField.frame = textFieldFrame;
            
            CGRect baseViewFrame = self.baseView.frame;
            baseViewFrame.size.width = _baseViewWidth;
            self.baseView.frame = baseViewFrame;
            
            CGRect searchImageViewFrame = self.searchImageView.frame;
            searchImageViewFrame.origin.x = _searchImageViewX;
            self.searchImageView.frame = searchImageViewFrame;
        }
    }
    
}
// set cancel button title color
-(void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor
{
   [self.cancelButton setTitleColor:cancelButtonTitleColor forState:UIControlStateNormal];
}

// set background color of search view
-(void)setBackgroundColorWithAlphaComponent:(CGFloat)alphaComponent
{
    self.backgroundColor = [_self_bcakgroundColor colorWithAlphaComponent:alphaComponent];
}

@end
