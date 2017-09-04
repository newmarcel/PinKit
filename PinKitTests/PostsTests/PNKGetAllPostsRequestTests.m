//
//  PNKGetAllPostsRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 12.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKGetAllPostsRequestTests : PNKRequestTestCase
@end

@implementation PNKGetAllPostsRequestTests

- (void)testGetAllPostsRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetAllPostsRequest"];
    [self insertCassetteNamed:@"Posts/GetAllPostsRequest"];
    
    PNKGetAllPostsRequest *request = [PNKGetAllPostsRequest new];
    
    // Verify defaults
    NSUInteger resultsCount = request.resultsCount;
    XCTAssertEqual(resultsCount, 25);
    
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        XCTAssertEqual(bookmarks.count, resultsCount);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetAllPostsRequestWithOffsetAndCount
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetAllPostsRequestWithOffsetAndCount"];
    [self insertCassetteNamed:@"Posts/GetAllPostsRequestWithOffsetAndCount"];
    
    PNKGetAllPostsRequest *request = [PNKGetAllPostsRequest new];
    
    request.resultsCount = 3;
    request.offset = 10;
    
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        XCTAssertEqual(bookmarks.count, 3);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetAllPostsRequestWithTag
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetAllPostsRequestWithTag"];
    [self insertCassetteNamed:@"Posts/GetAllPostsRequestWithTag"];
    
    PNKGetAllPostsRequest *request = [PNKGetAllPostsRequest new];
    
    NSString *tag = @"startrek";
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
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetAllPostsRequestWithTags
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetAllPostsRequestWithTags"];
    [self insertCassetteNamed:@"Posts/GetAllPostsRequestWithTags"];
    
    PNKGetAllPostsRequest *request = [PNKGetAllPostsRequest new];
    
    NSString *tag1 = @"startrek";
    NSString *tag2 = @"articles";
    request.tags = @[tag1, tag2];
    
    request.completionHandler = ^(NSArray<PNKBookmark *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        for(PNKBookmark *bookmark in bookmarks)
        {
            XCTAssertTrue([bookmark.tags containsObject:tag1]);
            XCTAssertTrue([bookmark.tags containsObject:tag2]);
        }
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
