//
//  UIColor+extension.m
//  BallsPoolDemo
//
//  Created by 郭建华 on 2020/9/29.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

#pragma mark - color

+ (UIColor *)randomColor{
    return [UIColor R:arc4random() % 255 G:arc4random() % 255 B:arc4random() % 255];
}

+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1];
}

+ (UIColor *)HEX:(NSInteger)hex{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1];
}

@end
