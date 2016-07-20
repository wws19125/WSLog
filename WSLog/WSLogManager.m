//
//  WSLogManager.m
//  Pods
//
//  Created by 王的世界 on 16/7/18.
//
//

#import "WSLogManager.h"
#import "WSLogProtocol.h"
#import "WSDBLog.h"
#import "WSFileLog.h"

#import "stdio.h"

@interface WSLogManager ()

@property(nonatomic,assign) WSLogType logType;
@property(nonatomic,strong) dispatch_queue_t queue;
@property(nonatomic,assign) dispatch_group_t group;
@property(nonatomic,strong) NSLock *lock;
@property(nonatomic,assign) BOOL isReady;
@property(nonatomic,strong) id<WSLogProtocol> logInstance;

@end


@implementation WSLogManager

- (id<WSLogProtocol>)logInstance
{
    if(!_logInstance)
    {
        if(self.logType==WSLogTypeDB)
        {
            _logInstance = [WSDBLog new];
        }
        else
            _logInstance = [WSFileLog new];
        [_logInstance setUp];
    }
    return _logInstance;
}

+ (instancetype)manager
{
    static WSLogManager *manager;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
       manager = [[WSLogManager alloc] initWithType:WSLogTypeFile];
    });
    return manager;
}

- (instancetype)initWithType:(WSLogType)logType
{
    if((self=[super init]))
    {
        self.logType = logType;
        self.queue = dispatch_queue_create("com.moysky.wslog.queue", DISPATCH_QUEUE_SERIAL);
        /// create log file
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/logs"];
        NSFileManager *fs = [NSFileManager defaultManager];
        if(![fs fileExistsAtPath:path])
        {
            if([fs createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil])
            {
                self.isReady = YES;
                [fs createFileAtPath:[path stringByAppendingPathComponent:@"error.log"] contents:nil attributes:nil];
            }
        }
        else
            self.isReady = YES;
        self.lock = [NSLock new];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithType:WSLogTypeFile];
}


- (void)error:(id)err function:(char*)function file:(char*)file linum:(int)linum
{
    dispatch_async(self.queue, ^{
        [self.lock lock];
        NSDate *dt = [NSDate new];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dtStr = [format stringFromDate:dt];
        dt = nil;
        format = nil;
        NSString *message;
        NSString *fn = [NSString stringWithUTF8String:function];
        NSString *fe = [NSString stringWithUTF8String:file];
        NSArray<NSString *> *arr = [fe componentsSeparatedByString:@"/"];\
        if([err isKindOfClass:[NSError class]])
        {
            NSError *e = (NSError *)err;
            message = [NSString stringWithFormat:@"%@ %@ %@",e.domain,e.localizedDescription,e.localizedFailureReason];
        }
        else if([err isKindOfClass:[NSException class]])
        {
            NSException *e = (NSException *)err;
            message = [NSString stringWithFormat:@"fatal:%@ %@ ",e.reason,e.userInfo];
        }
        else if([err isKindOfClass:[NSString class]])
                message = err;
        if(message)
        {
            [self.logInstance writeMessage:[NSString stringWithFormat:@"%@ %@ %@ => %d ## %@",dtStr,[arr lastObject],fn,linum,message]];
#ifdef DEBUG
            NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@ => %d ## %@",dtStr,[arr lastObject],fn,linum,message]);
#endif
        }
        

        [self.lock unlock];
    });
}

- (BOOL)readAllLog:(NSString **)outLogs
{
    dispatch_sync(self.queue, ^{
        [self.lock lock];
        [self.logInstance readAllMessage:outLogs];
        [self.lock unlock];
    });
}
- (void)clearLog
{
    dispatch_sync(self.queue, ^{
        [self.lock lock];
        [self.logInstance clearMessage];
        [self.lock unlock];
    });
}
@end
