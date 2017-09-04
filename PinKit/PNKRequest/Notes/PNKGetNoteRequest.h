//
//  PNKGetNoteRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"
#import "PNKNote.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetNoteRequestCompletionHandler)(PNKNote *_Nullable note, NSError *_Nullable error);

@interface PNKGetNoteRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, readonly) NSString *identifier;
@property (copy, nonatomic, nullable) PNKGetNoteRequestCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
