//
//  UIView+AutoLayout.m
//  v2.0.0
//  https://github.com/smileyborg/UIView-AutoLayout
//
//  Copyright (c) 2012 Richard Turton
//  Copyright (c) 2013 Tyler Fox
//
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "UIView+AutoLayout.h"

#pragma mark - UIView+AutoLayout

@implementation UIView (AutoLayout)

#pragma mark Factory & Initializer Methods

+ (instancetype)newAutoLayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (instancetype)initForAutoLayout
{
    self = [self init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

#pragma mark Set Constraint Priority

static UILayoutPriority _al_globalConstraintPriority = UILayoutPriorityRequired;

static BOOL _al_isExecutingConstraintsBlock = NO;

+ (void)autoSetPriority:(UILayoutPriority)priority forConstraints:(ALConstraintsBlock)block
{
    NSAssert(block, @"The constraints block cannot be nil.");
    if (block) {
        _al_globalConstraintPriority = priority;
        _al_isExecutingConstraintsBlock = YES;
        block();
        _al_isExecutingConstraintsBlock = NO;
        _al_globalConstraintPriority = UILayoutPriorityRequired;
    }
}

#pragma mark Remove Constraints

+ (void)autoRemoveConstraint:(NSLayoutConstraint *)constraint
{
    if (constraint.secondItem) {
        UIView *commonSuperview = [constraint.firstItem al_commonSuperviewWithView:constraint.secondItem];
        while (commonSuperview) {
            if ([commonSuperview.constraints containsObject:constraint]) {
                [commonSuperview removeConstraint:constraint];
                return;
            }
            commonSuperview = commonSuperview.superview;
        }
    }
    else {
        [constraint.firstItem removeConstraint:constraint];
        return;
    }
    NSAssert(nil, @"Failed to remove constraint: %@", constraint);
}

+ (void)autoRemoveConstraints:(NSArray *)constraints
{
    for (id object in constraints) {
        if ([object isKindOfClass:[NSLayoutConstraint class]]) {
            [self autoRemoveConstraint:((NSLayoutConstraint *)object)];
        } else {
            NSAssert(nil, @"All constraints to remove must be instances of NSLayoutConstraint.");
        }
    }
}

- (void)autoRemoveConstraintsAffectingView
{
    [self autoRemoveConstraintsAffectingViewIncludingImplicitConstraints:NO];
}

- (void)autoRemoveConstraintsAffectingViewIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints
{
    NSMutableArray *constraintsToRemove = [NSMutableArray new];
    UIView *startView = self;
    do {
        for (NSLayoutConstraint *constraint in startView.constraints) {
            BOOL isImplicitConstraint = [NSStringFromClass([constraint class]) isEqualToString:@"NSContentSizeLayoutConstraint"];
            if (shouldRemoveImplicitConstraints || !isImplicitConstraint) {
                if (constraint.firstItem == self || constraint.secondItem == self) {
                    [constraintsToRemove addObject:constraint];
                }
            }
        }
        startView = startView.superview;
    } while (startView);
    [UIView autoRemoveConstraints:constraintsToRemove];
}

- (void)autoRemoveConstraintsAffectingViewAndSubviews
{
    [self autoRemoveConstraintsAffectingViewAndSubviewsIncludingImplicitConstraints:NO];
}

- (void)autoRemoveConstraintsAffectingViewAndSubviewsIncludingImplicitConstraints:(BOOL)shouldRemoveImplicitConstraints
{
    [self autoRemoveConstraintsAffectingViewIncludingImplicitConstraints:shouldRemoveImplicitConstraints];
    for (UIView *subview in self.subviews) {
        [subview autoRemoveConstraintsAffectingViewAndSubviewsIncludingImplicitConstraints:shouldRemoveImplicitConstraints];
    }
}

#pragma mark Center in Superview

- (NSArray *)autoCenterInSuperview
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self autoAlignAxisToSuperviewAxis:ALAxisHorizontal]];
    [constraints addObject:[self autoAlignAxisToSuperviewAxis:ALAxisVertical]];
    return constraints;
}

- (NSLayoutConstraint *)autoAlignAxisToSuperviewAxis:(ALAxis)axis
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    NSLayoutAttribute attribute = [UIView al_attributeForAxis:axis];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:superview attribute:attribute multiplier:1.0f constant:0.0f];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Pin Edges to Superview

- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset
{
    return [self autoPinEdgeToSuperviewEdge:edge withInset:inset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoPinEdgeToSuperviewEdge:(ALEdge)edge withInset:(CGFloat)inset relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    if (edge == ALEdgeBottom || edge == ALEdgeRight || edge == ALEdgeTrailing) {
        // The bottom, right, and trailing insets (and relations, if an inequality) are inverted to become offsets
        inset = -inset;
        if (relation == NSLayoutRelationLessThanOrEqual) {
            relation = NSLayoutRelationGreaterThanOrEqual;
        } else if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation = NSLayoutRelationLessThanOrEqual;
        }
    }
    return [self autoPinEdge:edge toEdge:edge ofView:superview withOffset:inset relation:relation];
}

- (NSArray *)autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:insets.top]];
    [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:insets.left]];
    [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:insets.bottom]];
    [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:insets.right]];
    return constraints;
}

- (NSArray *)autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(ALEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray new];
    if (edge != ALEdgeTop) {
        [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:insets.top]];
    }
    if (edge != ALEdgeLeading && edge != ALEdgeLeft) {
        [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:insets.left]];
    }
    if (edge != ALEdgeBottom) {
        [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:insets.bottom]];
    }
    if (edge != ALEdgeTrailing && edge != ALEdgeRight) {
        [constraints addObject:[self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:insets.right]];
    }
    return constraints;
}

#pragma mark Pin Edges

- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView
{
    return [self autoPinEdge:edge toEdge:toEdge ofView:peerView withOffset:0.0f];
}


- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset
{
    return [self autoPinEdge:edge toEdge:toEdge ofView:peerView withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoPinEdge:(ALEdge)edge toEdge:(ALEdge)toEdge ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForEdge:edge];
    NSLayoutAttribute toAttribute = [UIView al_attributeForEdge:toEdge];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerView attribute:toAttribute multiplier:1.0f constant:offset];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Align Axes

- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView
{
    return [self autoAlignAxis:axis toSameAxisOfView:peerView withOffset:0.0f];
}

- (NSLayoutConstraint *)autoAlignAxis:(ALAxis)axis toSameAxisOfView:(UIView *)peerView withOffset:(CGFloat)offset
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForAxis:axis];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:peerView attribute:attribute multiplier:1.0f constant:offset];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Match Dimensions

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView
{
    return [self autoMatchDimension:dimension toDimension:toDimension ofView:peerView withOffset:0.0f];
}

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset
{
    return [self autoMatchDimension:dimension toDimension:toDimension ofView:peerView withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForDimension:dimension];
    NSLayoutAttribute toAttribute = [UIView al_attributeForDimension:toDimension];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerView attribute:toAttribute multiplier:1.0f constant:offset];
    [constraint autoInstall];
    return constraint;
}

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier
{
    return [self autoMatchDimension:dimension toDimension:toDimension ofView:peerView withMultiplier:multiplier relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoMatchDimension:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForDimension:dimension];
    NSLayoutAttribute toAttribute = [UIView al_attributeForDimension:toDimension];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerView attribute:toAttribute multiplier:multiplier constant:0.0f];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Set Dimensions

- (NSArray *)autoSetDimensionsToSize:(CGSize)size
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self autoSetDimension:ALDimensionWidth toSize:size.width]];
    [constraints addObject:[self autoSetDimension:ALDimensionHeight toSize:size.height]];
    return constraints;
}

- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size
{
    return [self autoSetDimension:dimension toSize:size relation:NSLayoutRelationEqual];
}
- (NSLayoutConstraint *)autoSetDimension:(ALDimension)dimension toSize:(CGFloat)size relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForDimension:dimension];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:size];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Set Content Compression Resistance & Hugging

- (void)autoSetContentCompressionResistancePriorityForAxis:(ALAxis)axis
{
    NSAssert(_al_isExecutingConstraintsBlock, @"%@ should only be called from within the block passed into the method +[UIView autoSetPriority:forConstraints:]", NSStringFromSelector(_cmd));
    if (_al_isExecutingConstraintsBlock) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        UILayoutConstraintAxis constraintAxis = [UIView al_constraintAxisForAxis:axis];
        [self setContentCompressionResistancePriority:_al_globalConstraintPriority forAxis:constraintAxis];
    }
}

- (void)autoSetContentHuggingPriorityForAxis:(ALAxis)axis
{
    NSAssert(_al_isExecutingConstraintsBlock, @"%@ should only be called from within the block passed into the method +[UIView autoSetPriority:forConstraints:]", NSStringFromSelector(_cmd));
    if (_al_isExecutingConstraintsBlock) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        UILayoutConstraintAxis constraintAxis = [UIView al_constraintAxisForAxis:axis];
        [self setContentHuggingPriority:_al_globalConstraintPriority forAxis:constraintAxis];
    }
}

