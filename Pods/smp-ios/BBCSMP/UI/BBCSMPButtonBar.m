//
//  BBCSMPButtonBar.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPButtonBar.h"

@interface BBCSMPButtonBar ()

@property (nonatomic, strong) NSMutableOrderedSet* buttons;
@property (nonatomic, strong) BBCSMPBrand* brand;

@end

@implementation BBCSMPButtonBar

const CGFloat kBBCSMPButtonBarButtonWidthDefault = 44.0f;
const CGFloat kBBCSMPButtonBarButtonSeparationDefault = 1.0f;

- (void)dealloc
{
    for (UIView *button in _buttons) {
        [self removeHiddenObservationForButton:button];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = NO;
    self.buttonWidth = kBBCSMPButtonBarButtonWidthDefault;
    self.buttonSeparation = kBBCSMPButtonBarButtonSeparationDefault;
    self.buttons = [NSMutableOrderedSet orderedSet];
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    if (_brand == brand)
        return;
    
    _brand = brand;
    for (UIView* view in _buttons) {
        if ([view conformsToProtocol:@protocol(BBCSMPBrandable)]) {
            [(id<BBCSMPBrandable>)view setBrand:_brand];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"hidden"]) {
        [[self superview] setNeedsLayout];
    }
}

- (void)addButton:(UIView*)button
{
    NSAssert([button isKindOfClass:[UIView class]], @"Tried to add a button that wasn't a UIView");
    
    [button addObserver:self forKeyPath:@"hidden" options:0 context:NULL];
    
    if (_alignment == BBCSMPButtonBarAlignmentRight) {
        [_buttons insertObject:button atIndex:0];
    }
    else {
        [_buttons addObject:button];
    }
    if ([button conformsToProtocol:@protocol(BBCSMPBrandable)]) {
        [(id<BBCSMPBrandable>)button setBrand:_brand];
    }
    if ([button isKindOfClass:[UIControl class]]) {
        UIControl* control = (UIControl*)button;
        [control addTarget:self action:@selector(buttonTouchStarted) forControlEvents:UIControlEventTouchDown];
        [control addTarget:self action:@selector(buttonTouchEnded) forControlEvents:UIControlEventTouchCancel];
        [control addTarget:self action:@selector(buttonTouchEnded) forControlEvents:UIControlEventTouchUpInside];
        [control addTarget:self action:@selector(buttonTouchEnded) forControlEvents:UIControlEventTouchUpOutside];
    }
    [self addSubview:button];
    [self setNeedsLayout];
}

- (void)removeButton:(UIView*)button
{
    if (![_buttons containsObject:button]) {
        return;
    }
    
    [self removeHiddenObservationForButton:button];
    [_buttons removeObject:button];
    [button removeFromSuperview];
    [self setNeedsLayout];
}

- (void)removeAllButtons
{
    for (UIView* button in _buttons) {
        [button removeFromSuperview];
        [self removeHiddenObservationForButton:button];
    }
    
    [_buttons removeAllObjects];
}

- (void)removeHiddenObservationForButton:(UIView *)button
{
    [button removeObserver:self forKeyPath:@"hidden"];
}

- (CGFloat)requiredWidth
{
    CGFloat requiredWidth = 0;
    for (UIView* button in [self visibleButtons]) {
        CGFloat buttonWidth = [button sizeThatFits:CGSizeMake(self.bounds.size.height, self.bounds.size.height)].width;
        requiredWidth += buttonWidth + (buttonWidth > 0 ? _buttonSeparation : 0);
    }
    return MAX(requiredWidth, 8.0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat offset = 0;
    for (UIView* button in [self visibleButtons]) {
        button.frame = CGRectMake(offset, 0, [button sizeThatFits:CGSizeMake(self.bounds.size.height, self.bounds.size.height)].width, self.bounds.size.height);
        offset += button.frame.size.width + (button.frame.size.width > 0 ? _buttonSeparation : 0);
    }
}

- (void)buttonTouchStarted
{
    [_delegate buttonTouchStarted];
}

- (void)buttonTouchEnded
{
    [_delegate buttonTouchEnded];
}

- (NSArray*)visibleButtons
{
    return [_buttons.array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"hidden == NO"]];
}

@end
