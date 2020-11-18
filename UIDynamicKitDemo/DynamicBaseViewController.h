//
//  DynamicBaseViewController.h
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2020/11/17.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicBaseViewController : UIViewController

/**
 运动管理对象
 */
@property (nonatomic, strong) CMMotionManager *motionManager;

/**
 物理仿真器(相当于一个存放运动行为的容器)
 */
@property (nonatomic, strong) UIDynamicAnimator *animator;

/**
 重力行为
 */
@property (nonatomic, strong) UIGravityBehavior *gravity;

/**
 碰撞行为
 */
@property (nonatomic, strong) UICollisionBehavior *collision;

/**
 吸附行为
 */
@property (nonatomic, strong) UIAttachmentBehavior *attach;

/**
 迅猛移动弹跳摆动行为
 */
@property (nonatomic, strong) UISnapBehavior *snap;

/**
 推动行为
 */
@property (nonatomic, strong) UIPushBehavior *push;

/**
 物体属性，如密度、弹性系数、摩擦系数、阻力、转动阻力等
 */
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItem;


@end

NS_ASSUME_NONNULL_END