#pragma mark Constrain Any Attributes

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)ALAttribute toAttribute:(NSInteger)toALAttribute ofView:(UIView *)peerView
{
    return [self autoConstrainAttribute:ALAttribute toAttribute:toALAttribute ofView:peerView withOffset:0.0f];
}

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)ALAttribute toAttribute:(NSInteger)toALAttribute ofView:(UIView *)peerView withOffset:(CGFloat)offset
{
    return [self autoConstrainAttribute:ALAttribute toAttribute:toALAttribute ofView:peerView withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)ALAttribute toAttribute:(NSInteger)toALAttribute ofView:(UIView *)peerView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForALAttribute:ALAttribute];
    NSLayoutAttribute toAttribute = [UIView al_attributeForALAttribute:toALAttribute];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerView attribute:toAttribute multiplier:1.0f constant:offset];
    [constraint autoInstall];
    return constraint;
}

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)ALAttribute toAttribute:(NSInteger)toALAttribute ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier
{
    return [self autoConstrainAttribute:ALAttribute toAttribute:toALAttribute ofView:peerView withMultiplier:multiplier relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)autoConstrainAttribute:(NSInteger)ALAttribute toAttribute:(NSInteger)toALAttribute ofView:(UIView *)peerView withMultiplier:(CGFloat)multiplier relation:(NSLayoutRelation)relation
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [UIView al_attributeForALAttribute:ALAttribute];
    NSLayoutAttribute toAttribute = [UIView al_attributeForALAttribute:toALAttribute];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerView attribute:toAttribute multiplier:multiplier constant:0.0f];
    [constraint autoInstall];
    return constraint;
}

#pragma mark Pin to Layout Guides

- (NSLayoutConstraint *)autoPinToTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        return [self autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:viewController.view withOffset:inset];
    } else {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:viewController.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0f constant:inset];
        [viewController.view al_addConstraintUsingGlobalPriority:constraint];
        return constraint;
    }
}

- (NSLayoutConstraint *)autoPinToBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        return [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:viewController.view withOffset:-inset];
    } else {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:viewController.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0f constant:-inset];
        [viewController.view al_addConstraintUsingGlobalPriority:constraint];
        return constraint;
    }
}

#pragma mark Internal Helper Methods

- (void)al_addConstraintUsingGlobalPriority:(NSLayoutConstraint *)constraint
{
    constraint.priority = _al_globalConstraintPriority;
    [self addConstraint:constraint];
}

+ (NSLayoutAttribute)al_attributeForEdge:(ALEdge)edge
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    switch (edge) {
        case ALEdgeLeft:
            attribute = NSLayoutAttributeLeft;
            break;
        case ALEdgeRight:
            attribute = NSLayoutAttributeRight;
            break;
        case ALEdgeTop:
            attribute = NSLayoutAttributeTop;
            break;
        case ALEdgeBottom:
            attribute = NSLayoutAttributeBottom;
            break;
        case ALEdgeLeading:
            attribute = NSLayoutAttributeLeading;
            break;
        case ALEdgeTrailing:
            attribute = NSLayoutAttributeTrailing;
            break;
        default:
            NSAssert(nil, @"Not a valid ALEdge.");
            break;
    }
    return attribute;
}

+ (NSLayoutAttribute)al_attributeForAxis:(ALAxis)axis
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    switch (axis) {
        case ALAxisVertical:
            attribute = NSLayoutAttributeCenterX;
            break;
        case ALAxisHorizontal:
            attribute = NSLayoutAttributeCenterY;
            break;
        case ALAxisBaseline:
            attribute = NSLayoutAttributeBaseline;
            break;
        default:
            NSAssert(nil, @"Not a valid ALAxis.");
            break;
    }
    return attribute;
}

+ (NSLayoutAttribute)al_attributeForDimension:(ALDimension)dimension
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    switch (dimension) {
        case ALDimensionWidth:
            attribute = NSLayoutAttributeWidth;
            break;
        case ALDimensionHeight:
            attribute = NSLayoutAttributeHeight;
            break;
        default:
            NSAssert(nil, @"Not a valid ALDimension.");
            break;
    }
    return attribute;
}

