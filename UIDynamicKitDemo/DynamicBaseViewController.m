//
//  DynamicBaseViewController.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2020/11/17.
//

#import "DynamicBaseViewController.h"

@interface DynamicBaseViewController ()

@end

@implementation DynamicBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - lazyInit

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.01;
    }
    return _motionManager;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
//        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UICollisionBehavior *)collision {
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;//是否检测边界
//        [self.animator addBehavior:_collision];
    }
    return _collision;
}

- (UIAttachmentBehavior *)attach {
    if (!_attach) {
        _attach = [[UIAttachmentBehavior alloc] init];
    }
    return _attach;
}

- (UIPushBehavior *)push {
    if (!_push) {
        _push = [[UIPushBehavior alloc] init];
    }
    return _push;
}

- (UIDynamicItemBehavior *)dynamicItem {
    if (!_dynamicItem) {
        _dynamicItem = [[UIDynamicItemBehavior alloc] init];
    }
    return _dynamicItem;
}

@end
