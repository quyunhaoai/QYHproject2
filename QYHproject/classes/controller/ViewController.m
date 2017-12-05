//
//  ViewController.m
//  QYHproject
//
//  Created by hao on 2017/12/2.
//  Copyright © 2017年 hao. All rights reserved.
//
//typedef NS_ENUM(NSInteger,workTypes){
//    3g   = 1,
//    4g   = 2,
//    wifi = 3,
//};

#import "ViewController.h"
#import "QYHtitleButton.h"
#import "UIView+frame.h"
#import "oneViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "AFNetworking.h"
static CGFloat const navightH = 64;
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIButton *currentButton;

@end
typedef NS_ENUM(NSInteger, qyhtype) {
    qyhtypeOneoo   = -1,
    qyhtypeOne     = 1,
    qyhtypetwo     = 2,
    qyhtypethree   = 3,
    qyhtpeywifi    = 4,
};
typedef enum {
    qyhtypeAll = 1,
    qyhtypeOrther = 2,
}qyhNetWorkType;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    //添加SUBviwe
    [self addsubViews];
    
    //添加ScroollerView
    [self setupScrollerView];
    
    //添加标题菜单
    [self setupTitleView];
    
    //初始化第一个VC；
    [self addViewToScrollview:0];
    

    //网络请求
    [self requestData];
    
    [self testFor];
}
-(void)requestData
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://apiinfoios.ydbimg.com/Default.aspx?type=app&id=%@",@"137304"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"==%@",responseObject);
        
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self youxiaoqi:[HwTools UserDefaultsObjectForKey:@"isTimeOut"]];
        NSLog(@"==%@",error);
        
    }];
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
//    [manager ]
//    [manager invalidateSessionCancelingTasks:YES];
//    managers.requestSerializer.accessibilityContainerType = nil;
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = @"http://apiinfoios.ydbimg.com/Default.aspx?type=app&id=137304";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [managers GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"请求成功！");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败！");
    }];
}
-(void)testFor
{
    for (int i = 0; i < 10; i ++) {
        if (i == 3) {
            continue;
        }

        if (i == 5) {
            break;
        }
        NSLog(@"--%d",i);
    }
    NSLog(@"<>%d",qyhtypeAll);
    NSLog(@"<>%ld",qyhtypeOne);


}
-(void)addViewToScrollview:(NSUInteger )index
{
    for (int i = 0; i <self.childViewControllers.count; i ++) {

    UIViewController *VC = self.childViewControllers[i];
    if ([VC isViewLoaded]) return;
    UIView *childview = VC.view;
    CGFloat ScrollviewW = self.scrollview.qyh_width;
    childview.frame = CGRectMake(i * ScrollviewW, 0, ScrollviewW, self.scrollview.qyh_height);
    
    [self.scrollview addSubview:childview];
        
    }
}
-(void)setupScrollerView
{
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    scrollV.backgroundColor = [UIColor yellowColor];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    scrollV.delegate = self;
    scrollV.scrollsToTop = NO;
    [self.view addSubview:scrollV];
    
    self.scrollview = scrollV;
    NSUInteger index = self.childViewControllers.count;
    self.scrollview.contentSize = CGSizeMake(ScreenW * index, 0);
}
-(void)addsubViews
{
    [self addChildViewController:[[oneViewController alloc]init]];
    [self addChildViewController:[[twoViewController alloc] init]];
    [self addChildViewController:[[threeViewController alloc]init]];
    
}
-(void)setupTitleView
{
    UIView *titleV = [[UIView alloc]init];
    titleV.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleV.frame = CGRectMake(0, navightH,ScreenW, 35);
    [self.view addSubview:titleV];
    self.titleView = titleV;
    [self addtitleButtons];
    QYHtitleButton *button = (QYHtitleButton *)[self.titleView.subviews firstObject];
    [self titleButtonTap:button];
    
}
-(void)addtitleButtons
{
    NSArray *tiltes = @[@"one",@"two",@"three"];
    NSUInteger count = self.childViewControllers.count;
    CGFloat buttonW = ScreenW / count;
    for (int i = 0; i < count; i ++) {
        QYHtitleButton *button = [[QYHtitleButton alloc] init];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, self.titleView.qyh_height);
        [button addTarget:self action:@selector(titleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:tiltes[i] forState:UIControlStateNormal];
        button.tag = i;
        [self.titleView addSubview:button];
    }
}
-(void)titleButtonTap:(QYHtitleButton *)button
{
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
    NSUInteger index = button.tag;
    CGFloat offsetX = index * self.scrollview.qyh_width;
    self.scrollview.contentOffset = CGPointMake(offsetX, self.scrollview.contentOffset.y);
    [self addViewToScrollview:button.tag];
    for (int i = 0; i <self.childViewControllers.count; i ++) {
        UIViewController *vc = self.childViewControllers[i];
        if (![vc isViewLoaded]) continue;
        UIScrollView *scrollview =(UIScrollView *)vc.view;
        if (![scrollview isKindOfClass:[UIScrollView class]]) return;
        scrollview.scrollsToTop = ( i == index);
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x /scrollView.qyh_width;
    QYHtitleButton *button = self.titleView.subviews[index];
    [self titleButtonTap:button];
    [self addViewToScrollview:index];
    
}
@end
