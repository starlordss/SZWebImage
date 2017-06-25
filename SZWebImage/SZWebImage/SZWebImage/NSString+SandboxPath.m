//
//  NSString+SandboxPath.m
//  列表异步加载网络图片
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "NSString+SandboxPath.h"

@implementation NSString (SandboxPath)

- (NSString *)sandboxPath
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *fileName = [self lastPathComponent];
    
    NSString *path = [cachePath stringByAppendingPathComponent:fileName];
    
    return path;
    
}

@end
