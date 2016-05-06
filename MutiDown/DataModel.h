//
//  DataModel.h
//  MutiDown
//
//  Created by zhudm on 16/5/5.
//  Copyright © 2016年 zhudm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, copy) NSString * itemUrl;
@property (nonatomic, retain) NSURLSessionDownloadTask * task;

@end
