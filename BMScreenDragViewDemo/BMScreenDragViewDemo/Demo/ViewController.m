//
//  ViewController.m
//  BMScreenDragViewDemo
//
//  Created by ___liangdahong on 2017/7/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "ViewController.h"
#import "BMScreenDragView.h"

@interface ViewController () <BMScreenDragViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BMScreenDragView *screenDragView = [[BMScreenDragView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        screenDragView.layer.cornerRadius = 30;
        screenDragView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:screenDragView];
        screenDragView.delegate = self;
        screenDragView.automaticEdge = YES;
        screenDragView.screenDragViewAutomaticType = 1;
    });
}

- (void)screenDragView:(BMScreenDragView *)screenDragView beganDragOfPoint:(CGPoint)point {
    NSLog(@"开始 %@", NSStringFromCGPoint(point));
}

- (void)screenDragView:(BMScreenDragView *)screenDragView changedDragOfPoint:(CGPoint)point {
    NSLog(@"正在 %@", NSStringFromCGPoint(point));
}

- (void)screenDragView:(BMScreenDragView *)screenDragView endedDragOfPoint:(CGPoint)point {
    NSLog(@"结束 %@", NSStringFromCGPoint(point));
}

- (void)screenDragView:(BMScreenDragView *)screenDragView stopOfPoint:(CGPoint)point {
    NSLog(@"停止 %@", NSStringFromCGPoint(point));
}

@end
