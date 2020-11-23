//
//  BallsPoolViewController.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2020/9/29.
//

#import "BallsPoolViewController.h"

#import "UIColor+extension.h"
#import <CoreMotion/CoreMotion.h>

@interface BallsPoolViewController ()

@property (strong, nonatomic) UIView *buleBall;

@end

@implementation BallsPoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"BallsPool";
    
    [self initDynamicBehaviors];
    [self setupUI];
    [self setupMotionManager];
}

- (void)initDynamicBehaviors
{
    [self.animator addBehavior:self.gravity];
    
    self.dynamicItem.elasticity = 0.3;
    self.dynamicItem.density = 5;
    self.dynamicItem.friction = 0.7;
    self.dynamicItem.resistance = 0.7;
    self.dynamicItem.allowsRotation = YES;
    [self.animator addBehavior:self.dynamicItem];
    
    self.collision.collisionMode = UICollisionBehaviorModeEverything;
    [self.collision addBoundaryWithIdentifier:@"floor"
                                    fromPoint:CGPointMake(0, self.view.bounds.size.height)
                                      toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.animator addBehavior:self.collision];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    for (int i = 0; i < 9; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (50 * i), 40, 40, 40)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 20;
        [self.view addSubview:ball];
        [self.gravity addItem:ball];
        [self.dynamicItem addItem:ball];
        [self.collision addItem:ball];
    }
    
    for (int i = 0; i < 8; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (55 * i), 95, 50, 50)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 25;
        [self.view addSubview:ball];
        [self.gravity addItem:ball];
        [self.dynamicItem addItem:ball];
        [self.collision addItem:ball];
    }
    
    for (int i = 0; i < 7; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (60 * i), 150, 60, 60)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 30;
        [self.view addSubview:ball];
        [self.gravity addItem:ball];
        [self.dynamicItem addItem:ball];
        [self.collision addItem:ball];    }
}

- (void)setupMotionManager {
    if ([self.motionManager isDeviceMotionAvailable] && ![self.motionManager isDeviceMotionActive]) {
         [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMDeviceMotion * _Nullable motion,
                                                               NSError * _Nullable error) {
                                                     //2. Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等
                                                     //重力加速度在各个方向的分量
                                                     double gravityX = motion.gravity.x;
                                                     double gravityY = motion.gravity.y;
                                                     double gravityZ = motion.gravity.z;
                                                     
                                                     NSLog(@"\n重力:\nX：%f\nY：%f\nZ：%f", gravityX, gravityY, gravityZ);

                                                     //获取手机的倾斜角度(zTheta是手机与水平面的夹角， xyTheta是手机绕自身旋转的角度)：
                                                     double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
                                                     double xyTheta = atan2(gravityX,gravityY);
                                                     self.gravity.angle = xyTheta - M_PI_2;
                                                     NSLog(@"\n与水平夹角: %f\n自身旋转角度：%f", zTheta, xyTheta);
                                                 }];
     }
}


@end
