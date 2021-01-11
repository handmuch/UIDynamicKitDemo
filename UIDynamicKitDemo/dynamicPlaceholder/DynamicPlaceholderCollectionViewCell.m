//
//  DynamicPlaceholderCollectionViewCell.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2021/1/8.
//

#import "DynamicPlaceholderCollectionViewCell.h"

@interface DynamicPlaceholderCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DynamicPlaceholderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor blackColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"image_loading"];
    ///相关代码在UIImageView+switchMethod.h
    image.accessibilityLabel = @"image_loading";
    self.imageView.image = [UIImage imageNamed:@"image_loading"];
    [self.contentView addSubview:self.imageView];
}

- (void)setTestImage:(UIImage *)testImage {
    _testImage = testImage;
    self.imageView.image = testImage;
}

@end
