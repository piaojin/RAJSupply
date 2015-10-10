//
//  TextTableViewCell.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.key=[[UILabel alloc] initWithFrame:CGRectMake(5 , 11, 68, 21)];
        self.key.font=[UIFont systemFontOfSize:17];
        self.key.textColor=[UIColor blackColor];
        
        self.value=[[UITextField alloc] initWithFrame:CGRectMake(81, 7, 185, 30)];
        self.value.borderStyle=UITextBorderStyleRoundedRect;
        self.value.font=[UIFont systemFontOfSize:17];
        self.value.textColor=[UIColor  blackColor];
      // [self.value addTarget:self action:@selector(textFieldDidEndEditing:)  forControlEvents:UIControlEventEditingDidEndOnExit];
      ///  self.value.delegate=self;
        
        
        
        self.choice=[[UIButton alloc] initWithFrame:CGRectMake(274, 7, 40, 30)];
        [self.choice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.choice setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.choice setBackgroundColor:[UIColor blueColor]];
        self.choice.hidden=YES;
        
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
