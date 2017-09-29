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

#define kKeyIdentifier @"id"
#define kKeyTitle @"title"
#define kKeyHash @"hash"
#define kKeyCreatedAt @"created_at"
#define kKeyUpdatedAt @"updated_at"
#define kKeyLength @"length"
#define kKeyText @"text"

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSParameterAssert(dictionary);
    
    NSString *identifier = dictionary[kKeyIdentifier];
    NSString *title = dictionary[kKeyTitle];
    NSString *hashText = dictionary[kKeyHash];
    NSString *createdAtString = dictionary[kKeyCreatedAt];
    NSString *updatedAtString = dictionary[kKeyUpdatedAt];
    NSString *lengthString = dictionary[kKeyLength];
    NSString *text = dictionary[kKeyText];
    
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

- (NSDictionary<NSString *,id> *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[kKeyIdentifier] = self.identifier;
    dict[kKeyTitle] = self.title;
    dict[kKeyHash] = self.hashText;
    
    NSDateFormatter *dateFormatter = NSDateFormatter.pnk_notesDateFormatter;
    dict[kKeyCreatedAt] = [dateFormatter stringFromDate:self.createdAt];
    dict[kKeyUpdatedAt] = [dateFormatter stringFromDate:self.updatedAt];
    dict[kKeyLength] = @(self.length);
    dict[kKeyText] = self.text;
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
