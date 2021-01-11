//
//  UIImageView+switchMethod.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2021/1/8.
//

#import "UIImageView+switchMethod.h"
#import "UIColor+extension.h"

#import <objc/runtime.h>

static NSString *contentModeKey = @"contentModeKey"; //那么的key
static NSString *backgroundColorKey = @"backgroundColorKey";

@implementation UIImageView (switchMethod)

+ (void)load {
    SEL origSel = @selector(setImage:);
    SEL swizSel = @selector(swiz_setImage:);
    
    [UIImageView swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
    
    SEL oriContentModelSel = @selector(setContentMode:);
    SEL swizContentModelSel = @selector(swiz_setContentModel:);
    [UIImageView swizzleMethods:[self class] originalSelector:oriContentModelSel swizzledSelector:swizContentModelSel];
    
    SEL oriBackgroundColorSel = @selector(setBackgroundColor:);
    SEL swizBackgroundColorlSel = @selector(swiz_setBackgroundColor:);
    [UIImageView swizzleMethods:[self class] originalSelector:oriBackgroundColorSel swizzledSelector:swizBackgroundColorlSel];
}

+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel
{
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
     
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

- (void)swiz_setImage:(UIImage *)image {
    
    if ([image.accessibilityLabel isEqualToString:@"image_loading"]) {
        self.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor HEX:0xE7EBEF];
    }else{
        self.contentMode = [self originContentMode];
        self.backgroundColor = [self originBackgroundColor];
    }
    [self swiz_setImage:image];
}

- (void)swiz_setContentModel:(UIViewContentMode)contentMode {
    if (contentMode != UIViewContentModeCenter) {
        [self setOriginContentMode:contentMode];
    }
    [self swiz_setContentModel:contentMode];
}

- (void)swiz_setBackgroundColor:(UIColor *)backgroundColor {
    if (CGColorEqualToColor([UIColor HEX:0xE7EBEF].CGColor, backgroundColor.CGColor)) {
        [self setOriginBackgroundColor:backgroundColor];
    }
    [self swiz_setBackgroundColor:backgroundColor];
}


/**
 setter方法
 */
- (void)setOriginContentMode:(UIViewContentMode)contentMode{
    objc_setAssociatedObject(self, &contentModeKey, @(contentMode), OBJC_ASSOCIATION_COPY);
}

/**
 getter方法
 */
- (UIViewContentMode )originContentMode {
    if (objc_getAssociatedObject(self, &contentModeKey)) {
        return [objc_getAssociatedObject(self, &contentModeKey) integerValue];
    }
    return UIViewContentModeScaleToFill;
}

/**
 setter方法
 */
- (void)setOriginBackgroundColor:(UIColor *)originBackgroundColor{
    objc_setAssociatedObject(self, &backgroundColorKey, originBackgroundColor, OBJC_ASSOCIATION_COPY);
}

/**
 getter方法
 */
- (UIColor *)originBackgroundColor {
    if (objc_getAssociatedObject(self, &backgroundColorKey)) {
        return objc_getAssociatedObject(self, &backgroundColorKey);
    }
    return [UIColor clearColor];
}


@end
