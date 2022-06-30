//
//  PNKGetNotesRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../PNKRequestTestCase/PNKRequestTestCase.h"

@interface PNKGetNotesRequestTests : PNKRequestTestCase
@end

@implementation PNKGetNotesRequestTests

- (void)testGetNotesRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetNotesRequest"];
    [self insertCassetteNamed:@"Notes/GetNotesRequest"];
    
    PNKGetNotesRequest *request = [PNKGetNotesRequest new];
    request.completionHandler = ^(NSArray<PNKNote *> *bookmarks, NSError *error) {
        XCTAssertNotNil(bookmarks);
        XCTAssertNil(error);
        
        XCTAssertEqual(bookmarks.count, 1);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
