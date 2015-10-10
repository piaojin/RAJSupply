//
//  ImageNotChangeTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "ImageNotChangeTableViewCell.h"

@implementation ImageNotChangeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //为适配不同屏幕可能试需要修改坐标的
        
        self.img1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 70)];
        self.img1.contentMode=UIViewContentModeScaleAspectFit;
        
        self.img2=[[UIImageView alloc] initWithFrame:CGRectMake(122, 0, 77, 70)];
        self.img2.contentMode=UIViewContentModeScaleAspectFit;
        
        self.img3=[[UIImageView alloc] initWithFrame:CGRectMake(235, 0, 77, 70)];
        self.img3.contentMode=UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.img3];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
