//
//  PNKGetLastUpdateRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 05.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKGetLastUpdateRequestTests : PNKRequestTestCase
@end

@implementation PNKGetLastUpdateRequestTests

- (void)testGetUpdateRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetUpdateRequest"];
    [self insertCassetteNamed:@"GetLastUpdateRequest"];

    PNKGetLastUpdateRequest *lastUpdateRequest = [PNKGetLastUpdateRequest new];
    lastUpdateRequest.completionHandler = ^(NSDate *lastUpdate, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(lastUpdate);
        
        [expectation fulfill];
    };
    [self.client performRequest:lastUpdateRequest];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
