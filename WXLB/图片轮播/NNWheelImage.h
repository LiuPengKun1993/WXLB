//
//  NNWheelImage.h
//  WXLB
//
//  Created by iOS on 16/10/3.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击图片的Block回调，参数当前图片的索引，也就是当前页数
typedef void(^TapImageViewButtonBlock)(NSInteger imageIndex);


@interface NNWheelImage : UIScrollView
/**
 *  切换图片的时间间隔, 默认是2s
 */
@property (nonatomic, assign) CGFloat scrollInterval;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *imgArr;

@property (nonatomic, strong) UIView  *rootView;


@end
