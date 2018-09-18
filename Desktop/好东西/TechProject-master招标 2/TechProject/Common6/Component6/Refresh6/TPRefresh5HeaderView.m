//
//  TPRefreshView.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPRefresh5HeaderView.h"
#import <YYCategories.h>
#import <lottie-ios/Lottie/Lottie.h>
#import "UIScrollView+TPRefresh.h"
@interface TPRefresh5HeaderView()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) LOTAnimationView *lotView;
@end

@implementation TPRefresh5HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        LOTAnimationView *animation = [LOTAnimationView animationNamed:@"loading" inBundle:[NSBundle mainBundle]];
        animation.size = CGSizeMake(36, self.height);
        animation.centerX = self.centerX;
        animation.centerY = self.height/2;
        animation.contentMode = UIViewContentModeScaleAspectFit;
        _lotView = animation;
        [self addSubview:_lotView];
        animation.loopAnimation = YES;
    }
    return self;
}

#pragma mark - Override
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.progress = - self.scrollView.contentOffset.y;
    }
}

#pragma mark - Property
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress >= kDefaultRefreshHeight && !self.animating && !self.scrollView.dragging && self.status == TPRefreshHeaderStatePulling) {
        self.status = TPRefreshHeaderStateRefreshing;
        [self.lotView play];
        self.animating = YES;
        [UIView animateWithDuration:0.23 animations:^{
            UIEdgeInsets inset = UIEdgeInsetsMake(kDefaultRefreshHeight, 0, 0, 0);
            self.scrollView.contentInset = inset;
            self.scrollView.contentOffset = CGPointMake(0, 0);
            
        }completion:^(BOOL finished) {
            if (self.handle) {
                self.handle();
            }
        }];

    }else{
        if (self.status == TPRefreshHeaderStateNone) {
            self.status = TPRefreshHeaderStatePulling;
        }
    }
}

- (void)endRefreshing {
    [UIView animateWithDuration:0.22 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = 0.f;
        self.scrollView.contentInset = inset;
    } completion:^(BOOL finished) {
        self.status = TPRefreshHeaderStateNone;
        [_lotView stop];
        self.animating = NO;
    }];
}

@end
