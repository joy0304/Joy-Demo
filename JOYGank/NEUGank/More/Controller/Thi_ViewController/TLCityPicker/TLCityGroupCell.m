//
//  AppDelegate.m
//  TLCityPicker
//
//  Created by yuchen on 15/12/15.
//  Copyright © 2015年 yuchen. All rights reserved.
//


#import "TLCityGroupCell.h"

#define     MIN_SPACE           8           // 城市button最小间隙
#define     MAX_SPACE           10

#define     WIDTH_LEFT          13.5        // button左边距
#define     WIDTH_RIGHT         28          // button右边距

#define     MIN_WIDTH_BUTTON    75
#define     HEIGHT_BUTTON       38

@interface TLCityGroupCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *noDataLabel;

@property (nonatomic, strong) NSMutableArray *arrayCityButtons;

@end

@implementation TLCityGroupCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self addSubview:self.titleLabel];
        [self addSubview:self.noDataLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    float x = WIDTH_LEFT;
    float y = 5;
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [self.titleLabel setFrame:CGRectMake(x, y, self.frame.size.width - x, size.height)];
    y += size.height + 3;
    [self.noDataLabel setFrame:CGRectMake(x + 5, y, self.frame.size.width - x - 5, self.titleLabel.frame.size.height)];
    
    y += 7;
    float space = MIN_SPACE;            // 最小空隙
    float width = MIN_WIDTH_BUTTON;     // button最小宽度
    int t = (self.frame.size.width - WIDTH_LEFT - WIDTH_RIGHT + space) / (width + space);
    
    space = (self.frame.size.width - WIDTH_LEFT - WIDTH_RIGHT - width * t) / (t - 1);        // 修正空隙宽度
    if (space > MAX_SPACE) {                                                                // 修正button宽度
        width += (space - MAX_SPACE) * (t - 1) / t;
        space = MAX_SPACE;
    }
    
    for (int i = 0; i < self.arrayCityButtons.count; i ++) {
        UIButton *button = [self.arrayCityButtons objectAtIndex:i];
        [button setFrame:CGRectMake(x, y, width, HEIGHT_BUTTON)];
        if ((i + 1) % t == 0) {
            y += HEIGHT_BUTTON + 5;
            x = WIDTH_LEFT;
        }
        else {
            x += width + space;
        }
    }
}

+ (CGFloat) getCellHeightOfCityArray:(NSArray *)cityArray
{
    float h = 30;
    if (cityArray != nil && cityArray.count > 0) {
        float space = MIN_SPACE;            // 最小空隙
        float width = MIN_WIDTH_BUTTON;     // button最小宽度
        int t = ([UIScreen mainScreen].bounds.size.width - WIDTH_LEFT - WIDTH_RIGHT + space) / (width + space);
        
        space = ([UIScreen mainScreen].bounds.size.width - WIDTH_LEFT - WIDTH_RIGHT - width * t) / (t - 1);        // 修正空隙宽度
        if (space > MAX_SPACE) {                                                                // 修正button宽度
            width += (space - MAX_SPACE) * (t - 1) / t;
            space = MAX_SPACE;
        }

        h += (10 + (HEIGHT_BUTTON + 5) * (cityArray.count / t + (cityArray.count % t == 0 ? 0 : 1)));
    }
    else {
        h += 17;
    }
    return h;
}

#pragma mark - Setter
- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

- (void) setCityArray:(NSArray *)cityArray
{
    _cityArray = cityArray;
    [self.noDataLabel setHidden:(cityArray != nil && cityArray.count > 0)];
 
    for (int i = 0; i < cityArray.count; i ++) {
        TLCity *city = [cityArray objectAtIndex:i];
        UIButton *button = nil;
        if (i < self.arrayCityButtons.count) {
            button = [self.arrayCityButtons objectAtIndex:i];
        }
        else {
            button = [[UIButton alloc] init];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:2.0f];
            [button.layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1.0].CGColor];
            [button.layer setBorderWidth:1.0f];
            [button addTarget:self action:@selector(cityButtonDown:) forControlEvents:UIControlEventTouchUpInside];
            [self.arrayCityButtons addObject:button];
            [self addSubview:button];
        }
        [button setTitle:city.cityName forState:UIControlStateNormal];
        button.tag = i;
    }
    while (cityArray.count < self.arrayCityButtons.count) {
        [self.arrayCityButtons removeLastObject];
    }
}

#pragma mark - Event Response
- (void) cityButtonDown:(UIButton *)sender
{
    TLCity *city = [self.cityArray objectAtIndex:sender.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(cityGroupCellDidSelectCity:)]) {
        [_delegate cityGroupCellDidSelectCity:city];
    }
}

#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _titleLabel;
}

- (UILabel *) noDataLabel
{
    if (_noDataLabel == nil) {
        _noDataLabel = [[UILabel alloc] init];
        [_noDataLabel setText:@"暂无数据"];
        [_noDataLabel setTextColor:[UIColor grayColor]];
        [_noDataLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _noDataLabel;
}

- (NSMutableArray *) arrayCityButtons
{
    if (_arrayCityButtons == nil) {
        _arrayCityButtons = [[NSMutableArray alloc] init];
    }
    return _arrayCityButtons;
}


@end
