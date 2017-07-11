
//
//  BMScreenDragView.m
//  BMScreenDragViewDemo
//
//  Created by ___liangdahong on 2017/7/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMScreenDragView.h"
#import "Masonry.h"

@interface BMScreenDragView ()

@property (strong, nonatomic) MASConstraint *top; ///< top
@property (strong, nonatomic) MASConstraint *left; ///< left
@property (assign, nonatomic) CGPoint oldPoint; ///< 前一点的指标
@property (assign, nonatomic) BOOL normalDrag;  ///< 是否为正常拖拽

@end

@implementation BMScreenDragView

- (void)didMoveToSuperview {
    if (!self.superview) {
        return;
    }
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

+ (instancetype)screenDragViewWithFrame:(CGRect)frame {
    BMScreenDragView *view = [BMScreenDragView new];
    view.frame = frame;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
    }
    return self;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.superview];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.oldPoint = point;
            self.normalDrag = YES;
            break;
        case UIGestureRecognizerStateChanged:
            if (self.normalDrag) {
                self.top.mas_equalTo(self.frame.origin.y + (point.y - self.oldPoint.y));
                self.left.mas_equalTo(self.frame.origin.x + (point.x - self.oldPoint.x));
                self.oldPoint = point;
            }
            break;
        case UIGestureRecognizerStateEnded:
            self.normalDrag = NO; {
                [UIView animateWithDuration:0.25 animations:^{
                    self.left.mas_equalTo((self.oldPoint.x < self.superview.frame.size.width / 2.0) ? 0.0f : self.superview.frame.size.width);
                    [self.superview layoutIfNeeded];
                }];
            }
        default:
            break;
    }
}

@end
