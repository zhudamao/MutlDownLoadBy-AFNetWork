//
//  ViewController.m
//  MutiDown
//
//  Created by 朱大茂 on 16/5/5.
//  Copyright © 2016年 zhudm. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DataModel.h"
#import "AFNetworking.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray * mp3Arry;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL * mp3Url = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"mp3.plist"];
    NSArray * items = [NSArray arrayWithContentsOfURL:mp3Url];
    
    NSMutableArray * mutableArry = [NSMutableArray arrayWithCapacity:items.count];
    
    for (NSString * res in items) {
        DataModel * model = [DataModel new];
        model.itemUrl = res;
        
        [mutableArry addObject:model];
    }
    
    self.mp3Arry = [mutableArry copy];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mp3Arry? self.mp3Arry.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    DataModel * mp3 = self.mp3Arry[indexPath.row];
    
    cell.mp3 = mp3;
    typeof (cell) __weak weakCell = cell;

    
    cell.block = ^(BOOL isDown){
        

    };
    
    return cell;
    
}

@end
