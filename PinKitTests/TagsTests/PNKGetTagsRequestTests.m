//
//  PNKGetTagsRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKGetTagsRequestTests : PNKRequestTestCase
@end

@implementation PNKGetTagsRequestTests

- (void)testGetTagsRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetTagsRequest"];
    [self insertCassetteNamed:@"Tags/GetTagsRequest"];
    
    PNKGetTagsRequest *tagsRequest = [PNKGetTagsRequest new];
    tagsRequest.completionHandler = ^(NSDictionary<NSString *, NSNumber *> *tagsAndCounts, NSError *error) {
        XCTAssertNotNil(tagsAndCounts);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:tagsRequest];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end