//
//  WSDBLog.m
//  Pods
//
//  Created by 王的世界 on 16/7/18.
//
//

#import "WSDBLog.h"

@implementation WSDBLog

/// 初始化设置
- (BOOL)setUp
{
    return NO;
}
/// 写入日志
///
/// @params msg NSString * 日志内容
/// @return 结果
- (BOOL)writeMessage:(NSString *)msg
{
    return NO;
}

/// 清空日志
///
/// @return 结果
- (BOOL)clearMessage
{
    return NO;
}

/// 读取所有日志
///
/// @params outMsg NSString ** 读取结果
/// @return BOOL 是否读取成功
- (BOOL)readAllMessage:(NSString **)outMsg
{
    return NO;
}

@end
