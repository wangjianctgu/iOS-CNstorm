//
//  MyCNstormTableViewCell.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-7.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "MyCNstormTableViewCell.h"

#import "UIdefine.h"

@implementation MyCNstormTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.rowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 14.0f, 16.0f, 16.0f)];
        self.rowImageView.highlighted = NO;
        [self.contentView addSubview:self.rowImageView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(44.0f, 14.0f, 100.0f, 16.0f)];
        self.nameLabel.textColor = RGBCOLOR(51.0f, 51.0f, 51.0f);
        self.nameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.nameLabel];
        
        self.rowDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(185.0f, 7.0f, 100.0f, 30.0f)];
        self.rowDetailLabel.font = [UIFont systemFontOfSize:13.0f];
        self.rowDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.rowDetailLabel.numberOfLines = 1;
        self.rowDetailLabel.textAlignment = NSTextAlignmentRight;
        self.rowDetailLabel.adjustsFontSizeToFitWidth = YES;
        self.rowDetailLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        [self.contentView addSubview:self.rowDetailLabel];
        
        self.jsBadgeView = [[JSBadgeView alloc] initWithFrame:CGRectZero];
        self.jsBadgeView.badgeAlignment = JSBadgeViewAlignmentOnCell;
        [self.contentView addSubview:self.jsBadgeView];
        
        //箭头类型、图片
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryView"]];
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.rowImageView setFrame:self.rowImageViewFram];
    [self.rowImageView setImage:[UIImage imageNamed:self.myRow.rowImageName]];
    [self.rowImageView setHighlightedImage:[UIImage imageNamed:self.myRow.rowSelectedImageName]];
    self.rowImageView.clipsToBounds = YES;
    self.rowImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.nameLabel.text = self.myRow.rowName;
    self.nameLabel.highlightedTextColor = RGBACOLOR(251.0f,110.0f,83.0f,1.0f);
    
    self.rowDetailLabel.text = self.myRow.rowDetail;
}

@end
