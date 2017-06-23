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

/**接受外界传入的图片地址**/
@property (nonatomic, copy) NSString *urlString;

/**接受外接出入的回调block**/
@property (nonatomic, copy) void(^finishedBlock)(UIImage *);

@end
