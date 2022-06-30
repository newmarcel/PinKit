//
//  PNKMapTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 16.04.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../../Sources/PinKit/Extensions/NSArray+PNKMap.h"

@interface PNKMapTests : XCTestCase
@end

@implementation PNKMapTests

- (void)testMap
{
    NSArray *collection = [self collection];
    NSArray *result = [collection pnk_map:^id _Nonnull(id  _Nonnull element) {
        return [element stringValue];
    }];
    
    XCTAssertNotNil(result);
    [collection enumerateObjectsUsingBlock:^(id  _Nonnull element, NSUInteger index, BOOL * _Nonnull doorStop) {
        NSString *stringifiedElement = [element stringValue];
        NSString *resultElement = result[index];
        XCTAssertEqualObjects(stringifiedElement, resultElement);
    }];
}

- (void)testMapVsFlatMap
{
    NSArray *collection = [self collection];
    
    NSArray *result1 = [collection pnk_map:^id _Nonnull(id  _Nonnull element) {
        return [element stringValue];
    }];
    NSArray *result2 = [collection pnk_flatMap:^id _Nullable(id  _Nonnull element) {
        return [element stringValue];
    }];
    
    XCTAssertEqualObjects(result1, result2);
}

- (void)testFlatMap
{
    NSArray *collection = [self collection];
    NSArray *result = [collection pnk_flatMap:^id _Nullable(id  _Nonnull element) {
        if([element integerValue] == 123) { return nil; }
        return [element stringValue];
    }];
    
    XCTAssertNotNil(result);
    XCTAssertEqual(result.count, collection.count-1);
}

#pragma mark - Helper

- (NSArray *)collection
{
    return @[@1, @5, @123, @897];
}

@end
