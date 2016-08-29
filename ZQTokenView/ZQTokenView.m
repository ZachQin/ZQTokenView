//
//  ZQTokenView.m
//  ZQToken
//
//  Created by ZachQin on 16/8/25.
//  Copyright © 2016年 Buaa. All rights reserved.
//

#import "ZQTokenView.h"
#import "ZQCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "ZQReadyToDeleteView.h"

@interface ZQTokenView ()
@property (strong, nonatomic) UILabel *tokenPlaceHolderLabel;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableArray *titleMutableArray;
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIColor *> *colorMutableMap;
@end

@implementation ZQTokenView {
    ZQCollectionViewCell *movingCell;
    ZQReadyToDeleteView *readyToDeleteView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // ------setup UICollectionView
    UICollectionViewLeftAlignedLayout *collectionViewLeftAlignedLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLeftAlignedLayout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.clipsToBounds = NO;
    self.collectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[ZQCollectionViewCell class] forCellWithReuseIdentifier:@"TokenCell"];
    
    // ------setup recognizer
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    longPressGestureRecognizer.minimumPressDuration = 0.2;
    [self.collectionView addGestureRecognizer:longPressGestureRecognizer];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.collectionView.backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    // ------setup TextField
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.text = @"\u200B";
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.textColor = [UIColor whiteColor];
    self.textField.delegate = self;
    [self.collectionView addSubview:self.textField];
    
    // ------setup TokenTextHolderLabel
    self.tokenPlaceHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.tokenPlaceHolderLabel.text = @"Tap here to create.";
    self.tokenPlaceHolderLabel.numberOfLines = 0;
    [self.collectionView addSubview:self.tokenPlaceHolderLabel];
    self.tokenPlaceHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView addConstraint:[NSLayoutConstraint constraintWithItem:self.tokenPlaceHolderLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.collectionView addConstraint:[NSLayoutConstraint constraintWithItem:self.tokenPlaceHolderLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.collectionView addConstraint:[NSLayoutConstraint constraintWithItem:self.tokenPlaceHolderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.collectionView attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
    [self.collectionView addConstraint:[NSLayoutConstraint constraintWithItem:self.tokenPlaceHolderLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.collectionView attribute:NSLayoutAttributeRight multiplier:1 constant:20]];
    self.tokenPlaceHolderLabel.font = [UIFont systemFontOfSize:20];
    self.tokenPlaceHolderLabel.textColor = [UIColor grayColor];
    
    // ------setup Data
    self.minimumTokenHorizontalSpacing = 5;
    self.minimumTokenVerticalSpacing = 10;
    self.edgeInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.defaultTokenColor = [ZQCollectionViewCell grayTintColor];
    self.tokenSelectedColor = [[UIColor yellowColor] colorWithAlphaComponent:0.8];
    self.titleMutableArray = [NSMutableArray array];
    self.colorMutableMap = [NSMutableDictionary dictionary];
}

#pragma mark - **************** getter/setter

- (void)setTitleArray:(NSArray *)titleArray {
    _titleMutableArray = [titleArray mutableCopy];
}

- (NSArray *)titleArray {
    return [_titleMutableArray copy];
}

- (void)setColorMap:(NSDictionary<NSString *,UIColor *> *)colorMap {
    _colorMutableMap = [colorMap mutableCopy];
}

- (NSDictionary<NSString *,UIColor *> *)colorMap {
    return [_colorMutableMap mutableCopy];
}

- (void)setTokenSelectedColor:(UIColor *)tokenSelectedColor {
    _tokenSelectedColor = tokenSelectedColor;
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.selectedBackgroundView.backgroundColor = tokenSelectedColor;
    }];
}

- (void)setDefaultTokenColor:(UIColor *)defaultTokenColor {
    _defaultTokenColor = defaultTokenColor;
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.backgroundView.backgroundColor = defaultTokenColor;
    }];
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    _edgeInset = edgeInset;
    ((UICollectionViewLeftAlignedLayout *)self.collectionView.collectionViewLayout).sectionInset = edgeInset;
}

- (void)setMinimumTokenHorizontalSpacing:(NSInteger)minimumTokenHorizontalSpacing {
    _minimumTokenHorizontalSpacing = minimumTokenHorizontalSpacing;
    ((UICollectionViewLeftAlignedLayout *)self.collectionView.collectionViewLayout).minimumInteritemSpacing = minimumTokenHorizontalSpacing;
}

- (void)setMinimumTokenVerticalSpacing:(NSInteger)minimumTokenVerticalSpacing {
    _minimumTokenVerticalSpacing = minimumTokenVerticalSpacing;
    ((UICollectionViewLeftAlignedLayout *)self.collectionView.collectionViewLayout).minimumLineSpacing = minimumTokenVerticalSpacing;
}

