//
//  NNViewController.m
//  WXLB
//
//  Created by iOS on 16/10/3.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNViewController.h"
#import "NNWheelImage.h"
#define NNViewWidth [UIScreen mainScreen].bounds.size.width

@interface NNViewController ()

@end

@implementation NNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片显示的位置
    NNWheelImage *scrollerView = [[NNWheelImage alloc] initWithFrame:CGRectMake(10, 60, NNViewWidth - 20, 200)];
    [self.view addSubview:scrollerView];
    
    scrollerView.rootView = self.view;
    scrollerView.scrollInterval = 2.0; // 切换图片的时间间隔
    
    // 图片数组
    scrollerView.imgArr = @[@"1.gif", @"2.jpg", @"3.jpg", @"4.jpeg", @"5.jpg"];
}



@end
