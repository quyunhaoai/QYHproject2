//
//  QyhCustomTableViewCell.m
//  QYHproject
//
//  Created by hao on 2017/12/5.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QyhCustomTableViewCell.h"

@implementation QyhCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    /*
    UIView *backgroundview = [[UIView alloc]init];
    backgroundview.backgroundColor = [UIColor redColor];
    self.selectedBackgroundView = backgroundview;
    */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    NSLog(@"frame:%@",NSStringFromCGRect(frame));
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
