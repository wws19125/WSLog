//
//  WSMicro.h
//  WSLog
//
//  Created by winter on 16/7/18.
//  Copyright © 2016年 王的世界. All rights reserved.
//

#ifndef WSMicro_h
#define WSMicro_h

#ifdef A
#define B(){ NSLog(@"---------");}
#else
#define B(){ NSLog(@"bbbbbbbbb");};
#endif

#endif /* WSMicro_h */
