//
//  WSLogManager.h
//  Pods
//
//  Created by 王的世界 on 16/7/18.
//
//

#import <Foundation/Foundation.h>

/// 日志类型
typedef NS_ENUM(NSInteger,WSLogType)
{
    WSLogTypeFile,  //文件日志
    WSLogTypeDB     //数据库日志
};

@interface WSLogManager : NSObject

+ (instancetype)manager;
- (void)error:(id)err function:(char*)function file:(char*)file linum:(int)linum;
- (void)readAllLog:(NSString **)outLogs;
- (void)clearLog;
@end