+ (NSLayoutAttribute)al_attributeForALAttribute:(NSInteger)ALAttribute
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    switch (ALAttribute) {
        case ALEdgeLeft:
            attribute = NSLayoutAttributeLeft;
            break;
        case ALEdgeRight:
            attribute = NSLayoutAttributeRight;
            break;
        case ALEdgeTop:
            attribute = NSLayoutAttributeTop;
            break;
        case ALEdgeBottom:
            attribute = NSLayoutAttributeBottom;
            break;
        case ALEdgeLeading:
            attribute = NSLayoutAttributeLeading;
            break;
        case ALEdgeTrailing:
            attribute = NSLayoutAttributeTrailing;
            break;
        case ALDimensionWidth:
            attribute = NSLayoutAttributeWidth;
            break;
        case ALDimensionHeight:
            attribute = NSLayoutAttributeHeight;
            break;
        case ALAxisVertical:
            attribute = NSLayoutAttributeCenterX;
            break;
        case ALAxisHorizontal:
            attribute = NSLayoutAttributeCenterY;
            break;
        case ALAxisBaseline:
            attribute = NSLayoutAttributeBaseline;
            break;
        default:
            NSAssert(nil, @"Not a valid ALAttribute.");
            break;
    }
    return attribute;
}

+ (UILayoutConstraintAxis)al_constraintAxisForAxis:(ALAxis)axis
{
    UILayoutConstraintAxis constraintAxis;
    switch (axis) {
        case ALAxisVertical:
            constraintAxis = UILayoutConstraintAxisVertical;
            break;
        case ALAxisHorizontal:
        case ALAxisBaseline:
            constraintAxis = UILayoutConstraintAxisHorizontal;
            break;
        default:
            NSAssert(nil, @"Not a valid ALAxis.");
            break;
    }
    return constraintAxis;
}

- (UIView *)al_commonSuperviewWithView:(UIView *)peerView
{
    UIView *commonSuperview = nil;
    UIView *startView = self;
    do {
        if ([peerView isDescendantOfView:startView]) {
            commonSuperview = startView;
        }
        startView = startView.superview;
    } while (startView && !commonSuperview);
    NSAssert(commonSuperview, @"Can't constrain two views that do not share a common superview. Make sure that both views have been added into the same view hierarchy.");
    return commonSuperview;
}

- (NSLayoutConstraint *)al_alignToView:(UIView *)peerView withOption:(NSLayoutFormatOptions)alignment forAxis:(ALAxis)axis
{
    NSLayoutConstraint *constraint = nil;
    switch (alignment) {
        case NSLayoutFormatAlignAllCenterX:
            NSAssert(axis == ALAxisVertical, @"Cannot align views that are distributed horizontally with NSLayoutFormatAlignAllCenterX.");
            constraint = [self autoAlignAxis:ALAxisVertical toSameAxisOfView:peerView];
            break;
        case NSLayoutFormatAlignAllCenterY:
            NSAssert(axis != ALAxisVertical, @"Cannot align views that are distributed vertically with NSLayoutFormatAlignAllCenterY.");
            constraint = [self autoAlignAxis:ALAxisHorizontal toSameAxisOfView:peerView];
            break;
        case NSLayoutFormatAlignAllBaseline:
            NSAssert(axis != ALAxisVertical, @"Cannot align views that are distributed vertically with NSLayoutFormatAlignAllBaseline.");
            constraint = [self autoAlignAxis:ALAxisBaseline toSameAxisOfView:peerView];
            break;
        case NSLayoutFormatAlignAllTop:
            NSAssert(axis != ALAxisVertical, @"Cannot align views that are distributed vertically with NSLayoutFormatAlignAllTop.");
            constraint = [self autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:peerView];
            break;
        case NSLayoutFormatAlignAllLeft:
            NSAssert(axis == ALAxisVertical, @"Cannot align views that are distributed horizontally with NSLayoutFormatAlignAllLeft.");
            constraint = [self autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:peerView];
            break;
        case NSLayoutFormatAlignAllBottom:
            NSAssert(axis != ALAxisVertical, @"Cannot align views that are distributed vertically with NSLayoutFormatAlignAllBottom.");
            constraint = [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:peerView];
            break;
        case NSLayoutFormatAlignAllRight:
            NSAssert(axis == ALAxisVertical, @"Cannot align views that are distributed horizontally with NSLayoutFormatAlignAllRight.");
            constraint = [self autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:peerView];
            break;
        case NSLayoutFormatAlignAllLeading:
            NSAssert(axis == ALAxisVertical, @"Cannot align views that are distributed horizontally with NSLayoutFormatAlignAllLeading.");
            constraint = [self autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:peerView];
            break;
        case NSLayoutFormatAlignAllTrailing:
            NSAssert(axis == ALAxisVertical, @"Cannot align views that are distributed horizontally with NSLayoutFormatAlignAllTrailing.");
            constraint = [self autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:peerView];
            break;
        default:
            NSAssert(nil, @"Unsupported alignment option.");
            break;
    }
    return constraint;
}

