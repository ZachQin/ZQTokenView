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
/**
 *  Asks your delegate the token background color for specific token title.
 *
 *  @param tokenView The token view containing the token title.
 *  @param title     The token title.
 *
 *  @return The token background color.
 */
- ( UIColor * _Nonnull )tokenView:(ZQTokenView * _Nonnull)tokenView colorForTitle:(NSString * _Nonnull)title;
/**
 *  Asks your delegate whether insert the specific token title when type 'RETURN'. You can filter the unnecessary data here.
 *
 *  @param tokenView The token view containing the token title.
 *  @param title     The token title.
 *  @param index     The insertion destination index.
 *
 *  @return YES if the title is allowed to insert or NO if it is not.
 */
- (BOOL)tokenView:(ZQTokenView * _Nonnull)tokenView shoudInsertTitle:(NSString * _Nonnull)title atIndex:(NSInteger)index;
/**
 *  Asks your delegate whether remove the specific token title when type backspace or drag the token outside.
 *
 *  @param tokenView The token view containing the token title.
 *  @param title     The removed token title.
 *  @param index     The index of removed title.
 *
 *  @return YES if the title is allowed to insert or NO if it is not.
 */
- (BOOL)tokenView:(ZQTokenView * _Nonnull)tokenView shoudRemoveTitle:(NSString * _Nonnull)title atIndex:(NSInteger)index;
/**
 *  Tells the delegate that the title at the specified index was selected.
 *
 *  @param tokenView The token view containing the token label.
 *  @param token     The selected token label.
 *  @param index     The selected token index.
 */
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didSelectToken:(UILabel * _Nonnull)token atIndex:(NSInteger)index;
/**
 *  Give you a chance to change the inserted title after type 'RETURN'
 *
 *  @param tokenView The token view containing the token.
 *  @param title     The inserted origin token title.
 *  @param index     The inserted token index.
 *
 *  @return The new title to replace the orginal title.
 */
- (NSString * _Nonnull)tokenView:(ZQTokenView * _Nonnull)tokenView titleToReplaceOriginalTitle:(NSString * _Nonnull)title atIndex:(NSInteger)index;
/**
 *  Tells the delegate that the title at the specified index was Inserted. Usually called after typing 'RETURN'
 *
 *  @param tokenView The token view containing the token label.
 *  @param token     The inserted token label.
 *  @param index     The inserted token index.
 */
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didInsertToken:(UILabel * _Nonnull)token atIndex:(NSInteger)index;
/**
 *  Tells the delegate that the title at the specified index was removed. Usually called after typing backspace or drag the token outside. 
 *
 *  @param tokenView The token view containing the removed token label.
 *  @param index     The removed token index.
 */
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didRemoveTokenAtIndex:(NSInteger)index;
/**
 *  Tells the delegate that the token at the source index was moved to destination index.
 *
 *  @param tokenView        The token view containing the moved token label.
 *  @param sourceIndex      The index of the source token.
 *  @param destinationIndex The index of the destination token.
 */
- (void)tokenView:(ZQTokenView * _Nonnull)tokenView didMoveItemAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex;

@end

@interface ZQTokenView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic, readonly, nonnull) UILabel *tokenPlaceHolderLabel;
@property (nonatomic, getter=isContainClearButton) BOOL containClearButton;
@property (strong, nonatomic, readonly, nonnull) UIButton *clearButton;
@property (copy, nonatomic, nonnull) NSArray *titleArray;
@property (copy, nonatomic, nonnull) NSDictionary<NSString *, UIColor *> *colorMap;
@property (copy, nonatomic, nonnull) UIColor *defaultTokenColor;
@property (copy, nonatomic, nonnull) UIColor *tokenSelectedColor;
@property (nonatomic) UIEdgeInsets edgeInset;
@property (nonatomic) NSInteger minimumTokenHorizontalSpacing;
@property (nonatomic) NSInteger minimumTokenVerticalSpacing;

@property (weak, nullable) id<ZQTokenViewDelegate> delegate;
/**
 *  Insert token with title to the specific index. Delegate will NOT be called.
 *
 *  @param title The inserted token title.
 *  @param index The insertion destination index.
 */
- (void)insertToken:(NSString * _Nonnull)title intoIndex:(NSInteger)index;
/**
 *  Remove token at the specific index. Delegate will NOT be called.
 *
 *  @param index The token index to be removed.
 */
- (void)removeTokenAtIndex:(NSInteger)index;
/**
 *  Move token from source index to destination index.
 *
 *  @param sourceIndex      The source token index.
 *  @param destinationIndex The destination token index.
 */
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
