//
//  ButtonTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.left=[[UIButton alloc] initWithFrame:CGRectMake(41, 7, 100, 30)];
        [self.left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.left setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.left setBackgroundColor:[UIColor colorWithRed:0.2 green:0.3 blue:0.4 alpha:0.5]];
    
        self.right=[[UIButton alloc] initWithFrame:CGRectMake(181, 7, 100, 30)];
        [self.right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.right setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.right setBackgroundColor:[UIColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.5]];
        
        [self.contentView addSubview:self.left];
        [self.contentView addSubview:self.right];
        
        
        
    
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
