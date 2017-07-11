//
//  BMScreenDragView.h
//  BMScreenDragViewDemo
//
//  Created by ___liangdahong on 2017/7/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMScreenDragViewDelegate <NSObject>

@end

@interface BMScreenDragView : UIView

+ (instancetype)screenDragViewWithFrame:(CGRect)frame;

@end
