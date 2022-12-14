//
//  MHSearchTypeViewController.m
//  WeChat
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 CoderMikeHe. All rights reserved.
//

#import "MHSearchTypeViewController.h"

@interface MHSearchTypeViewController ()<UIGestureRecognizerDelegate>
/// viewModel
//@property (nonatomic, readonly, strong) MHSearchTypeViewModel *viewModel;

/// coverView
@property (nonatomic, readwrite, weak) UIView *coverView;

/// 进度条
@property (nonatomic, readwrite, strong) UIProgressView *progressView;
@end

@implementation MHSearchTypeViewController
@dynamic viewModel;

- (void)dealloc{
    MHDealloc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 添加一个边缘手势
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGestureDetected:)];
    panGestureRecognizer.edges = UIRectEdgeLeft;
    [panGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    /// 添加一个侧滑跟随的蒙版
    UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    // 默认是不需要蒙版的 只有侧滑时才需要
    coverView.hidden = YES;
    self.coverView = coverView;
    [self.view addSubview:coverView];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.view).with.offset(0);
        make.width.mas_equalTo(MH_SCREEN_WIDTH);
        make.right.equalTo(self.view.mas_left).with.offset(0);
    }];
    
    /// 布局好tableView
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 布局好进度条View
    [self.view addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Override
- (void)bindViewModel {
    [super bindViewModel];
    
    // 监听搜索进度
    @weakify(self);
//    RAC(self.progressView, hidden) = RACObserve(self.viewModel, hidden);
//    [[RACObserve(self.viewModel, progress) distinctUntilChanged] subscribeNext:^(NSNumber *x) {
//        @strongify(self);
//        [self.progressView setProgress: x.floatValue animated:YES];
//    }];
}

#pragma mark - 辅助方法
-(void)_panGestureDetected:(UIScreenEdgePanGestureRecognizer *)recognizer{

    /*获取状态*/
    UIGestureRecognizerState state = [recognizer state];
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        if (state == UIGestureRecognizerStateBegan) {
            self.coverView.hidden = NO;
        }
        /*获取拖动的位置*/
        CGPoint translation = [recognizer translationInView:recognizer.view];
        /*每次都以传入的translation为起始参照*/
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, 0)];
        /*设置当前拖动的位置*/
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
//        if (recognizer.view.mh_left <= recognizer.view.mh_width * 0.5) {
//            // 归位
//            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [recognizer.view setTransform:CGAffineTransformIdentity];
//            } completion:^(BOOL finished) {
//            }];
//        }else {
//            // 返回
//            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [recognizer.view setTransform:CGAffineTransformMakeTranslation(recognizer.view.mh_width, 0)];
//            } completion:^(BOOL finished) {
//                /// 回调回去
//                [self.viewModel.popCommand execute:@1];
//                self.coverView.hidden = YES;
//            }];
//        }
        
    }
}

#pragma mark - UIGestureRecognizerDelegate
// 是否允许pan
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

/// 只有当系统侧滑手势失败了，才去触发ScrollView的滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Getter & Setter
- (UIProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressViewW = MH_SCREEN_WIDTH;
        CGFloat progressViewH = 3;
        CGFloat progressViewX = 0;
        CGFloat progressViewY = 0;
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH)];
        progressView.progressTintColor = [UIColor orangeColor];
        progressView.trackTintColor = [UIColor clearColor];
        self.progressView = progressView;
    }
    return _progressView;
}

@end
