//
//  WSLogProtocol.h
//  Pods
//
//  Created by winter on 16/7/19.
//
//

#ifndef WSLogProtocol_h
#define WSLogProtocol_h

@protocol WSLogProtocol <NSObject>

@required

/// 初始化设置
- (BOOL)setUp;

/// 写入日志
///
/// @params msg NSString * 日志内容
/// @return 结果
- (BOOL)writeMessage:(NSString *)msg;

/// 清空日志
///
/// @return 结果
- (BOOL)clearMessage;

/// 读取所有日志
///
/// @params outMsg NSString ** 读取结果
/// @return BOOL 是否读取成功
- (BOOL)readAllMessage:(NSString **)outMsg;

@end

#endif /* WSLogProtocol_h */
