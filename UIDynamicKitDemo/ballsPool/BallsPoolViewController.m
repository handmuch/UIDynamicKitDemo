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

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIView *buleBall;

@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic, strong) NSMutableArray *ballsPool;

@end

@implementation BallsPoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupMotionManager];
    [self showGravity];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ballsPool = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < 9; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (50 * i), 40, 40, 40)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 20;
        [self.view addSubview:ball];
        [self.ballsPool addObject:ball];
    }
    
    for (int i = 0; i < 8; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (55 * i), 95, 50, 50)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 25;
        [self.view addSubview:ball];
        [self.ballsPool addObject:ball];
    }
    
    for (int i = 0; i < 7; i++) {
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(10 + (60 * i), 150, 60, 60)];
        ball.backgroundColor = [UIColor randomColor];
        ball.layer.cornerRadius = 30;
        [self.view addSubview:ball];
        [self.ballsPool addObject:ball];
    }
}

- (void)setupMotionManager {
    self.motionManager = [[CMMotionManager alloc] init];
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
                                                     self.gravityBehavior.angle = xyTheta - M_PI_2;
                                                     NSLog(@"\n与水平夹角: %f\n自身旋转角度：%f", zTheta, xyTheta);
                                                 }];
     }
}

- (void)showGravity
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.ballsPool];
    [self.animator addBehavior:self.gravityBehavior];
    
    UIDynamicItemBehavior *ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.ballsPool];
    ballBehavior.elasticity = 0.3;
    ballBehavior.density = 5;
    ballBehavior.friction = 0.7;
    ballBehavior.resistance = 0.7;
    ballBehavior.allowsRotation = YES;
    [self.animator addBehavior:ballBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.ballsPool];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    [collisionBehavior addBoundaryWithIdentifier:@"floor"
                                       fromPoint:CGPointMake(0, self.view.bounds.size.height) toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.animator addBehavior:collisionBehavior];
}


@end
