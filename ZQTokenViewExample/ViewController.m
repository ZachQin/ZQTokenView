//
//  ViewController.m
//  ZQTokenViewExample
//
//  Created by ZachQin on 16/8/26.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import "ViewController.h"
#import "ZQTokenView.h"

@interface ViewController () <ZQTokenViewDelegate>
@property (weak, nonatomic) IBOutlet ZQTokenView *tokenView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tokenView.delegate = self;
    self.tokenView.titleArray = [NSMutableArray arrayWithObjects:
                                 @"Samuel Prescott",
                                 @"Grace Mcburney",
                                 @"Rosemary Sells",
                                 @"Janet Canady",
                                 @"Gregory Leech",
                                 @"Geneva Mcguinness",
                                 @"Billy Shin",
                                 @"Douglass Fostlick",
                                 @"Roberta Pedersen",
                                 @"Earl Rashid",
                                 @"Matthew Hooks", nil];
    NSMutableDictionary *colorMap = [NSMutableDictionary dictionary];
    [self.tokenView.titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
         colorMap[title] = [self randomColor];
    }];
    self.tokenView.containClearButton = YES;
    self.tokenView.colorMap = colorMap;
}



- (UIColor *)randomColor {
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - **************** delegate
- (UIColor *)tokenView:(ZQTokenView *)tokenView colorForTitle:(NSString *)title {
    return [self randomColor];
}

- (void)tokenView:(ZQTokenView *)tokenView didSelectToken:(UILabel *)token atIndex:(NSInteger)index{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"Delete Token: %@", token.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tokenView removeTokenAtIndex:index];
    }];
    [alertVC addAction:deleteAction];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (BOOL)tokenView:(ZQTokenView *)tokenView shoudInsertTitle:(NSString *)title atIndex:(NSInteger)index {
    return title.length > 0;
}

@end
