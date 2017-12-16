//
//  PNKAddPostRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKAddPostRequestTests : PNKRequestTestCase
@end

@implementation PNKAddPostRequestTests

- (void)testAddPostRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAddPostRequest"];
    [self insertCassetteNamed:@"Posts/AddPostRequest"];
    
    PNKBookmark *bookmark = [self bookmark];
    PNKAddPostRequest *addPostRequest = [[PNKAddPostRequest alloc] initWithBookmark:bookmark];
    addPostRequest.completionHandler = ^(BOOL success, NSError *error) {
        XCTAssertTrue(success);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:addPostRequest];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

- (void)testAddPostRequestWithoutReplacement
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAddPostRequestWithoutReplacement"];
    [self insertCassetteNamed:@"Posts/AddPostRequest"];
    
    PNKBookmark *bookmark = [self bookmark];
    PNKAddPostRequest *addPostRequest = [[PNKAddPostRequest alloc] initWithBookmark:bookmark];
    addPostRequest.completionHandler = ^(BOOL success, NSError *error) {
        XCTAssertTrue(success);
        XCTAssertNil(error);
        
        // Switch cassettes
        [self insertCassetteNamed:@"Posts/AddPostRequestWithoutReplacement"];
        
        PNKAddPostRequest *failedPostRequest = [[PNKAddPostRequest alloc] initWithBookmark:bookmark];
        failedPostRequest.shouldReplaceExisting = NO;
        failedPostRequest.completionHandler = ^(BOOL success, NSError *error) {
            XCTAssertFalse(success);
            XCTAssertNotNil(error);
            
            [expectation fulfill];
        };
        [self.client performRequest:failedPostRequest];
    };
    [self.client performRequest:addPostRequest];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
