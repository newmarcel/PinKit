//
//  PNKPinboardBool.h
//  PinKit
//
//  Created by Marcel Dierkes on 03.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Converts a Pinboard bool string into a BOOL.
 
 Pinboard bools are represented as "yes" or "no" strings.

 @param pinboardBoolString A Pinboard bool string
 @return A boolean value
 */
BOOL PNKBoolFromPinboardBoolString(NSString *pinboardBoolString);

/**
 Converts a BOOL value into a Pinboard bool string.
 
 Pinboard bools are represented as "yes" or "no" strings.

 @param booleanValue A boolean value
 @return A Pinboard bool string
 */
NSString *PNKPinboardBoolStringFromBool(BOOL booleanValue);

NS_ASSUME_NONNULL_END
