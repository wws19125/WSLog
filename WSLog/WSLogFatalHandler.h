//
//  WSLogFatalHandler.h
//  Pods
//
//  Created by 王的世界 on 16/7/19.
//
//

#import <Foundation/Foundation.h>

@interface WSLogFatalHandler : NSObject
{
    BOOL dismissed;
}


@end

void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void);