#pragma mark - **************** Action
- (void)handleLongGesture:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    CGPoint gesturePosition = [longPressGestureRecognizer locationInView:self.collectionView];
    // ------ Add y-coordinate offset when moving.
    CGFloat verticalOffset = -20;
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.textField resignFirstResponder];
        NSIndexPath *movingIndexPath = [self.collectionView indexPathForItemAtPoint:gesturePosition];
        if (!movingIndexPath) {
            return;
        }
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:movingIndexPath];
        movingCell = (ZQCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:movingIndexPath];
        readyToDeleteView = [[ZQReadyToDeleteView alloc] initWithFrame:CGRectMake(-20, movingCell.bounds.size.height / 2 - 20, 40, 40)];
        [movingCell addSubview:readyToDeleteView];
        readyToDeleteView.hidden = YES;
        gesturePosition.y += verticalOffset;
        [UIView animateWithDuration:0.3 animations:^{
            [self.collectionView updateInteractiveMovementTargetPosition:gesturePosition];
        }];
    } else if (longPressGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gesturePosition.y += verticalOffset;
        [self.collectionView updateInteractiveMovementTargetPosition:gesturePosition];
        gesturePosition.y -= verticalOffset;
        if (!CGRectContainsPoint(self.collectionView.bounds, gesturePosition)) {
            readyToDeleteView.hidden = NO;
        } else {
            readyToDeleteView.hidden = YES;
        }
    } else if (longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.collectionView endInteractiveMovement];
        if (!CGRectContainsPoint(self.collectionView.bounds, gesturePosition)) {
            [self explodeOnView:self.collectionView frame:CGRectMake(gesturePosition.x - 60, gesturePosition.y - 25, 50, 50)];
            // ------ For avoiding the cell move back
            movingCell.hidden = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                movingCell.hidden = NO;
            });
            NSInteger removedIndex = [self.collectionView indexPathForCell:movingCell].row;
            [self removeTokenAtIndex:removedIndex];
            if ([self.delegate respondsToSelector:@selector(tokenView:didRemoveTokenAtIndex:)]) {
                [self.delegate tokenView:self didRemoveTokenAtIndex:removedIndex];
            }
        }
        [readyToDeleteView removeFromSuperview];
    } else {
        [readyToDeleteView removeFromSuperview];
        [self.collectionView cancelInteractiveMovement];
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.textField becomeFirstResponder];
}

#pragma mark - **************** Other
- (void)explodeOnView:(UIView *)containerView frame:(CGRect)frame{
    UIImageView *explodeImageView = [[UIImageView alloc] initWithFrame:frame];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"explode_%d", i]];
        [imageArray addObject:image];
    }
    
    explodeImageView.animationImages = imageArray;
    explodeImageView.animationRepeatCount = 1;
    explodeImageView.animationDuration = 0.5;
    [containerView addSubview:explodeImageView];
    [explodeImageView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(explodeImageView.animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [explodeImageView removeFromSuperview];
    });
}

#pragma mark - **************** layout
- (void)updateTextFieldPositionAndPlaceHolderLabelHidden {
    // ------Update TextFieldPosition
    NSIndexPath *path = [NSIndexPath indexPathForRow:[self.collectionView numberOfItemsInSection:0] - 1 inSection:0];
    UICollectionViewCell *lastCell = [self.collectionView cellForItemAtIndexPath:path];
    UIEdgeInsets insets = self.edgeInset;
    if (lastCell) {
        CGFloat cellRight = lastCell.frame.origin.x + lastCell.frame.size.width;
        CGFloat collectionViewRight = self.bounds.size.width;
        CGFloat spaceToEdge = collectionViewRight - insets.right - cellRight;
        if (spaceToEdge > 100) {
            self.textField.frame = CGRectMake(cellRight + 8, lastCell.frame.origin.y, spaceToEdge - 8, lastCell.frame.size.height);
        } else {
            self.textField.frame = CGRectMake(insets.left + 8,lastCell.frame.origin.y + lastCell.frame.size.height + self.minimumTokenVerticalSpacing, self.bounds.size.width - insets.left - insets.right - 8, 23.5);
        }
        
    } else {
        self.textField.frame = CGRectMake(insets.left + 8, insets.top, self.bounds.size.width - insets.left - insets.right - 8, 23.5);
    }
    
    // ------Update PlaceHolderLabelHidden
    self.tokenPlaceHolderLabel.hidden = self.collectionView.visibleCells.count > 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTextFieldPositionAndPlaceHolderLabelHidden];
    });
}

