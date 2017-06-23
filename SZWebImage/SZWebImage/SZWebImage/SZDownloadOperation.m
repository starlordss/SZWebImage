//
//  SZDownloadOperation.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "SZDownloadOperation.h"

@implementation SZDownloadOperation


/**
 * 操作的入口方法：队列调用操作执行先经过start方法过滤，然后进入该方法
 * 默认在子线程异步执行的
 * 队列调度操作执行后，才会执行main方法
 */
- (void)main
{
    NSLog(@"%@ %@",self.urlString,[NSThread currentThread]);
    
}

@end
