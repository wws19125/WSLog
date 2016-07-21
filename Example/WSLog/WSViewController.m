//
//  WSViewController.m
//  WSLog
//
//  Created by wang on 07/18/2016.
//  Copyright (c) 2016 wang. All rights reserved.
//

#import "WSViewController.h"
#import <WSLog/WSLog.h>

#define myprintf(...) printf("File:%s, Line:%s, Function:%d ",__FILE__,__VA_ARGS__, __LINE__ ,__FUNCTION__);

//#define myprintf(...) printf("[lch]:File:%s, Line:%d, Function:%s," __VA_ARGS__,__FILE__, __LINE__,__FUNCTION__);
#define dbg_msg(...)  {printf("### [%s:%d] ", __FUNCTION__, __LINE__,##__VA_ARGS__); printf(__VA_ARGS__);}
#define printDebugMsg(moduleName, format, ...) \
printf( "\n[%s] "format" File:%s, Line:%d\n", moduleName, ##__VA_ARGS__, __FILE__, __LINE__ );



@interface WSViewController ()

@end

@implementation WSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *str = [[NSString alloc] initWithUTF8String:__FILE__];
    NSArray<NSString *> *arr = [str componentsSeparatedByString:@"/"];
    [[arr lastObject] UTF8String];
    NSError *ex = [[NSError alloc] initWithDomain:@"com.moysky.err" code:404 userInfo:@{@"info":@"fuck you"}];
    WSLogError(ex);
    //WSLogError(e);
    WSLogDebug("abc");
    WSLogDebug("%@",@"123");
    WSLogTrace();
    NSString *strb;
    WSLogReadAll(strb);
    NSLog(@"%@",strb);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    NSLog(@"%s","99999999999999999aaa");
    //WSLogClear()
    
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //[alert show];
    
}

- (void)test
{
    NSLog(@"================");
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100), dispatch_get_main_queue(), ^{
    //NSArray *ar = @[@"!",@"f"];
    //[ar objectAtIndex:100];
    //});
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSArray *ar = @[@"!",@"f"];
    //[ar objectAtIndex:100];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
