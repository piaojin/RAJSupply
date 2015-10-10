//
//  CanChangeTableViewController.h
//  RAJSupply
//
//  Created by apple on 14-9-24.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanChangeTableViewController : UITableViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>

@property (weak,nonatomic) NSDictionary  * dict;


@end
