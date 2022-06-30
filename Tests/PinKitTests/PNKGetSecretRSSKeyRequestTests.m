//
//  PNKGetSecretRSSKeyRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PNKRequestTestCase/PNKRequestTestCase.h"

@interface PNKGetSecretRSSKeyRequestTests : PNKRequestTestCase
@end

@implementation PNKGetSecretRSSKeyRequestTests

- (void)testGetSecretRSSKeyRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetSecretRSSKeyRequest"];
    [self insertCassetteNamed:@"GetSecretRSSKeyRequest"];
    
    PNKGetSecretRSSKeyRequest *request = [PNKGetSecretRSSKeyRequest new];
    request.completionHandler = ^(NSString *secretRSSKey, NSError *error) {
        XCTAssertNotNil(secretRSSKey);
        XCTAssertNil(error);
        
        XCTAssert([@"super.secret.rss.key" isEqualToString:secretRSSKey]);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
