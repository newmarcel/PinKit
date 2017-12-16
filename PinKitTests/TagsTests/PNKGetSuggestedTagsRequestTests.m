//
//  PNKGetSuggestedTagsRequestTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
#import "PNKRequestTestCase.h"

@interface PNKGetSuggestedTagsRequestTests : PNKRequestTestCase
@end

@implementation PNKGetSuggestedTagsRequestTests

- (void)testGetSuggestedTagsRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testGetSuggestedTagsRequest"];
    [self insertCassetteNamed:@"Tags/GetSuggestedTagsRequest"];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.goldfrapp.com"];
    PNKGetSuggestedTagsRequest *request = [[PNKGetSuggestedTagsRequest alloc] initWithURL:URL];
    request.completionHandler = ^(NSArray<NSString *> *popularTags, NSArray<NSString *> *recommendedTags, NSError *error) {
        XCTAssertNotNil(popularTags);
        XCTAssertNotNil(recommendedTags);
        XCTAssertNil(error);
        
        XCTAssertEqual(popularTags.count, 3);
        XCTAssertEqual(recommendedTags.count, 10);
        
        [expectation fulfill];
    };
    [self.client performRequest:request];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
