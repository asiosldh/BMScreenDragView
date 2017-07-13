
//
//  BMScreenDragView.m
//  BMScreenDragViewDemo
//
//  Created by ___liangdahong on 2017/7/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMScreenDragView.h"
#import "Masonry.h"
#import <pop/POP.h>

@interface BMScreenDragView ()

@property (strong, nonatomic) MASConstraint *top;  ///< top
@property (strong, nonatomic) MASConstraint *left; ///< left
@property (assign, nonatomic) CGPoint oldPoint;    ///< 前一点的指标
@property (assign, nonatomic) BOOL normalDrag;     ///< 是否为正常拖拽

@end

@implementation BMScreenDragView

#pragma mark -

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

#pragma mark - 私有方法

- (void)didMoveToSuperview {
    if (self.superview) {
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            self.top = make.top.mas_equalTo(self.frame.origin.y).priorityLow();
            self.left = make.left.mas_equalTo(self.frame.origin.x).priorityLow();
            make.height.mas_equalTo(self.frame.size.height);
            make.width.mas_equalTo(self.frame.size.width);
            make.bottom.mas_lessThanOrEqualTo(0);
            make.right.mas_lessThanOrEqualTo(0);
            make.top.mas_greaterThanOrEqualTo(0);
            make.left.mas_greaterThanOrEqualTo(0);
        }];   
    }
}

- (void)initUI {
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
}

#pragma mark - 事件响应

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.superview];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _isDraging = YES;
            self.oldPoint = point;
            self.normalDrag = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:beganDragOfPoint:)]) {
                [self.delegate screenDragView:self beganDragOfPoint:point];
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (self.normalDrag) {
                self.top.mas_equalTo(self.frame.origin.y + (point.y - self.oldPoint.y));
                self.left.mas_equalTo(self.frame.origin.x + (point.x - self.oldPoint.x));
                self.oldPoint = point;
                if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:changedDragOfPoint:)]) {
                    [self.delegate screenDragView:self changedDragOfPoint:point];
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
            [self endedWithPoint:point];
            _isDraging = NO;
            break;
        default:
            break;
    }
}

- (void)endedWithPoint:(CGPoint)point {
    self.normalDrag = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:endedDragOfPoint:)]) {
        [self.delegate screenDragView:self endedDragOfPoint:point];
    }
    if (!self.isAutomaticEdge) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:stopOfPoint:)]) {
            [self.delegate screenDragView:self stopOfPoint:point];
        }
    } else {
        if (self.screenDragViewAutomaticType == BMScreenDragViewAutomaticTypeLeftRight) {
            CGFloat tempX = (self.oldPoint.x < self.superview.frame.size.width / 2.0) ? 0.0f : self.superview.frame.size.width;
            // 执行Spring动画
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
            CGFloat w =  (self.oldPoint.x < self.superview.frame.size.width / 2.0) ? -self.frame.size.width/2.0: self.frame.size.width/2.0;
            anim.toValue             = @(tempX - w);
            anim.springBounciness    = 8.f;
            [self.layer pop_addAnimation:anim forKey:@"ScaleY"];
            anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
                self.left.mas_equalTo(tempX);
                if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:stopOfPoint:)]) {
                    [self.delegate screenDragView:self stopOfPoint:CGPointMake(tempX, point.y)];
                }
            };
        } else {
            CGFloat tempY = (self.oldPoint.y < self.superview.frame.size.height / 2.0) ? 0.0f : self.superview.frame.size.height;
            // 执行Spring动画
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            CGFloat temp =  (self.oldPoint.y < self.superview.frame.size.height / 2.0) ? -self.frame.size.height/2.0: self.frame.size.height/2.0;
            anim.toValue             = @(tempY - temp);
            anim.springBounciness    = 8.f;
            [self.layer pop_addAnimation:anim forKey:@"ScaleY"];
            anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
                self.top.mas_equalTo(tempY);
                if (self.delegate && [self.delegate respondsToSelector:@selector(screenDragView:stopOfPoint:)]) {
                    [self.delegate screenDragView:self stopOfPoint:CGPointMake(point.x, tempY)];
                }
            };
        }
    }
}

@end
