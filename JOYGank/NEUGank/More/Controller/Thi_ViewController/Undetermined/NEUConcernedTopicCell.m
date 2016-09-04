//
//  NEUConcernedTopicCell.m
//  NEUGank
//
//  Created by 周鑫城 on 8/3/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUConcernedTopicCell.h"

@implementation NEUConcernedTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(NEUTableViewBaseItem *)object {
    return 60;
}

@end
