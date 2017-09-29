//
//  PNKNoteTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 29.09.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
@import PinKit;

@interface PNKNoteTests : XCTestCase
@end

@implementation PNKNoteTests

- (void)testEquality
{
    NSDictionary *noteDict1 = @{
                                @"length": @666,
                                @"hash": @"cb2bfe8b43362eb5b56b",
                                @"id": @"c2f024f1eda0f199bfca",
                                @"created_at": @"2018-02-14 18:42:22",
                                @"title": @"Testnote",
                                @"text": @"Lorem ipsum dolor sit amet.",
                                @"updated_at": @"2018-02-14 18:42:22"
                                };
    PNKNote *note1 = [[PNKNote alloc] initWithDictionary:noteDict1];
    NSDictionary *noteDict2 = @{
                                @"length": @333,
                                @"hash": @"cb2bfe8b43362eb5b5a8",
                                @"id": @"c2f024f1eda0f199bfff",
                                @"created_at": @"2017-02-14 10:10:10",
                                @"title": @"Some random note",
                                @"text": @"Hello World",
                                @"updated_at": @"2017-02-14 10:10:10"
                                };
    PNKNote *note2 = [[PNKNote alloc] initWithDictionary:noteDict2];
    PNKNote *note3 = [[PNKNote alloc] initWithDictionary:noteDict1];
    
    XCTAssertFalse([note1 isEqual:@1]);
    XCTAssertFalse([note1 isEqual:note2]);
    XCTAssertTrue([note1 isEqual:[note1 copy]]);
    XCTAssertTrue([note1 isEqual:note3]);
}

- (void)testDictionaryRepresentation
{
    NSDictionary *noteDict1 = @{
                                @"length": @666,
                                @"hash": @"cb2bfe8b43362eb5b56b",
                                @"id": @"c2f024f1eda0f199bfca",
                                @"created_at": @"2018-02-14 18:42:22",
                                @"title": @"Testnote",
                                @"text": @"Lorem ipsum dolor sit amet.",
                                @"updated_at": @"2015-02-14 18:42:22"
                                };
    PNKNote *note1 = [[PNKNote alloc] initWithDictionary:noteDict1];
    XCTAssertEqualObjects(note1.dictionaryRepresentation, noteDict1);
}

@end
