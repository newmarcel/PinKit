//
//  PNKBookmarkTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 29.09.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
@import PinKit;

@interface PNKBookmarkTests : XCTestCase
@end

@implementation PNKBookmarkTests

- (void)testEquality
{
    PNKBookmark *bk1 = [[PNKBookmark alloc] initWithTitle:@"Test Bookmark"
                                                      URL:[NSURL URLWithString:@"http://example.com/test"]
                                          descriptionText:nil
                                                     tags:@[]
                        ];
    PNKBookmark *bk2 = [[PNKBookmark alloc] initWithTitle:@"Test Bookmark"
                                                      URL:[NSURL URLWithString:@"http://example.com/test"]
                                          descriptionText:@"A description text"
                                                     tags:@[]
                        ];
    PNKBookmark *bk3 = [[PNKBookmark alloc] initWithTitle:@"Test Bookmark"
                                                      URL:[NSURL URLWithString:@"http://example.com/test"]
                                          descriptionText:nil
                                                     tags:@[]
                        ];
    
    XCTAssertFalse([bk1 isEqual:@6]);
    XCTAssertFalse([bk1 isEqual:nil]);
    XCTAssertFalse([bk1 isEqual:bk2]);
    XCTAssertTrue([bk1 isEqual:bk3]);
    XCTAssertTrue([bk1 isEqual:bk1]);
    XCTAssertTrue([bk1 isEqual:[bk1 mutableCopy]]);
}

- (void)testCopyWithZone
{
    PNKBookmark *bookmark = [[PNKBookmark alloc] initWithTitle:@"Test Bookmark"
                                                      URL:[NSURL URLWithString:@"http://example.com/test"]
                                          descriptionText:nil
                                                     tags:@[]
                        ];
    XCTAssertTrue(bookmark == [bookmark copy]);
}

- (void)testDictionaryRepresentation
{
    __auto_type bookmark = [[PNKMutableBookmark alloc] initWithTitle:@"Test Bookmark"
                                                                 URL:[NSURL URLWithString:@"http://example.com/test"]
                                                     descriptionText:@"A handy test bookmark."
                                                                tags:@[@"test", @"bookmark", @"unit-testing"]
                            ];
    bookmark.createdAt = [NSDate dateWithTimeIntervalSince1970:10];
    bookmark.shared = NO;
    NSDictionary *dict = [bookmark dictionaryRepresentation];
    
    NSDictionary *expectedDict = @{
                                   @"description": @"Test Bookmark",
                                   @"extended": @"A handy test bookmark.",
                                   @"href": @"http://example.com/test",
                                   @"shared": @"no",
                                   @"tags": @"test bookmark unit-testing",
                                   @"time": @"1970-01-01T00:00:10Z",
                                   @"toread": @"yes"
                                   };
    XCTAssertEqualObjects(dict, expectedDict);
    
    PNKBookmark *expectedBookmark = [[PNKBookmark alloc] initWithDictionary:dict];
    XCTAssertTrue([bookmark isEqualToBookmark:expectedBookmark]);
}

@end