#pragma mark - **************** UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleMutableArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"TokenCell";
    ZQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"No matched cell identifier");
        return nil;
    }
    cell.token.text = self.titleMutableArray[indexPath.row];
    UIColor *cellColor = self.colorMutableMap[self.titleMutableArray[indexPath.row]];
    cell.backgroundView.backgroundColor = cellColor ? cellColor : self.defaultTokenColor;
    cell.selectedBackgroundView.backgroundColor = self.tokenSelectedColor;
    if (indexPath.row == self.titleMutableArray.count - 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateTextFieldPositionAndPlaceHolderLabelHidden];
        });
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
    if (originalIndexPath.row != proposedIndexPath.row) {
        NSString *sourceString = self.titleMutableArray[originalIndexPath.row];
        [self.titleMutableArray removeObjectAtIndex:originalIndexPath.row];
        [self.titleMutableArray insertObject:sourceString atIndex:proposedIndexPath.row];
    }
    return proposedIndexPath;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self updateTextFieldPositionAndPlaceHolderLabelHidden];
}

#pragma mark - ****************UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titleMutableArray[indexPath.row];
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : font}];
    size.height += 2;
    size.width += 20;
    size.width = MIN(size.width, 300);
    return size;
}

#pragma mark - **************** UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField resignFirstResponder];
    ZQCollectionViewCell *selectedCell = (ZQCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(tokenView:didSelectToken:atIndex:)]) {
        [self.delegate tokenView:self didSelectToken:selectedCell.token atIndex:indexPath.row];
    }
}

#pragma mark - **************** UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shoudInsert = YES;
    if ([self.delegate respondsToSelector:@selector(tokenView:shoudInsertTitle:atIndex:)]) {
        shoudInsert = [self.delegate tokenView:self shoudInsertTitle:[textField.text substringFromIndex:1] atIndex:self.titleMutableArray.count];
    }
    if (shoudInsert) {
        NSString *insertedTitle = [textField.text substringFromIndex:1];
        NSInteger index = self.titleMutableArray.count;
        if ([self.delegate respondsToSelector:@selector(tokenView:titleToReplaceOriginalTitle:atIndex:)]) {
            insertedTitle = [self.delegate tokenView:self titleToReplaceOriginalTitle:insertedTitle atIndex:index];
        }
        [self insertToken:insertedTitle intoIndex:index];
        if ([self.delegate respondsToSelector:@selector(tokenView:didInsertToken:atIndex:)]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.delegate tokenView:self didInsertToken:((ZQCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath]).token atIndex:index];
        }
    }
    // ------Detect backspace. http://stackoverflow.com/a/1983009
    textField.text = @"\u200B";
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    ZQCollectionViewCell *lastCell = (ZQCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.titleMutableArray.count - 1 inSection:0]];
    if (range.location == 0 && range.length == 1 && [textField.text isEqualToString:@"\u200B"]) {
        if (lastCell.highlighted) {
            NSInteger removedIndex = self.titleMutableArray.count - 1;
            [self removeTokenAtIndex:removedIndex];
            if ([self.delegate respondsToSelector:@selector(tokenView:didRemoveTokenAtIndex:)]) {
                [self.delegate tokenView:self didRemoveTokenAtIndex:removedIndex];
            }
        }
        lastCell.highlighted = !lastCell.highlighted;
        return NO;
    } else {
        lastCell.highlighted = NO;
        return YES;
    }
}
#pragma mark - **************** Public
- (void)insertToken:(NSString *)title intoIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(tokenView:colorForTitle:)]) {
        UIColor *tokenColor = [self.delegate tokenView:self colorForTitle:title];
        [self.colorMutableMap setObject:tokenColor forKey:title];
    }
    [self.titleMutableArray insertObject:title atIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self updateTextFieldPositionAndPlaceHolderLabelHidden];
}

- (void)removeTokenAtIndex:(NSInteger)index {
    NSString *title = self.titleMutableArray[index];
    [self.colorMutableMap removeObjectForKey:title];
    [self.titleMutableArray removeObjectAtIndex:index];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    [self updateTextFieldPositionAndPlaceHolderLabelHidden];
}

- (void)moveTokenFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {
    NSString *movingTitle = self.titleMutableArray[sourceIndex];
    [self.titleMutableArray removeObjectAtIndex:sourceIndex];
    [self.titleMutableArray insertObject:movingTitle atIndex:destinationIndex];
    [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:sourceIndex inSection:0] toIndexPath:[NSIndexPath indexPathForRow:destinationIndex inSection:0]];
}

- (void)reverseTokens {
    self.titleMutableArray = [[self.titleMutableArray.reverseObjectEnumerator allObjects] mutableCopy];
    [self.collectionView reloadData];
}

- (void)reload {
    [self.collectionView reloadData];
}

@end
