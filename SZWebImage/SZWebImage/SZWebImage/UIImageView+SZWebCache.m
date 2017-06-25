//
//  UIImageView+SZWebCache.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/25.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "UIImageView+SZWebCache.h"


/**
 * 分类里面的属性不能存值的
 * 使用运行时关联对象
 */
#import <objc/message.h>/

@implementation UIImageView (SZWebCache)


- (void)setLastURLString:(NSString *)lastURLString
{
    
    /**
     * 赋值
     * @param object 要关联的对象
     * @param key    要关联key
     * @param value  关联的值
     * @param policy 关联的值的存储策略
     */
    objc_setAssociatedObject(self, @"lastURLString", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)lastURLString
{
    /**
     * 取值
     * @param object 要关联的对象
     * @param key    要关联key
     */
    return objc_getAssociatedObject(self, @"lastURLString");
}


- (void)sz_setImageWithURLString:(NSString *)URLString
{
    // 判断本次链接和上次链接是否一样 不一样就把之前操作取消掉
    // 第一次下载 上一次图片地址为空
    if (self.lastURLString != nil && ![URLString isEqualToString:self.lastURLString]) {//不一样
        
        [[SZWebImageManager sharedManager] cancelFormLastURLString:self.lastURLString];
    }
    
    // 记录上一次图片链接
    self.lastURLString = URLString;
    
    // 单例管理下载操作：取消操作失效
    [[SZWebImageManager sharedManager] downloadImageWithURLString:URLString completion:^(UIImage *image) {
        
        self.image = image;
        
    }];
}

@end
