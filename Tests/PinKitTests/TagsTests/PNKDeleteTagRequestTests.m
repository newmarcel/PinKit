//
//  PNKDeleteTagRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../PNKRequestTestCase/PNKRequestTestCase.h"

@interface PNKDeleteTagRequestTests : PNKRequestTestCase
@end

@implementation PNKDeleteTagRequestTests

- (void)testDeleteTagRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testDeleteTagRequest"];
    [self insertCassetteNamed:@"Tags/DeleteTagRequest"];
    
    PNKDeleteTagRequest *tagsRequest = [[PNKDeleteTagRequest alloc] initWithTagName:@"__xctest"];
    tagsRequest.completionHandler = ^(BOOL success, NSError *error) {
        XCTAssertTrue(success);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:tagsRequest];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
