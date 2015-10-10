//
//  LableTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "LableTableViewCell.h"

@implementation LableTableViewCell

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
        
        self.unit=[[UILabel alloc] initWithFrame:CGRectMake(289, 11, 19, 21)];
        self.unit.font=[UIFont systemFontOfSize:17];
        self.unit.textColor=[UIColor  blueColor];
        self.unit.hidden=YES;
        
        [self.contentView addSubview:self.key];
        [self.contentView addSubview:self.value];
        [self.contentView addSubview:self.unit];
        
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
