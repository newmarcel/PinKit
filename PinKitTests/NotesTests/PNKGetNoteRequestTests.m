//
//  PNKGetNoteRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKGetNoteRequestTests : PNKRequestTestCase
@end

@implementation PNKGetNoteRequestTests

- (void)testGetNoteRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetNoteRequest"];
    [self insertCassetteNamed:@"Notes/GetNoteRequest"];
    
    NSString *identifier = @"c2f024f1eda0f199bfca";
    PNKGetNoteRequest *request = [[PNKGetNoteRequest alloc] initWithIdentifier:identifier];
    request.completionHandler = ^(PNKNote *note, NSError *error) {
        XCTAssertNotNil(note);
        XCTAssertNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetNoteRequestInvalidIdentifier
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetNoteRequestInvalidIdentifier"];
    [self insertCassetteNamed:@"Notes/GetNoteRequestInvalidIdentifier"];
    
    NSString *identifier = @"invalid-identifier";
    PNKGetNoteRequest *request = [[PNKGetNoteRequest alloc] initWithIdentifier:identifier];
    request.completionHandler = ^(PNKNote *note, NSError *error) {
        XCTAssertNil(note);
        XCTAssertNotNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
