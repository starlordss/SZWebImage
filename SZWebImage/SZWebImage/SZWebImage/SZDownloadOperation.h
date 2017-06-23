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

/**url**/
@property (nonatomic, copy) NSString *urlString;

/**tack**/
@property (nonatomic, copy) void(^finishBlock)(UIImage *);

@end
