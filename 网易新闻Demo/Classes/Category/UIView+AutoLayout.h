//
//  UIView+AutoLayout.h
//  v2.0.0
//  https://github.com/smileyborg/UIView-AutoLayout
//
//  Copyright (c) 2012 Richard Turton
//  Copyright (c) 2013 Tyler Fox
//
#import <UIKit/UIKit.h>

#pragma mark ALAttributes

typedef NS_ENUM(NSInteger, ALEdge) {
    ALEdgeLeft = NSLayoutAttributeLeft,             // the left edge of the view
    ALEdgeRight = NSLayoutAttributeRight,           // the right edge of the view
    ALEdgeTop = NSLayoutAttributeTop,               // the top edge of the view
    ALEdgeBottom = NSLayoutAttributeBottom,         // the bottom edge of the view
    ALEdgeLeading = NSLayoutAttributeLeading,       // the leading edge of the view (left edge for left-to-right languages like English, right edge for right-to-left languages like Arabic)
    ALEdgeTrailing = NSLayoutAttributeTrailing      // the trailing edge of the view (right edge for left-to-right languages like English, left edge for right-to-left languages like Arabic)
};

typedef NS_ENUM(NSInteger, ALDimension) {
    ALDimensionWidth = NSLayoutAttributeWidth,      // the width of the view
    ALDimensionHeight = NSLayoutAttributeHeight     // the height of the view
};

typedef NS_ENUM(NSInteger, ALAxis) {
    ALAxisVertical = NSLayoutAttributeCenterX,      // a vertical line through the center of the view
    ALAxisHorizontal = NSLayoutAttributeCenterY,    // a horizontal line through the center of the view
    ALAxisBaseline = NSLayoutAttributeBaseline      // a horizontal line at the text baseline (not applicable to all views)
};

typedef void(^ALConstraintsBlock)(void);    // a block of method calls to the UIView+AutoLayout category API

#pragma mark - UIView+AutoLayout

@interface UIView (AutoLayout)


#pragma mark Factory & Initializer Methods
+ (instancetype)newAutoLayoutView;

- (instancetype)initForAutoLayout;


#pragma mark Set Constraint Priority

+ (void)autoSetPriority:(UILayoutPriority)priority forConstraints:(ALConstraintsBlock)block;


#pragma mark Remove Constraints

+ (void)autoRemoveConstraint:(NSLayoutConstraint *)constraint;
+ (void)autoRemoveConstraints:(NSArray *)constraints;

- (void)autoRemoveConstraintsAffectingView;

- (void)autoRemoveConstraintsAffectingViewIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints;

- (void)autoRemoveConstraintsAffectingViewAndSubviews;

- (void)autoRemoveConstraintsAffectingViewAndSubviewsIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints;

#pragma mark Center in Superview
- (NSArray *)autoCenterInSuperview;

- (NSLayoutConstraint *)autoAlignAxisToSuperviewAxis:(ALAxis)axis;

#pragma mark Pin Edges to Superview

- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset;

- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset relation:(NSLayoutRelation)relation;
- (NSArray *)autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets;

- (NSArray *)autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(ALEdge)edge;

#pragma mark Pin Edges
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView;

- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset;
- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;


#pragma mark Align Axes

- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView;

- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView withOffset:(CGFloat)offset;

#pragma mark Match Dimensions

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView;

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset;

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier;
- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier relation:(NSLayoutRelation)relation;

#pragma mark Set Dimensions

- (NSArray *)autoSetDimensionsToSize:(CGSize)size;

- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size;

- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size relation:(NSLayoutRelation)relation;

#pragma mark Set Content Compression Resistance & Hugging

- (void)autoSetContentCompressionResistancePriorityForAxis:(ALAxis)axis;

- (void)autoSetContentHuggingPriorityForAxis:(ALAxis)axis;

#pragma mark Constrain Any Attributes

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)attribute toAttribute:(NSInteger)toAttribute ofView:(UIView *)peerView;

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)attribute toAttribute:(NSInteger)toAttribute ofView:(UIView *)peerView withOffset:(CGFloat)offset;

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)attribute toAttribute:(NSInteger)toAttribute ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)attribute toAttribute:(NSInteger)toAttribute ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier;

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)attribute toAttribute:(NSInteger)toAttribute ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier relation:(NSLayoutRelation)relation;


#pragma mark Pin to Layout Guides

- (NSLayoutConstraint *)autoPinToTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

- (NSLayoutConstraint *)autoPinToBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

@end

#pragma mark - NSArray+AutoLayout

@interface NSArray (AutoLayout)

#pragma mark Constrain Multiple Views
- (NSArray *)autoAlignViewsToEdge:(ALEdge)edge;

- (NSArray *)autoAlignViewsToAxis:(ALAxis)axis;

- (NSArray *)autoMatchViewsDimension:(ALDimension)dimension;

- (NSArray *)autoSetViewsDimension:(ALDimension)dimension toSize:(CGFloat)size;

#pragma mark Distribute Multiple Views

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSpacing:(CGFloat)spacing alignment:(NSLayoutFormatOptions)alignment;

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSpacing:(CGFloat)spacing insetSpacing:(BOOL)shouldSpaceInsets alignment:(NSLayoutFormatOptions)alignment;

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSize:(CGFloat)size alignment:(NSLayoutFormatOptions)alignment;

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSize:(CGFloat)size insetSpacing:(BOOL)shouldSpaceInsets alignment:(NSLayoutFormatOptions)alignment;

@end

#pragma mark - NSLayoutConstraint+AutoLayout

@interface NSLayoutConstraint (AutoLayout)

- (void)autoInstall;
- (void)autoRemove;

@end
