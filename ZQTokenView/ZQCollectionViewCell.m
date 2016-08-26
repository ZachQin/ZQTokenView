//
//  ZQCollectionViewCell.m
//  ZQToken
//
//  Created by ZachQin on 16/8/25.
//  Copyright © 2016年 Buaa. All rights reserved.
//

#import "ZQCollectionViewCell.h"

@implementation ZQCollectionViewCell

#pragma mark - **************** init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.layer.cornerRadius = 10;
    self.selectedBackgroundView.layer.cornerRadius = 10;
    
    self.token = [[UILabel alloc] initWithFrame:CGRectZero];
    self.token.translatesAutoresizingMaskIntoConstraints = NO;
    self.token.textAlignment = NSTextAlignmentCenter;
    self.token.clipsToBounds = YES;
    self.token.textColor = [UIColor blackColor];
    self.token.font = [UIFont boldSystemFontOfSize:18];
    
    
    [self.contentView addSubview:self.token];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.token attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.token attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.token attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.token attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}

#pragma mark - **************** static cell color
+ (UIColor *)blueTintColor {
    return [UIColor colorWithRed:0.561 green:0.761 blue:0.976 alpha:1];
}

+ (UIColor *)purpleTintColor {
    return [UIColor colorWithRed:0.627 green:0.686 blue:0.969 alpha:1];
}

+ (UIColor *)grayTintColor {
    return [UIColor colorWithRed:0.812 green:0.812 blue:0.827 alpha:1];
}

+ (UIColor *)redTintColor {
    return [UIColor colorWithRed:1 green:0.15 blue:0.15 alpha:1];
}

+ (UIColor *)greenTintColor {
    return [UIColor colorWithRed:0.333 green:0.741 blue:0.235 alpha:1];
}

@end