@end

#pragma mark - NSArray+AutoLayout

@implementation NSArray (AutoLayout)

#pragma mark Constrain Multiple Views

- (NSArray *)autoAlignViewsToEdge:(ALEdge)edge
{
    NSAssert([self al_containsMinimumNumberOfViews:2], @"This array must contain at least 2 views.");
    NSMutableArray *constraints = [NSMutableArray new];
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            if (previousView) {
                [constraints addObject:[view autoPinEdge:edge toEdge:edge ofView:previousView]];
            }
            previousView = view;
        }
    }
    return constraints;
}

- (NSArray *)autoAlignViewsToAxis:(ALAxis)axis
{
    NSAssert([self al_containsMinimumNumberOfViews:2], @"This array must contain at least 2 views.");
    NSMutableArray *constraints = [NSMutableArray new];
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            if (previousView) {
                [constraints addObject:[view autoAlignAxis:axis toSameAxisOfView:previousView]];
            }
            previousView = view;
        }
    }
    return constraints;
}

- (NSArray *)autoMatchViewsDimension:(ALDimension)dimension
{
    NSAssert([self al_containsMinimumNumberOfViews:2], @"This array must contain at least 2 views.");
    NSMutableArray *constraints = [NSMutableArray new];
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            if (previousView) {
                [constraints addObject:[view autoMatchDimension:dimension toDimension:dimension ofView:previousView]];
            }
            previousView = view;
        }
    }
    return constraints;
}

- (NSArray *)autoSetViewsDimension:(ALDimension)dimension toSize:(CGFloat)size
{
    NSAssert([self al_containsMinimumNumberOfViews:1], @"This array must contain at least 1 view.");
    NSMutableArray *constraints = [NSMutableArray new];
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [constraints addObject:[view autoSetDimension:dimension toSize:size]];
        }
    }
    return constraints;
}

#pragma mark Distribute Multiple Views

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSpacing:(CGFloat)spacing alignment:(NSLayoutFormatOptions)alignment
{
    return [self autoDistributeViewsAlongAxis:axis withFixedSpacing:spacing insetSpacing:YES alignment:alignment];
}

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSpacing:(CGFloat)spacing insetSpacing:(BOOL)shouldSpaceInsets alignment:(NSLayoutFormatOptions)alignment
{
    NSAssert([self al_containsMinimumNumberOfViews:2], @"This array must contain at least 2 views to distribute.");
    ALDimension matchedDimension;
    ALEdge firstEdge, lastEdge;
    switch (axis) {
        case ALAxisHorizontal:
        case ALAxisBaseline:
            matchedDimension = ALDimensionWidth;
            firstEdge = ALEdgeLeading;
            lastEdge = ALEdgeTrailing;
            break;
        case ALAxisVertical:
            matchedDimension = ALDimensionHeight;
            firstEdge = ALEdgeTop;
            lastEdge = ALEdgeBottom;
            break;
        default:
            NSAssert(nil, @"Not a valid ALAxis.");
            return nil;
    }
    CGFloat leadingSpacing = shouldSpaceInsets ? spacing : 0.0;
    CGFloat trailingSpacing = shouldSpaceInsets ? spacing : 0.0;
    
    NSMutableArray *constraints = [NSMutableArray new];
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            if (previousView) {
                // Second, Third, ... View
                [constraints addObject:[view autoPinEdge:firstEdge toEdge:lastEdge ofView:previousView withOffset:spacing]];
                [constraints addObject:[view autoMatchDimension:matchedDimension toDimension:matchedDimension ofView:previousView]];
                [constraints addObject:[view al_alignToView:previousView withOption:alignment forAxis:axis]];
            }
            else {
                // First view
                [constraints addObject:[view autoPinEdgeToSuperviewEdge:firstEdge withInset:leadingSpacing]];
            }
            previousView = view;
        }
    }
    if (previousView) {
        // Last View
        [constraints addObject:[previousView autoPinEdgeToSuperviewEdge:lastEdge withInset:trailingSpacing]];
    }
    return constraints;
}

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSize:(CGFloat)size alignment:(NSLayoutFormatOptions)alignment
{
    return [self autoDistributeViewsAlongAxis:axis withFixedSize:size insetSpacing:YES alignment:alignment];
}

