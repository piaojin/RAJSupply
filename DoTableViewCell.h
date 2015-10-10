//
//  DoTableViewCell.h
//  RAJSupply
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoTableViewCell : UITableViewCell

@property(nonatomic,retain) UILabel * name;
@property(nonatomic,retain)  UILabel * price;
@property(nonatomic,retain)  UILabel * txtprice;
@property(nonatomic,retain)  UIImageView * productimage;
@property(nonatomic,retain)  UILabel * state;

@end
