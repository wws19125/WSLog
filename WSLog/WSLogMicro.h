//
//  WSLogMicro.h
//  Pods
//
//  Created by 王的世界 on 16/7/18.
//
//

#ifndef WSLogMicro_h
#define WSLogMicro_h

#import "WSLogManager.h"

#ifdef DEBUG
/// print trace
/// format: Trace:  fileName-functionName-lineNumber-customInfo
#define WSLogTrace(...){\
    NSString *str = [[NSString alloc] initWithUTF8String:__FILE__];\
    NSArray<NSString *> *arr = [str componentsSeparatedByString:@"/"];\
    printf("\nTrace:\t%s  %s => %d: " __VA_ARGS__,[[arr lastObject] UTF8String], __FUNCTION__, __LINE__);\
}
/// print debug
/// format: Trace:  fileName-functionName-lineNumber-customInfo
#define WSLogDebug(format,...){\
    NSString *str = [[NSString alloc] initWithUTF8String:__FILE__];\
    NSArray<NSString *> *arr = [str componentsSeparatedByString:@"/"];\
    printf("\nDebug:\t%s  %s => %d: "format"", [[arr lastObject] UTF8String], __FUNCTION__, __LINE__,##__VA_ARGS__);\
}
#else

#define WSLogTrace(...){}
#define WSLogDebug(format,...){}

#endif

/// error
/// @params err NSError *
#define WSLogError(err){\
    WSLogManager *m = [WSLogManager manager];\
    [m error:err function:__FUNCTION__ file:__FILE__ linum:__LINE__];\
}

#define WSLogReadAll(msg) { \
    WSLogManager *m = [WSLogManager manager]; \
    [m readAllLog:&msg]; \
}

#define WSLogClear() {\
    WSLogManager *m = [WSLogManager manager]; \
    [m clearLog];\
}
#endif /* WSLogMicro_h */
