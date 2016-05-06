//
//  TableViewCell.m
//  MutiDown
//
//  Created by 朱大茂 on 16/5/5.
//  Copyright © 2016年 zhudm. All rights reserved.
//

#import "TableViewCell.h"
#import "AFNetworking.h"

@interface TableViewCell ()

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"begin"] forState:UIControlStateNormal];
    [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
}

- (void)setMp3:(DataModel *)mp3{
    if (_mp3 != mp3) {
        self.titleLable.text = mp3.itemUrl;
        _mp3 = mp3;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeState:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.mp3.task) {
        self.mp3.task.state == NSURLSessionTaskStateRunning?  [self.mp3.task suspend]:[self.mp3.task resume];
    }else{
        
        NSError *serializationError = nil;
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[[NSURL URLWithString:self.mp3.itemUrl relativeToURL:nil] absoluteString] parameters:nil error:&serializationError];
        if (serializationError) {
            return;
        }
        
        AFHTTPSessionManager  * manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
       self.mp3.task =   [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressView.progress = downloadProgress.fractionCompleted;
            });
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
                NSString * tempName = [NSString stringWithFormat:@"%d.mp3",arc4random()];
//            NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
//                                                                   , NSUserDomainMask, YES) lastObject];
//            NSString * homeDir = [path2 stringByAppendingPathComponent:tempName];
//            
//            
//            return  [NSURL URLWithString:homeDir];
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [cachesPath stringByAppendingPathComponent:tempName];
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            sender.selected = NO;
        }];
        

        [self.mp3.task resume];
    }
    
    
    if (self.block) {
        self.block(!sender.selected);
    }
}

@end
