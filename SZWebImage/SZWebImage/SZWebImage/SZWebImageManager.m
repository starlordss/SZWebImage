//
//  SZWebImageManager.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/24.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "SZWebImageManager.h"

@interface SZWebImageManager ()


/**操作缓存*/
@property (nonatomic, strong) NSMutableDictionary *OPCache;
/**队列*/
@property (nonatomic, strong) NSOperationQueue *queue;

@end


@implementation SZWebImageManager

#pragma mark - 取消上一次操作
- (void)cancelFormLastURLString:(NSString *)lastURLString
{
    SZDownloadOperation *lastOP = [self.OPCache objectForKey:lastURLString];
    
    if (lastOP != nil) {
        
        // 发送取消消息
        [lastOP cancel];
        
        // 把取消的操作从缓存池移除
        [_OPCache removeObjectForKey:lastURLString];
    }
    
    
}

#pragma mark - 实例化
- (instancetype)init
{
    if (self = [super init]) {
        // 实例化队列
        self.queue = [NSOperationQueue new];
        // 实例缓存池
        self.OPCache = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - 单例
+ (instancetype)sharedManager
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
    });
    return instance;
}

#pragma mark - 下载图片
- (void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock
{
    // 在建立下载前，判断要建立的下载操作是否存在，
    if ([self.OPCache objectForKey:URLString] != nil) {// 存在
        
        // 不需要再建立重复的下载操作
        return;
    }
    
    // 获取随机图片链接，让SZDownloadOperation去下载
    SZDownloadOperation *op = [SZDownloadOperation downloadImageWithURLString:URLString finishedBlock:^(UIImage *image) {
        
        // 单例把拿到的图片回调给控制器
        if (completionBlock) {
            completionBlock(image);
        }
        
        // 图片下载结束后，移除对应的下载操作
        [self.OPCache removeObjectForKey:URLString];
    }];
    
    // 添加操作到缓存池
    [self.OPCache setObject:op forKey:URLString];
    
    // 添加到操作缓存
    [self.queue addOperation:op];
}
@end