- (NSArray *)autoDistributeViewsAlongAxis:(ALAxis)axis withFixedSize:(CGFloat)size insetSpacing:(BOOL)shouldSpaceInsets alignment:(NSLayoutFormatOptions)alignment
{
    NSAssert([self al_containsMinimumNumberOfViews:2], @"This array must contain at least 2 views to distribute.");
    ALDimension fixedDimension;
    NSLayoutAttribute attribute;
    switch (axis) {
        case ALAxisHorizontal:
        case ALAxisBaseline:
            fixedDimension = ALDimensionWidth;
            attribute = NSLayoutAttributeCenterX;
            break;
        case ALAxisVertical:
            fixedDimension = ALDimensionHeight;
            attribute = NSLayoutAttributeCenterY;
            break;
        default:
            NSAssert(nil, @"Not a valid ALAxis.");
            return nil;
    }
    BOOL isRightToLeftLanguage = [NSLocale characterDirectionForLanguage:[[NSBundle mainBundle] preferredLocalizations][0]] == NSLocaleLanguageDirectionRightToLeft;
    BOOL shouldFlipOrder = isRightToLeftLanguage && (axis != ALAxisVertical); // imitate the effect of leading/trailing when distributing horizontally
    
    NSMutableArray *constraints = [NSMutableArray new];
    NSArray *views = [self al_copyViewsOnly];
    NSUInteger numberOfViews = [views count];
    UIView *commonSuperview = [views al_commonSuperviewOfViews];
    UIView *previousView = nil;
    for (NSUInteger i = 0; i < numberOfViews; i++) {
        UIView *view = shouldFlipOrder ? views[numberOfViews - i - 1] : views[i];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [constraints addObject:[view autoSetDimension:fixedDimension toSize:size]];
        CGFloat multiplier, constant;
        if (shouldSpaceInsets) {
            multiplier = (i * 2.0f + 2.0f) / (numberOfViews + 1.0f);
            constant = (multiplier - 1.0f) * size / 2.0f;
        } else {
            multiplier = (i * 2.0f) / (numberOfViews - 1.0f);
            constant = (-multiplier + 1.0f) * size / 2.0f;
        }
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:commonSuperview attribute:attribute multiplier:multiplier constant:constant];
        [commonSuperview al_addConstraintUsingGlobalPriority:constraint];
        [constraints addObject:constraint];
        if (previousView) {
            [constraints addObject:[view al_alignToView:previousView withOption:alignment forAxis:axis]];
        }
        previousView = view;
    }
    return constraints;
}

#pragma mark Internal Helper Methods

- (UIView *)al_commonSuperviewOfViews
{
    UIView *commonSuperview = nil;
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            if (previousView) {
                commonSuperview = [view al_commonSuperviewWithView:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

- (BOOL)al_containsMinimumNumberOfViews:(NSUInteger)minimumNumberOfViews
{
    NSUInteger numberOfViews = 0;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            numberOfViews++;
            if (numberOfViews >= minimumNumberOfViews) {
                return YES;
            }
        }
    }
    return numberOfViews >= minimumNumberOfViews;
}

- (NSArray *)al_copyViewsOnly
{
    NSMutableArray *viewsOnlyArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            [viewsOnlyArray addObject:object];
        }
    }
    return viewsOnlyArray;
}

@end

#pragma mark - NSLayoutConstraint+AutoLayout

@implementation NSLayoutConstraint (AutoLayout)
- (void)autoInstall
{
    NSAssert(self.firstItem || self.secondItem, @"Can't install a constraint with nil firstItem and secondItem.");
    if (self.firstItem) {
        if (self.secondItem) {
            NSAssert([self.firstItem isKindOfClass:[UIView class]] && [self.secondItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if both items are views.");
            UIView *commonSuperview = [self.firstItem al_commonSuperviewWithView:self.secondItem];
            [commonSuperview al_addConstraintUsingGlobalPriority:self];
        } else {
            NSAssert([self.firstItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if the item is a view.");
            [self.firstItem al_addConstraintUsingGlobalPriority:self];
        }
    } else {
        NSAssert([self.secondItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if the item is a view.");
        [self.secondItem al_addConstraintUsingGlobalPriority:self];
    }
}

- (void)autoRemove
{
    [UIView autoRemoveConstraint:self];
}

@end
