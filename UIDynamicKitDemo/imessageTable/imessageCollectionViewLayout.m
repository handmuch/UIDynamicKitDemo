//
//  imessageCollectionViewLayout.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2020/11/18.
//

#import "imessageCollectionViewLayout.h"

@interface imessageCollectionViewLayout ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation imessageCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = 1.0;
            spring.frequency = 0.6;
            [_animator addBehavior:spring];
        }
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return (NSArray<__kindof UICollectionViewLayoutAttributes *> *)[self.animator itemsInRect:rect];
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDeltaY = newBounds.origin.y - scrollView.bounds.origin.y;
    CGFloat scrollDeltaX = newBounds.origin.x - scrollView.bounds.origin.x;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    for (UIAttachmentBehavior *spring in self.animator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 2000;
        UICollectionViewLayoutAttributes *item = (id)spring.items.firstObject;
        CGPoint center = item.center;
        center.y += (scrollDeltaY > 0) ? MIN(scrollDeltaY, scrollDeltaY * scrollResistance) : MAX(scrollDeltaY, scrollDeltaY * scrollResistance);
        
        CGFloat distanceFromToucnX = fabs(touchLocation.x - anchorPoint.x);
        center.x += (scrollDeltaX > 0) ? MIN(scrollDeltaX, scrollDeltaX * distanceFromToucnX / 2000) : MAX(scrollDeltaX, scrollDeltaX * distanceFromToucnX / 2000);
        item.center = center;
        [self.animator updateItemUsingCurrentState:item];
        
    }
    return NO;
}

@end
