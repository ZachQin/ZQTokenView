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
- ( UIColor * _Nonnull )tokenView:(ZQTokenView * _Nonnull)tokenView colorForTitle:(NSString * _Nonnull)title;
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didSelectToken:(UILabel * _Nonnull)token atIndex:(NSInteger)index;
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didInsertToken:(UILabel * _Nonnull)token atIndex:(NSInteger)index;
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didRemoveTokenAtIndex:(NSInteger)index;
@end

@interface ZQTokenView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic, readonly, nonnull) UILabel *tokenPlaceHolderLabel;
@property (copy, nonatomic, nonnull) NSArray *titleArray;
@property (copy, nonatomic, nonnull) NSDictionary<NSString *, UIColor *> *colorMap;
@property (copy, nonatomic, nonnull) UIColor *defaultTokenColor;
@property (copy, nonatomic, nonnull) UIColor *tokenSelectedColor;
@property (nonatomic) UIEdgeInsets edgeInset;
@property (nonatomic) NSInteger minimumTokenHorizontalSpacing;
@property (nonatomic) NSInteger minimumTokenVerticalSpacing;

@property (weak, nullable) id<ZQTokenViewDelegate> delegate;

- (void)insertToken:(NSString * _Nonnull)title intoIndex:(NSInteger)index;
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
