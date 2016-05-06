//
//  TableViewCell.h
//  MutiDown
//
//  Created by 朱大茂 on 16/5/5.
//  Copyright © 2016年 zhudm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

typedef void(^DownBlock)(BOOL stop);

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;

@property (nonatomic ,copy) DownBlock block;

@property (nonatomic, retain) DataModel *mp3;

@end
