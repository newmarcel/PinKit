//
//  PNKGetRecentPostsRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../PNKRequestTestCase/PNKRequestTestCase.h"

@interface PNKGetRecentPostsRequestTests : PNKRequestTestCase
@end

@implementation PNKGetRecentPostsRequestTests

- (void)testGetRecentPostsRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetRecentPostsRequest"];
    [self insertCassetteNamed:@"Posts/GetRecentPostsRequest"];
    
    PNKGetRecentPostsRequest *request = [PNKGetRecentPostsRequest new];
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

- (void)testGetRecentPostsRequestForTags
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetRecentPostsRequestForTags"];
    [self insertCassetteNamed:@"Posts/GetRecentPostsRequestForTags"];
    
    NSString *tag = @"startrek";
    PNKGetRecentPostsRequest *request = [PNKGetRecentPostsRequest new];
    request.tags = @[tag];
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        for(PNKBookmark *bookmark in bookmarks)
        {
            XCTAssertTrue([bookmark.tags containsObject:tag]);
        }
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

- (void)testGetRecentPostsRequestWithCount
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetRecentPostsRequestWithCount"];
    [self insertCassetteNamed:@"Posts/GetRecentPostsRequestWithCount"];
    
    NSUInteger count = 3;
    PNKGetRecentPostsRequest *request = [PNKGetRecentPostsRequest new];
    request.resultsCount = count;
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        XCTAssertEqual(bookmarks.count, count);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

- (void)testGetRecentPostsRequestForTagsAndCount
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetRecentPostsRequestForTagsAndCount"];
    [self insertCassetteNamed:@"Posts/GetRecentPostsRequestForTagsAndCount"];
    
    NSString *tag = @"startrek";
    NSUInteger count = 3;
    PNKGetRecentPostsRequest *request = [PNKGetRecentPostsRequest new];
    request.tags = @[tag];
    request.resultsCount = count;
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        XCTAssertEqual(bookmarks.count, count);
        
        for(PNKBookmark *bookmark in bookmarks)
        {
            XCTAssertTrue([bookmark.tags containsObject:tag]);
        }
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
