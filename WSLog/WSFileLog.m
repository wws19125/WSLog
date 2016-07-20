//
//  WSFileLog.m
//  Pods
//
//  Created by 王的世界 on 16/7/18.
//
//

#import "WSFileLog.h"

@interface WSFileLog ()

@property(nonatomic,copy) NSString* logPath;

@end

@implementation WSFileLog

- (BOOL)setUp
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/logs"];
    self.logPath = [path stringByAppendingPathComponent:@"error.log"];
#ifdef DEBUG
    NSLog(@"logfile path => %@",self.logPath);
#endif
    NSFileManager *fs = [NSFileManager defaultManager];
    if(![fs fileExistsAtPath:path])
    {
        if(![fs createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil])
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)writeMessage:(NSString *)msg
{
    FILE *pf = NULL;
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    pf = fopen([self.logPath UTF8String], "ab+");
    if(pf==NULL)
    {
        NSLog(@"open log file failure:%@",self.logPath);
        return NO;
    }
    //fseek(pf, -1L, SEEK_END);
    fwrite(data.bytes, data.length, 1, pf);
    char buf[1] = {'\n'};
    fwrite(buf, 1, 1, pf);
    fclose(pf);
    return YES;
}
- (BOOL)clearMessage
{
    FILE *pf = NULL;
    pf = fopen([self.logPath UTF8String], "w+");
    if(pf==NULL)
    {
        NSLog(@"open log file failure:%@",self.logPath);
        return NO;
    }
    fclose(pf);
    return YES;
}
- (BOOL)readAllMessage:(NSString **)outMsg
{
    /*
    FILE *pf = NULL;
    int fileLen = 0;
    char* buf;
    pf = fopen([self.logPath UTF8String], "r");
    if(pf==NULL)
    {
        NSLog(@"open log file failure:%@",self.logPath);
        return NO;
    }
    fseek(pf, 0L, SEEK_END);
    fileLen = ftell(pf);
    buf = (char *)malloc(fileLen/2+1);
    fseek(pf, fileLen/2, SEEK_SET);
    fread(buf, fileLen/2, 1, pf);
    pf = NULL;
    *outMsg = [[NSString alloc] initWithData:[NSData dataWithBytes:buf length:fileLen/2] encoding:NSUTF8StringEncoding];
    free(buf);
    fclose(pf);
     */
    NSFileManager *fs = [NSFileManager defaultManager];
    if([fs fileExistsAtPath:self.logPath])
    {
        NSError *err;
        *outMsg = [NSString stringWithContentsOfFile:self.logPath encoding:NSUTF8StringEncoding error:&err];
        if(err)
            return NO;
    }
    return YES;
}

@end
