//
//  PNKRenameTagRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKRenameTagRequestTests : PNKRequestTestCase
@end

@implementation PNKRenameTagRequestTests

- (void)testRenameTagRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testRenameTagRequest"];
    [self insertCassetteNamed:@"Tags/RenameTagRequest"];
    
    PNKRenameTagRequest *renameRequest = [[PNKRenameTagRequest alloc] initWithFromName:@"__test"
                                                                                toName:@"__xctest"
                                          ];
    renameRequest.completionHandler = ^(BOOL success, NSError *error) {
        XCTAssertTrue(success);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:renameRequest];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
