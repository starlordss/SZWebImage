//
//  SZWebImageManager.h
//  SZWebImage
//
//  Created by Zahi on 2017/6/24.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZDownloadOperation.h"

@interface SZWebImageManager : NSObject

+ (instancetype)sharedManager;


/**
 * 下载图片
 * @param URLString 图片地址
 * @param completionBlock 载完的回调
 */
- (void)downloadImageWithURLString:(NSString *)URLString completion:(void(^)(UIImage *image)) completionBlock;


/**
 * 取消上次操作的主方法
 * @param lastURLString 上次下载图片地址
 */
- (void)cancelFormLastURLString:(NSString *)lastURLString;

@end
