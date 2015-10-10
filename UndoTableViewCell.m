//
//  MyTableViewCell.m
//  JustCode
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "UndoTableViewCell.h"

@implementation UndoTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.name=[[UILabel alloc] initWithFrame:CGRectMake(94 , 8, 126, 21)];
        self.name.font=[UIFont systemFontOfSize:17];
        self.name.textColor=[UIColor blueColor];
        
        self.productimage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 73, 58)];
        self.productimage.contentMode=UIViewContentModeScaleAspectFit;
        
        self.txtprice=[[UILabel alloc] initWithFrame:CGRectMake(94 , 31, 33, 21)];
        self.txtprice.font=[UIFont systemFontOfSize:11];
        self.txtprice.textColor=[UIColor blackColor];
        self.txtprice.text=@"价格";
        
        self.price=[[UILabel alloc] initWithFrame:CGRectMake(135 , 31, 85, 21)];
        self.price.font=[UIFont systemFontOfSize:11];
        self.price.textColor=[UIColor redColor];
        
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.productimage];
        [self.contentView addSubview:self.txtprice];
        [self.contentView addSubview:self.price];
        
        
        
        
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
