//
//  DetailViewController.h
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) NSDictionary * dict;
@end
