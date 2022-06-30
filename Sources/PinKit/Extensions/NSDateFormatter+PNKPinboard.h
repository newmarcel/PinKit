//
//  NSDateFormatter+PNKPinboard.h
//  PinKit
//
//  Created by Marcel Dierkes on 03.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (PNKPinboard)
@property (class, nonatomic, readonly) NSDateFormatter *pnk_UTCDateFormatter;
@property (class, nonatomic, readonly) NSDateFormatter *pnk_shortUTCDateFormatter;
@property (class, nonatomic, readonly) NSDateFormatter *pnk_notesDateFormatter;
@end

NS_ASSUME_NONNULL_END
