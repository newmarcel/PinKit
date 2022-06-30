//
//  PNKHTTP.h
//  PinKit
//
//  Created by Marcel Dierkes on 14.04.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *PNKHTTPMethod NS_EXTENSIBLE_STRING_ENUM;
FOUNDATION_EXPORT PNKHTTPMethod const PNKHTTPMethodGET;
FOUNDATION_EXPORT PNKHTTPMethod const PNKHTTPMethodPUT;
FOUNDATION_EXPORT PNKHTTPMethod const PNKHTTPMethodPOST;
FOUNDATION_EXPORT PNKHTTPMethod const PNKHTTPMethodDELETE;
FOUNDATION_EXPORT PNKHTTPMethod const PNKHTTPMethodPATCH;

BOOL PNKHTTPStatusCodeIsSuccess(NSInteger statusCode);

NS_ASSUME_NONNULL_END
