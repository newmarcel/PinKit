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
extern PNKHTTPMethod const PNKHTTPMethodGET;
extern PNKHTTPMethod const PNKHTTPMethodPUT;
extern PNKHTTPMethod const PNKHTTPMethodPOST;
extern PNKHTTPMethod const PNKHTTPMethodDELETE;
extern PNKHTTPMethod const PNKHTTPMethodPATCH;

BOOL PNKHTTPStatusCodeIsSuccess(NSInteger statusCode);

NS_ASSUME_NONNULL_END
