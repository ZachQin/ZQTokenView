//
//  ZQTokenView.h
//  ZQToken
//
//  Created by ZachQin on 16/8/25.
//  Copyright © 2016年 Buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZQTokenView;
@protocol ZQTokenViewDelegate <NSObject>
@optional
- (UIColor *)tokenView:(ZQTokenView *)tokenView colorForTitle:(NSString *)title;
- (void)tokenView:(ZQTokenView *)tokenView didSelectToken:(UILabel *)token atIndex:(NSInteger)index;
- (void)tokenView:(ZQTokenView *)tokenView didInsertToken:(UILabel *)token atIndex:(NSInteger)index;
- (void)tokenView:(ZQTokenView *)tokenView didRemoveTokenAtIndex:(NSInteger)index;
@end

@interface ZQTokenView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIColor *> *colorMap;
@property (strong, nonatomic) UIColor *defaultTokenColor;
@property (strong, nonatomic) UIColor *tokenSelectedColor;
@property (nonatomic) UIEdgeInsets edgeInset;
@property (nonatomic) NSInteger minimumTokenHorizontalSpacing;
@property (nonatomic) NSInteger minimumTokenVerticalSpacing;

@property (weak) id<ZQTokenViewDelegate> delegate;

- (void)insertToken:(NSString *)title intoIndex:(NSInteger)index;
- (void)removeTokenAtIndex:(NSInteger)index;
- (void)moveTokenFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex;
/**
 *  reverse tokens order.
 */
- (void)reverseTokens;
/**
 *  Reload the titleArray and update TokenView. Usually call it after changing titleArray or colorMap directly.
 */
- (void)reload;
@end
