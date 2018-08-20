//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYAutoFooter.h"

//屏幕宽
#define screenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define labelBlack       [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]
#define labelGray        [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]

@interface MJDIYAutoFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation MJDIYAutoFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = labelGray;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 15)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    CGFloat theHeight = 15;
    CGFloat theWidth = [self getWidthWithTitle:_label.text font:[UIFont systemFontOfSize:15]];
    
    CGFloat top = self.shouldTop ? 0 : (self.frame.size.height-theHeight)/2;
    
    _label.frame = CGRectMake((screenWidth-theWidth)/2, top, theWidth,theHeight);
    if (self.state == MJRefreshStateIdle) {
        
    }else if (self.state == MJRefreshStateRefreshing){
        _label.frame = CGRectMake((screenWidth-theWidth)/2+10,top,theWidth,theHeight);
    }else if(self.state == MJRefreshStateNoMoreData){
        
    }
    _loading.center = CGPointMake(_label.frame.origin.x-13, _label.center.y);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    if (state == MJRefreshStateIdle) {
        self.label.text = @"";
        [self.loading stopAnimating];
    }else if (state == MJRefreshStateRefreshing){
        self.label.text = @"加载数据中";
        [self.loading startAnimating];
    }else if(state == MJRefreshStateNoMoreData){
        self.label.text = @"没有更多数据了";
        [self.loading stopAnimating];
    }
}

@end



