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
 * 默认在子线程异步执行的
 * 队列调度操作执行后，才会执行main方法
 */
- (void)main
{
//    NSLog(@"传入 url %@ %@",_URLString, [NSThread currentThread]);
    NSLog(@"传入 %@", [NSThread currentThread]);
    
    NSURL *URL = [NSURL URLWithString:self.URLString];
    
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    UIImage *image = [UIImage imageWithData:data];
    
    NSAssert(self.finishedBlock != nil, @"图片下载完成的回调不能为空");
    
    // 回主线程回调代码块:在哪个线程中回调，调用代理， 发送通知，就在那个线程中
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        _finishedBlock(image);
    }];
}

+ (instancetype)downloadImageWithURLString:(NSString *)URLString finishedBlock:(void (^)(UIImage *img))finishedBlock
{
    SZDownloadOperation *op = [SZDownloadOperation new];
   
    op.URLString = URLString;
    
    op.finishedBlock = finishedBlock;
    
    return op;
}

@end
