//
//  SZDownloadOperation.h
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SZDownloadOperation : NSOperation



/**
 * 下载图片的主方法
 * @param URLString 图片地址
 * @param finishedBlock 图片下载完的回调
 */
+ (instancetype)downloadImageWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *))finishedBlock;

@end
