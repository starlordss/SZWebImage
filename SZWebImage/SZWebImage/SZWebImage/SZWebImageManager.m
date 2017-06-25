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

/**内存缓存**/
@property (nonatomic, strong) NSMutableDictionary *memoeyCache;

@end


@implementation SZWebImageManager

- (instancetype)init
{
    if (self = [super init]) {
        // 实例化队列
        self.queue = [NSOperationQueue new];
        // 实例缓存池
        self.OPCache = [NSMutableDictionary dictionary];
        // 实例内存缓存
        self.memoeyCache = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)sharedManager
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
    });
    return instance;
}



#pragma mark - 取消上一次的操作
- (void)cancelFormLastURLString:(NSString *)lastURLString
{
    // 获取上一个图片的下载操作
    SZDownloadOperation *lastOP = [self.OPCache objectForKey:lastURLString];
    
    if (lastOP != nil) {
        // 发出取消消息
        [lastOP cancel];

    }
    // 把取消的操作从操作缓存移除
    [self.OPCache removeObjectForKey:lastURLString];
    
}


#pragma mark - 图片下载
- (void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *))completionBlock
{
    // 在下载图片前，判断是否有缓存
    if ([self checkCacheWithURLString:URLString]) {//有
        
        if (completionBlock != nil) {
            completionBlock([self.memoeyCache objectForKey:URLString]);
        }
        return;
        
    }
    
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
        
        
        if (image != nil) {
            
            [self.memoeyCache setValue:image forKey:URLString];
        }
        
        // 图片下载结束后，移除对应的下载操作
        [self.OPCache removeObjectForKey:URLString];
    }];
    
    // 添加操作到缓存池
    [self.OPCache setObject:op forKey:URLString];
    
    // 添加到操作缓存
    [self.queue addOperation:op];
}

/**
 * 判断是否有缓存
 */
- (BOOL)checkCacheWithURLString:(NSString *)URLString
{
    // 判断是否有内存缓存
    if ([self.memoeyCache objectForKey:URLString] != nil) {
        
        NSLog(@"内存获取: %@",[URLString lastPathComponent]);
        return YES;
    }
    
    // 判断是否有沙盒缓存
    UIImage *sandboxImg = [UIImage imageWithContentsOfFile:[URLString sandboxPath]];
    
    if (sandboxImg != nil) {
        
        NSLog(@"从沙盒获取: %@",[URLString lastPathComponent]);
        // 在内存缓存里存取一份
        [self.memoeyCache setValue:sandboxImg forKey:URLString];
        return YES;
    }
    return NO;

}

@end
