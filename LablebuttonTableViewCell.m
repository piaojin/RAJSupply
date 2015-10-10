//
//  LablebuttonTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "LablebuttonTableViewCell.h"

@implementation LablebuttonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.key=[[UILabel alloc] initWithFrame:CGRectMake(5 , 11, 68, 21)];
        self.key.font=[UIFont systemFontOfSize:17];
        self.key.textColor=[UIColor blackColor];
        
        self.value=[[UILabel alloc] initWithFrame:CGRectMake(81, 11, 200, 21)];
        self.value.font=[UIFont systemFontOfSize:17];
        self.value.textColor=[UIColor  brownColor];
        
        self.choice=[[UIButton alloc] initWithFrame:CGRectMake(274, 7, 40, 30)];
        [self.choice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.choice setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.choice setBackgroundColor:[UIColor greenColor]];
        
        [self.contentView addSubview:self.key];
        [self.contentView addSubview:self.value];
        [self.contentView addSubview:self.choice];

        
    
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
