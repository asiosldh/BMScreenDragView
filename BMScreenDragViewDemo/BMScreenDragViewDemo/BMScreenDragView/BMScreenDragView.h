//
//  BMScreenDragView.h
//  BMScreenDragViewDemo
//
//  Created by ___liangdahong on 2017/7/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMScreenDragView;

/**
 BMScreenDragViewDelegate
 */
@protocol BMScreenDragViewDelegate <NSObject>

@optional

/**
 开始拖拽时

 @param screenDragView screenDragView
 @param point 位置
 */
- (void)screenDragView:(BMScreenDragView *)screenDragView beganDragOfPoint:(CGPoint)point;

/**
 正在拖拽时
 
 @param screenDragView screenDragView
 @param point 位置
 */
- (void)screenDragView:(BMScreenDragView *)screenDragView changedDragOfPoint:(CGPoint)point;

/**
 结束拖拽时
 
 @param screenDragView screenDragView
 @param point 位置
 */
- (void)screenDragView:(BMScreenDragView *)screenDragView endedDragOfPoint:(CGPoint)point;

/**
 已停止
 
 @param screenDragView screenDragView
 @param point 位置
 */
- (void)screenDragView:(BMScreenDragView *)screenDragView stopOfPoint:(CGPoint)point;

@end

/**
 拖拽view
 */
@interface BMScreenDragView : UIView

@property (weak, nonatomic) id<BMScreenDragViewDelegate> delegate; ///< 代理 默认为nil

@property (assign, nonatomic, getter=isAutomaticEdge) BOOL automaticEdge; ///< 停止时是否自动到边缘 默认为YES

@end
