//
//  PNKDeletePostRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 09.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKDeletePostRequestTests : PNKRequestTestCase
@end

@implementation PNKDeletePostRequestTests

- (void)testDeletePostRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAddPostRequest"];
    [self insertCassetteNamed:@"Posts/AddPostRequest"];
    
    PNKBookmark *bookmark = [self bookmark];
    
    // Add the bookmark to delete
    PNKAddPostRequest *addPostRequest = [[PNKAddPostRequest alloc] initWithBookmark:bookmark];
    addPostRequest.completionHandler = ^(BOOL success, NSError *error) {
        XCTAssertTrue(success);
        
        // Switch cassettes
        [self insertCassetteNamed:@"Posts/DeletePostRequest"];
        
        // Delete the bookmark
        PNKDeletePostRequest *deletePostRequest = [[PNKDeletePostRequest alloc] initWithBookmark:bookmark];
        deletePostRequest.completionHandler = ^(BOOL success, NSError *error) {
            XCTAssertTrue(success);
            XCTAssertNil(error);
            
            [expectation fulfill];
        };
        [self.client performRequest:deletePostRequest];
    };
    [self.client performRequest:addPostRequest];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
