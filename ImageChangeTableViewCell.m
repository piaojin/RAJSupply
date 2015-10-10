//
//  ImageChangeTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "ImageChangeTableViewCell.h"

@implementation ImageChangeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        self.img1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 70)];
        self.img1.contentMode=UIViewContentModeScaleAspectFit;
        self.img1.tag=200;
        
        self.img2=[[UIImageView alloc] initWithFrame:CGRectMake(122, 0, 77, 70)];
        self.img2.contentMode=UIViewContentModeScaleAspectFit;
        self.img2.tag=400;
        
        self.img3=[[UIImageView alloc] initWithFrame:CGRectMake(235, 0, 77, 70)];
        self.img3.contentMode=UIViewContentModeScaleAspectFit;
        self.img3.tag=600;
        
        self.addbut1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 77, 70)];
        [self.addbut1 setBackgroundColor:[UIColor clearColor]];
        [self.addbut1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.addbut1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [self.addbut1 setTitle:@"+" forState:UIControlStateNormal];
        self.addbut1.tag=100;
        
        self.addbut2=[[UIButton alloc] initWithFrame:CGRectMake(122, 0, 77, 70)];
        [self.addbut2 setBackgroundColor:[UIColor clearColor]];
        [self.addbut2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.addbut2 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [self.addbut2 setTitle:@"+" forState:UIControlStateNormal];
        self.addbut2.tag=200;
        
        self.addbut3=[[UIButton alloc] initWithFrame:CGRectMake(235, 0, 77, 70)];
        [self.addbut3 setBackgroundColor:[UIColor clearColor]];
        [self.addbut3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.addbut3 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [self.addbut3 setTitle:@"+" forState:UIControlStateNormal];
        self.addbut3.tag=300;
        
        
        
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.img3];
        [self.contentView addSubview:self.addbut1];
        [self.contentView addSubview:self.addbut2];
        [self.contentView addSubview:self.addbut3];
      
        
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
