//
//  PNKNote.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKNote.h"
#import "NSDateFormatter+PNKPinboard.h"

@interface PNKNote ()
@property (nonatomic, readwrite) NSString *identifier;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *hashText;
@property (nonatomic, readwrite) NSDate *createdAt;
@property (nonatomic, readwrite) NSDate *updatedAt;
@property (nonatomic, readwrite) NSUInteger length;
@property (nonatomic, readwrite, nullable) NSString *text;

@end

@implementation PNKNote
@end

@implementation PNKNote (PNKDictionaryRepresentable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSParameterAssert(dictionary);
    
    NSString *identifier = dictionary[@"id"];
    NSString *title = dictionary[@"title"];
    NSString *hashText = dictionary[@"hash"];
    NSString *createdAtString = dictionary[@"created_at"];
    NSString *updatedAtString = dictionary[@"updated_at"];
    NSString *lengthString = dictionary[@"length"];
    
    NSString *text = dictionary[@"text"];
    
    NSDateFormatter *dateFormatter = NSDateFormatter.pnk_notesDateFormatter;
    
    PNKNote *note = [PNKNote new];
    note.identifier = identifier;
    note.title = title;
    note.hashText = hashText;
    note.createdAt = [dateFormatter dateFromString:createdAtString];
    note.updatedAt = [dateFormatter dateFromString:updatedAtString];
    note.length = (NSUInteger)lengthString.integerValue;
    note.text = text;
    
    return note;
}

@end
