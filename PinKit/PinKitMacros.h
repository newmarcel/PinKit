//
//  PinKitMacros.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#ifndef PINKIT_MACROS_H
#define PINKIT_MACROS_H

#ifndef PINKIT_LOG_ENABLED
    #define PINKIT_LOG_ENABLED 1
#endif

#if PINKIT_LOG_ENABLED
    #define PNKLog(args...) NSLog(args)
#else
    #define PNKLog(args...)
#endif


#define PNKUnimplemented() @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Missing implementation" userInfo:nil]

#define fatalError(message) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:(NSString *)(message) userInfo:nil]

#endif /* PINKIT_MACROS_H */
