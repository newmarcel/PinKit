//
//  PNKDateFormatterTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 16.04.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PinKit/PinKit.h>
#import "../../Sources/PinKit/Extensions/NSDateFormatter+PNKPinboard.h"

@interface PNKDateFormatterPinboardTests : XCTestCase
@end

@implementation PNKDateFormatterPinboardTests

- (void)testUTCDateFormatter
{
    NSDateFormatter *df = NSDateFormatter.pnk_UTCDateFormatter;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:150];
    
    NSString *formattedString = [df stringFromDate:date];
    NSString *expectedString = @"2001-01-01T00:02:30Z";
    
    XCTAssertEqualObjects(formattedString, expectedString);
    
    NSDate *reformattedDate = [df dateFromString:formattedString];
    XCTAssertEqualObjects(date, reformattedDate);
}

- (void)testShortUTCDateFormatter
{
    NSDateFormatter *df = NSDateFormatter.pnk_shortUTCDateFormatter;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:150];
    
    NSString *formattedString = [df stringFromDate:date];
    NSString *expectedString = @"2001-01-01";
    
    XCTAssertEqualObjects(formattedString, expectedString);
    
    NSDate *reformattedDate = [df dateFromString:formattedString];
    
    // Remove the time information from the original date
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                 fromDate:date
                                    ];
    components.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *normalizedDate = [NSCalendar.currentCalendar dateFromComponents:components];
    
    XCTAssertEqualObjects(normalizedDate, reformattedDate);
}

- (void)testNotesDateFormatter
{
    NSDateFormatter *df = NSDateFormatter.pnk_notesDateFormatter;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:150];
    
    NSString *formattedString = [df stringFromDate:date];
    NSString *expectedString = @"2001-01-01 00:02:30";
    
    XCTAssertEqualObjects(formattedString, expectedString);
    
    NSDate *reformattedDate = [df dateFromString:formattedString];
    XCTAssertEqualObjects(date, reformattedDate);
}

@end
