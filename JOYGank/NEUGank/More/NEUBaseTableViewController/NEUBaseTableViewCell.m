//
//  NEUTableViewCell.m
//  CustomTableView
//
//  Created by 周鑫城 on 7/14/16.
//  Copyright © 2016 ZXC. All rights reserved.
//

#import "NEUBaseTableViewCell.h"
#import "NEUTableViewBaseItem.h"
#import "UIView+NEUExtension.h"

@implementation NEUBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setObject:(NEUTableViewBaseItem *)object { // 子类在这个方法中解析数据
    self.imageView.image = object.itemImage;
    NSLog(@"set the item image");
    self.textLabel.text = object.itemTitle;
    NSLog(@"set the item title");
    self.detailTextLabel.text = object.itemSubtitle;
    NSLog(@"set the item subtitle");
    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
    NSLog(@"set the item accessory image");
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(NEUTableViewBaseItem *)object {
    return 44.0f;
}

@end
