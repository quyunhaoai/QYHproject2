//
//  oneViewController.m
//  QYHproject
//
//  Created by hao on 2017/12/2.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "oneViewController.h"
#import "QyhCustomTableViewCell.h"
static NSString *const cellId = @"id";
@interface oneViewController ()

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake( 35, 0, 64, 0);
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QyhCustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor grayColor];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 269.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID = @"qyhcell";
    QyhCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%@--%ld-1",self.class,indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---%ld",indexPath.row);
}

@end
