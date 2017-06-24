//
//  SZDownloadOperation.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "SZDownloadOperation.h"

@interface SZDownloadOperation ()

/**接受外界传入的图片地址**/
@property (nonatomic, copy) NSString *URLString;

/**接受外接出入的回调block**/
@property (nonatomic, copy) void(^finishedBlock)(UIImage *);

@end

@implementation SZDownloadOperation


/**
 * 操作的入口方法：队列调用操作执行先经过start方法过滤，然后进入该方法
 * 默认在"子线程" "异步"执行的
 * 队列调度操作执行后，才会执行main方法
 */
- (void)main
{
    
    NSLog(@" + 传入:\"%@\"",[_URLString lastPathComponent]);
    
    NSURL *URL = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    
    // 模拟网络延迟
    [NSThread sleepForTimeInterval:1.0f];
    
    // 在操作执行的过程中拦截操作是否被取消了
    if (self.isCancelled == YES) { // 取消
        
        NSLog(@" - 取消:\"%@\"",[_URLString lastPathComponent]);
        return;
    }
    
    NSAssert(self.finishedBlock != nil, @"图片下载完成的回调不能为空");
    
    // 回主线程回调代码块:在哪个线程中回调\调用代理\发送通知，就在那个线程中
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
    
        NSLog(@" ^ 完成:\"%@\"",[_URLString lastPathComponent]);
        _finishedBlock(image);//主线程
    }];
}

#pragma mark - 接受外部的图片
+ (instancetype)downloadImageWithURLString:(NSString *)URLString finishedBlock:(void (^)(UIImage *img))finishedBlock
{
    SZDownloadOperation *op = [SZDownloadOperation new];
   
    // 记录图片地址赋值给属性
    op.URLString = URLString;
    
    // 记录回调的代码属性赋值给属性
    op.finishedBlock = finishedBlock;
    
    return op;
}

@end
