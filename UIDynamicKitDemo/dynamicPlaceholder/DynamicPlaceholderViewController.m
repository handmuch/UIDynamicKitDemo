//
//  DynamicPlaceholderViewController.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2021/1/8.
//

#import "DynamicPlaceholderViewController.h"

#import "DynamicPlaceholderCollectionViewCell.h"

@interface DynamicPlaceholderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DynamicPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DynamicPlaceholder";
    [self initViews];
}

- (void)initViews {
    [self.view addSubview:self.collectionView];
}

#pragma mark - collectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DynamicPlaceholderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DynamicPlaceholderCollectionViewCell class]) forIndexPath:indexPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.testImage = [UIImage imageNamed:@"testImage.jpg"];
    });
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 200);
    }else if (indexPath.section == 1) {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 80, 160);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else if (section == 1) {
        return UIEdgeInsetsMake(0, 40, 0, 40);
    }
    return UIEdgeInsetsZero;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DynamicPlaceholderCollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([DynamicPlaceholderCollectionViewCell class])];
    }
    return _collectionView;
}

@end
