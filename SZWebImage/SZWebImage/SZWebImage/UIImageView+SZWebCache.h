//
//  UIImageView+SZWebCache.h
//  SZWebImage
//
//  Created by Zahi on 2017/6/25.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZWebImageManager.h"


/**
 * 1.分类可以拓展方法
 * 2.分类可以定义属性，但是系统不会自动实现set和get方法
 * 3.分类不能拓展带下划线的成员变量，应为分类的结构体里面没有准备变量来存放成员变量
 * 4.分类的属性不能存值，必须使用运行时的关联对象
 */

@interface UIImageView (SZWebCache)

/**上一次图片的链接**/
@property (nonatomic, copy) NSString *lastURLString;



/**
 * UIImageView下载图片
 * @param URLString 图片的链接
 */
- (void)sz_setImageWithURLString:(NSString *)URLString;

@end
