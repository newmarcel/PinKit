//
//  PNKAuthenticationRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKAuthenticationRequestTests : PNKRequestTestCase
@end

@implementation PNKAuthenticationRequestTests

- (void)testAuthenticationRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAuthenticationRequest"];
    [self insertCassetteNamed:@"Authentication/AuthenticationRequest"];
    
    NSString *username = PNKTestUsername;
    NSString *password = PNKTestPassword;
    NSString *expectedToken = PNKTestToken;
    
    PNKAuthenticationRequest *request = [[PNKAuthenticationRequest alloc] initWithUsername:username password:password];
    request.completionHandler = ^(NSString *token, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(token);
        XCTAssert([expectedToken isEqualToString:token]);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testAuthenticationRequestFailed
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAuthenticationRequestFailed"];
    [self insertCassetteNamed:@"Authentication/AuthenticationRequestFailed"];
    
    NSString *username = @"hopefully-not-a-real-user";
    NSString *password = @"12345678";
    
    PNKAuthenticationRequest *request = [[PNKAuthenticationRequest alloc] initWithUsername:username password:password];
    request.completionHandler = ^(NSString *token, NSError *error) {
        XCTAssertNil(token);
        XCTAssertNotNil(error);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
