//
//  NNWheelImage.m
//  WXLB
//
//  Created by iOS on 16/10/3.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNWheelImage.h"

@interface NNWheelImage	() <UIScrollViewDelegate>

/** imgView 的个数 */
@property (nonatomic, assign) NSInteger imgCount;

/** 宽和高 */
@property (nonatomic, assign) CGFloat sWidth;
@property (nonatomic, assign) CGFloat sHeigth;

/** 分页 */
@property (nonatomic, strong) UIPageControl *pageCtrol;

/** 页码 */
@property (nonatomic, assign) NSInteger currentPage;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NNWheelImage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //配置 srolleView 的属性
        self.pagingEnabled = YES;
        self.delegate = self;
        self.clipsToBounds = YES;
        _scrollInterval = 2.0; // 切换图片的时间间隔
        _sHeigth = self.frame.size.height; // 滚动视图的高度
        _sWidth = self.frame.size.width; // 滚动视图的宽度
    }
    return self;
}


- (void)setImgArr:(NSArray *)imgArr
{
    //imgArr数组赋值
    _imgArr = imgArr;
    
    //前面和后面都需要添加一张图片
    _imgCount = _imgArr.count + 2;
    
    //配置图片等
    [self setupPageControlAndImages];
}


#pragma mark - 图片数组传入确定页码和图片
- (void)setupPageControlAndImages
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, _sHeigth + 30, _sWidth, 30)];
    view.alpha = .5;
    view.backgroundColor = [UIColor blackColor];
    [self.rootView addSubview:view];
    
    //创建 pageControl
    CGFloat pageCtrolY = CGRectGetMaxY(self.frame);
    _pageCtrol = [[UIPageControl alloc] initWithFrame:CGRectMake(self.center.x - 100, pageCtrolY - 30, 200, 30)];
    _pageCtrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_pageCtrol addTarget:self action:@selector(pageCtrolAction:) forControlEvents:UIControlEventValueChanged];
    [self.rootView addSubview:_pageCtrol];
    
    _pageCtrol.numberOfPages = _imgCount - 2;
    _pageCtrol.currentPage = 0;
    
    //创建图片视图
    for (NSInteger i = 0; i < _imgCount; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_sWidth * i , 0, _sWidth, _sHeigth)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES; // 允许与用户交互
        [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)]]; // 添加手势

        if (i == 0) {
            imgView.image = [UIImage imageNamed:self.imgArr[_imgCount - 3]];
        } else if (i == _imgCount - 1) {
            imgView.image = [UIImage imageNamed:self.imgArr[0]];
        } else {
            imgView.image = [UIImage imageNamed:self.imgArr[i - 1]];
        }
        
        [self addSubview:imgView];
							 
    }
    
    self.contentOffset = CGPointMake(_sWidth, 0);
    self.contentSize = CGSizeMake(_sWidth * _imgCount, 0);
    
    //开启定时器
    [self startTimer];
}

- (void)clickImage:(UIImageView *)image {
    NSLog(@"~~~~~~~~~~");
}


#pragma mark - pageCtrol 点击事件
- (void)pageCtrolAction:(UIPageControl *)pageControl
{
    _currentPage = pageControl.currentPage + 1;
    self.contentOffset = CGPointMake(_currentPage * _sWidth, 0);
}

#pragma mark - scrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger index = scrollView.contentOffset.x / _sWidth;
    _pageCtrol.currentPage = index - 1;
    
    if (index == _imgCount - 1) {
        _pageCtrol.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(_sWidth, 0)];
    }
    if(scrollView.contentOffset.x == 0){
        _pageCtrol.currentPage = _imgCount - 3;
        [scrollView scrollRectToVisible:CGRectMake((_imgCount - 2) * _sWidth, 0, _sWidth, _sHeigth) animated:NO];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];
    
}

#pragma mark - 添加定时器
- (void)startTimer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
}

#pragma mark - timerAction 定时器的点击事件
- (void)timerAction:(NSTimer *)timer
{
    [self setContentOffset:CGPointMake(self.contentOffset.x + _sWidth, 0) animated:YES];
}

@end
