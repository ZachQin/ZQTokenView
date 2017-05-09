//
//  ZQReadyToDeleteView.m
//  ZQCollectionExample
//
//  Created by ZachQin on 16/8/25.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import "ZQReadyToDeleteView.h"

@implementation ZQReadyToDeleteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.5 green: 0.4 blue: 0.5 alpha: 1];
    // Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [fillColor setFill];
    [bezierPath fill];
    
    bezierPath = [UIBezierPath bezierPath];
    CGFloat quarterX = rect.size.width / 4;
    CGFloat quarterY = rect.size.height / 4;
    [bezierPath moveToPoint:CGPointMake(rect.origin.x + quarterX, rect.origin.y + quarterY)];
    [bezierPath addLineToPoint:CGPointMake(rect.origin.x + quarterX * 3, rect.origin.y + quarterY * 3)];
    [bezierPath moveToPoint:CGPointMake(rect.origin.x + quarterX * 3, rect.origin.y + quarterY)];
    [bezierPath addLineToPoint:CGPointMake(rect.origin.x + quarterX, rect.origin.y + quarterY * 3)];
    bezierPath.lineWidth = rect.size.width / 25;
    [bezierPath strokeWithBlendMode:kCGBlendModeClear alpha:0];
}


@end
