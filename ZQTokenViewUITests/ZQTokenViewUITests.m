//
//  ZQTokenViewUITests.m
//  ZQTokenViewUITests
//
//  Created by ZachQin on 2018/1/2.
//  Copyright © 2018年 ZachQin. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZQTokenViewUITests : XCTestCase

@end

@implementation ZQTokenViewUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (NSArray *)tokenList:(XCUIElement *)collectionViewElement {
    NSMutableArray<NSString *> *tokenArray = [NSMutableArray array];
    [collectionViewElement.cells.staticTexts.allElementsBoundByIndex enumerateObjectsUsingBlock:^(XCUIElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tokenArray addObject:obj.label];
    }];
    return tokenArray;
}

- (void)testExample {
    NSArray *shownTokenArray = nil;
    
    XCUIElementQuery *collectionViewsQuery = [[XCUIApplication alloc] init].collectionViews;
    
    // Testing source token list.
    shownTokenArray = [self tokenList:collectionViewsQuery.element];
    NSArray *sourceTokenArray = @[@"Samuel Prescott",
                                  @"Grace Mcburney",
                                  @"Rosemary Sells",
                                  @"Janet Canady",
                                  @"Gregory Leech",
                                  @"Geneva Mcguinness",
                                  @"Billy Shin",
                                  @"Douglass Fostlick",
                                  @"Roberta Pedersen",
                                  @"Earl Rashid",
                                  @"Matthew Hooks"];
    XCTAssertTrue([shownTokenArray isEqualToArray:sourceTokenArray]);
    
    {
        // Testing delete last
        XCUIElement *matthewHooks = collectionViewsQuery.cells.staticTexts[@"Matthew Hooks"];
        XCUICoordinate *from_coor = [matthewHooks coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)];
        XCUICoordinate *to_coor = [collectionViewsQuery.element coordinateWithNormalizedOffset:CGVectorMake(0.5, 2)];
        [from_coor pressForDuration:2 thenDragToCoordinate:to_coor];
        shownTokenArray = [self tokenList:collectionViewsQuery.element];
        NSArray *expectTokenArray = @[@"Samuel Prescott",
                                      @"Grace Mcburney",
                                      @"Rosemary Sells",
                                      @"Janet Canady",
                                      @"Gregory Leech",
                                      @"Geneva Mcguinness",
                                      @"Billy Shin",
                                      @"Douglass Fostlick",
                                      @"Roberta Pedersen",
                                      @"Earl Rashid"];
        XCTAssertTrue([shownTokenArray isEqualToArray:expectTokenArray]);
    }
    
    {
        // Testing reorder then delete
        XCUIElement *robertaPedersen = collectionViewsQuery.cells.staticTexts[@"Roberta Pedersen"];
        XCUIElement *earlRashid = collectionViewsQuery.cells.staticTexts[@"Earl Rashid"];
        XCUICoordinate *from_coor = [robertaPedersen coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)];
        XCUICoordinate *to_coor = [earlRashid coordinateWithNormalizedOffset:CGVectorMake(0.8, 1.0)];
        [from_coor pressForDuration:2 thenDragToCoordinate:to_coor];
        shownTokenArray = [self tokenList:collectionViewsQuery.element];
        NSArray *expectTokenArray = @[@"Samuel Prescott",
                                      @"Grace Mcburney",
                                      @"Rosemary Sells",
                                      @"Janet Canady",
                                      @"Gregory Leech",
                                      @"Geneva Mcguinness",
                                      @"Billy Shin",
                                      @"Douglass Fostlick",
                                      @"Earl Rashid",
                                      @"Roberta Pedersen"];
        XCTAssertTrue([shownTokenArray isEqualToArray:expectTokenArray]);
    }
}

@end
