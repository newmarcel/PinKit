//
//  PNKHTTP.m
//  PinKit
//
//  Created by Marcel Dierkes on 14.04.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKHTTP.h>

PNKHTTPMethod const PNKHTTPMethodGET = @"GET";
PNKHTTPMethod const PNKHTTPMethodPUT = @"PUT";
PNKHTTPMethod const PNKHTTPMethodPOST = @"POST";
PNKHTTPMethod const PNKHTTPMethodDELETE = @"DELETE";
PNKHTTPMethod const PNKHTTPMethodPATCH = @"PATCH";

BOOL PNKHTTPStatusCodeIsSuccess(NSInteger statusCode)
{
    NSIndexSet *acceptedIndices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    return [acceptedIndices containsIndex:statusCode];
}
