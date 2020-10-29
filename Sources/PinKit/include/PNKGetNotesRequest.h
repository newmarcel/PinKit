//
//  PNKGetNotesRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>
#import <PinKit/PNKNote.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetNotesRequestCompletionHandler)(NSArray<PNKNote *> *_Nullable notes, NSError *_Nullable error);

@interface PNKGetNotesRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) PNKGetNotesRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
