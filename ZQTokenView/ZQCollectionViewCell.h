//
//  ZQCollectionViewCell.h
//  ZQToken
//
//  Created by ZachQin on 16/8/25.
//  Copyright © 2016年 Buaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *token;
+ (UIColor *)blueTintColor;
+ (UIColor *)redTintColor;
+ (UIColor *)greenTintColor;
+ (UIColor *)purpleTintColor;
+ (UIColor *)grayTintColor;
@end
