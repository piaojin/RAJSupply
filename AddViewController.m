//
//  AddViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "AddViewController.h"
#import "ImageChangeTableViewCell.h"
#import "LableTableViewCell.h"
#import "TextTableViewCell.h"
#import "LablebuttonTableViewCell.h"
#import "AppHelper.h"

#define NUMBER_OF_ROWS_IN_SECTION 13 //每组显示的数量

@interface AddViewController () {
    // UITableView * tableview;
    NSArray* keys;
    NSArray* enkeys;
    CGRect y;
    int dataindex;
    UILabel* changevaule;
    UIImageView* choiceimage;
    NSMutableDictionary* senddata;

    NSMutableArray* catdata; //类别
    NSMutableArray* adddata;
    NSMutableArray* sizedata;

    NSInteger viewindex;
}
- (void)initData;
- (void)initCate;
- (void)initAddr;
@end

@implementation AddViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"送版";

    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:(UIBarButtonItemStyleBordered)target:self action:@selector(newproduct:)];
    self.navigationItem.rightBarButtonItem = right;

    [self initData];
    [self initCate];
    [self initAddr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化页面控件
- (void)initData
{
    dataindex = 1;
    keys = [NSArray arrayWithObjects:@"类别", @"款号", @"品名", @"价格", @"码数", @"出货时间", @"首单数量", @"翻单周期", @"送版时间", @"大货尺寸", @"送版地址", @"送版留言", nil];
    enkeys = [NSArray arrayWithObjects:@"CategoryName", @"ProductName", @"ProductName", @"Price", @"Size", @"DeliveryTime", @"FirstOrderCount", @"ReorderDays", @"GiveSampleDate", @"BigSize", @"Address1", @"VendorRemarks", nil];
    senddata = [[NSMutableDictionary alloc] init];
    [senddata setObject:[Tool GetDate:@"YYYY-MM-dd"] forKey:@"DeliveryTime"];
    [senddata setObject:[Tool GetDate:@"YYYY-MM-dd"] forKey:@"GiveSampleDate"];
}

#pragma mark -初始化类别数据
- (void)initCate
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults valueForKey:@"UserName"];
    NSString* password = [defaults valueForKey:@"Password"];

    NSString* strurl = [Tool Append:defaultWebServiceUrl witnstring:@"GetAllCategories"];
    NSURL* myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCatResult:)];
    [request setDidFailSelector:@selector(getCatErr:)];
    [request startAsynchronous];
}
#pragma mark -类别数据请求结果
- (void)getCatResult:(ASIHTTPRequest*)req
{
    NSLog(@"请求类别数据成功");
    NSString* responseString = [req responseString];
    NSMutableDictionary* arr = [SoapXmlParseHelper rootNodeToArray:responseString];
    NSString* dictstring = [[arr objectForKey:@"text"] mutableCopy];
    catdata = [Tool StringTojosn:dictstring];
    //NSLog(@"%@",arr);
}
- (void)getCatErr:(ASIHTTPRequest*)req
{
    [Tool alert:@"请求类别数据出错，请检查网络"];
}

#pragma mark -初始化地址数据
- (void)initAddr
{

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults valueForKey:@"UserName"];
    NSString* password = [defaults valueForKey:@"Password"];

    NSString* strurl = [Tool Append:defaultWebServiceUrl witnstring:@"GetAddressWithUser"];
    NSURL* myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getAddResult:)];
    [request setDidFailSelector:@selector(getAddErr:)];
    [request startAsynchronous];
}
#pragma mark -类别数据请求结果
- (void)getAddResult:(ASIHTTPRequest*)req
{
    NSLog(@"请求数据成功");
    NSString* responseString = [req responseString];
    NSMutableDictionary* arr = [SoapXmlParseHelper rootNodeToArray:responseString];
    NSString* dictstring = [[arr objectForKey:@"text"] mutableCopy];
    adddata = [Tool StringTojosn:dictstring];
    NSLog(@"***%@***", [[adddata objectAtIndex:0] valueForKey:@"Address1"]);
}
- (void)getAddErr:(ASIHTTPRequest*)req
{
    [Tool alert:@"请求地址数据出错，请检查网络"];
}

#pragma mark -初始化类别的码数信息

- (void)initSize:(NSString*)catid
{

    NSMutableDictionary* sizeone = [[NSMutableDictionary alloc] init];
    [sizeone setValue:@"S" forKey:@"size"];

    NSMutableDictionary* sizetwo = [[NSMutableDictionary alloc] init];
    [sizetwo setValue:@"M" forKey:@"size"];
    NSMutableDictionary* sizethird = [[NSMutableDictionary alloc] init];
    [sizethird setValue:@"L" forKey:@"size"];

    NSMutableArray* arr = [[NSMutableArray alloc] initWithObjects:sizeone, sizetwo, sizethird, nil];
    sizedata = arr;
    /*
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"GetAddressWithUser"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getSizeResult:)];
    [request setDidFailSelector:@selector(getSizeErr:)];
    [request startAsynchronous];
     */
}
#pragma mark -类别码数数据请求结果
/*
- (void) getSizeResult:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[[arr objectForKey:@"text"] mutableCopy];
    adddata=[Tool StringTojosn:dictstring];
    
}
- (void) getSizeErr:(ASIHTTPRequest *) req
{
    [Tool alert:@"请求地址数据出错，请检查网络"];
}
*/

#pragma mark - 表格代理是需要实现的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUMBER_OF_ROWS_IN_SECTION;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    //  static  NSString * idtcell=@"cell";
    NSInteger rowindex = [indexPath row];
    UITableViewCell* cell = nil;
    //  NSLog(@"%d",rowindex);
    NSString* CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];

    //第一行用于添加图片(+ + +)
    if (rowindex == 0) {

        ImageChangeTableViewCell* tempcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempcell == nil) {
            tempcell = [[ImageChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [tempcell.addbut1 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];
        [tempcell.addbut2 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];
        [tempcell.addbut3 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];

        cell = tempcell;
    }
    //选择按钮所在行
    else if (rowindex == 1 || rowindex == 5 || rowindex == 6 || rowindex == 9 || rowindex == 11) {
        LablebuttonTableViewCell* tempcell = [[LablebuttonTableViewCell alloc] init];
        tempcell.key.text = [keys objectAtIndex:rowindex - 1];
        tempcell.value.text = [senddata objectForKey:[enkeys objectAtIndex:rowindex - 1]];
        tempcell.value.tag = 999;
        if (rowindex == 6 || rowindex == 9) {
            tempcell.value.text = [Tool GetDate:@"YYYY-MM-dd"];
        }
        [tempcell.choice setTitle:@"选择" forState:UIControlStateNormal];
        tempcell.choice.tag = rowindex;
        [tempcell.choice addTarget:self action:@selector(choicefunction:) forControlEvents:UIControlEventTouchUpInside];
        cell = tempcell;
    }
    else {

        TextTableViewCell* tempcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempcell == nil) {
            tempcell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        if ([[keys objectAtIndex:rowindex - 1] isEqualToString:@"翻单周期"]) {
            tempcell.choice.hidden = NO;
            tempcell.choice.backgroundColor = [UIColor clearColor];
            [tempcell.choice setTitle:@"天" forState:UIControlStateNormal];
            [tempcell.choice setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [tempcell.choice setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        }

        tempcell.key.text = [keys objectAtIndex:rowindex - 1];
        tempcell.value.text = [senddata objectForKey:[enkeys objectAtIndex:rowindex - 1]];
        tempcell.value.delegate = self;
        tempcell.value.tag = rowindex;
        [tempcell.value addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [tempcell.value addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        cell = tempcell;
    }

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        cell.separatorInset = UIEdgeInsetsZero;
    }

    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([indexPath row] == 0) {
        return 71;
    }
    else {
        return 44;
    }
}

#pragma mark -选择功能的实现
- (void)choicefunction:(UIButton*)btn
{
    UITableViewCell* tcell = (UITableViewCell*)[[[btn superview] superview] superview];
    NSIndexPath* indexPath;
    //在ios8下tcell为nil
    if(iOS(8)){
        
        indexPath=[NSIndexPath indexPathForRow:(long)btn.tag inSection:0];
    }else{
        
        indexPath= [self.tableView indexPathForCell:tcell];
    }
    
    
    LablebuttonTableViewCell* cell = (LablebuttonTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UILabel* lab = (UILabel*)[cell viewWithTag:999];
    changevaule = lab;

    switch (btn.tag) {
    case 1:
        // NSLog(@"1->%d",btn.tag);
        //弹出类别选择器
            if (iOS(8)) { //当前系统版本大于等于ios8
                
                [self startCateDialogForHeightSys]; //ios8或更高系统
            }
            else {
                
                [self startCateDialog]; //ios7
            }

        break;
    case 5:
        // NSLog(@"2->%d",btn.tag);
        [self startSizeDialog];
        break;
    case 6: {
        //弹出时间选择器
        [self startDateDialog];

    } break;
    case 9: {
        //弹出时间选择器
        [self startDateDialog];

    } break;
    case 11:
        //弹出地址选择器
        //  NSLog(@"5->%d",btn.tag);
        if (iOS(8)) { //当前系统版本大于等于ios8

            [self startAddreDialogForHeightSys]; //ios8或更高系统
        }
        else {

            [self startAddreDialog]; //ios7
        }
        break;
    default:
        break;
    }
}
#pragma mark -初始化时间选择器
- (void)startDateDialog
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet* dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                            delegate:(id)self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"选择",
                                                   nil];
    [dateDialog showInView:self.view];
    UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];

    [datePicker setDatePickerMode:UIDatePickerModeDate];
    dateDialog.tag = 102;
    datePicker.tag = 101;
    [dateDialog addSubview:datePicker];
}

- (void)startAddreDialogForHeightSys
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    [alertController
        addAction:[UIAlertAction
                      actionWithTitle:@"选择"
                                style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction* action) {

                                  UIPickerView* datePicker = (UIPickerView*)
                                      [alertController.view viewWithTag:105];
                                  NSInteger selecom1 =
                                      [datePicker selectedRowInComponent:0];

                                  NSString* prov =
                                      [[adddata objectAtIndex:selecom1]
                                          objectForKey:@"Address1"];
                                  NSString* Addid =
                                      [[adddata objectAtIndex:selecom1]
                                          objectForKey:@"AddressID"];
                                  changevaule.text = prov;
                                  [senddata setObject:Addid
                                               forKey:@"GiveSampleAddressID"];
                                  [senddata setObject:prov forKey:@"Address1"];
                                  

                              }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction* action){

                                                      }]];
    UIPickerView* datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    //datePicker.showsSelectionIndicator = YES;
    datePicker.tag = 105;

    [alertController.view addSubview:datePicker];
    [self presentViewController:alertController
                       animated:YES
                     completion:^{

                     }];
}

#pragma mark -初始化地址选择器

- (void)startAddreDialog
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet* dateDialog1 = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:(id)self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"选择",
                                                    nil];
    [dateDialog1 showInView:self.view];
    UIPickerView* datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    dateDialog1.tag = 106;
    datePicker.tag = 105;
    datePicker.showsSelectionIndicator = YES;
    [dateDialog1 addSubview:datePicker];
}

- (void)startCateDialogForHeightSys
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController
     addAction:[UIAlertAction
                actionWithTitle:@"选择"
                style:UIAlertActionStyleDefault
                handler:^(UIAlertAction* action) {
                    
                    UIPickerView* datePicker = (UIPickerView*)[alertController.view viewWithTag:103];
                    
                    NSInteger selecom1 = [datePicker selectedRowInComponent:0];
                    
                        NSString* prov = [[catdata objectAtIndex:selecom1] objectForKey:@"CategoryName"];
                        NSString* catid = [[catdata objectAtIndex:selecom1] objectForKey:@"CategoryID"];
                        changevaule.text = prov;
                        [senddata setObject:catid forKey:@"catid"];
                        [senddata setObject:prov forKey:@"CategoryName"];
                        [self initSize:catid];

                    
                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction* action){
                                                          
                                                      }]];
    UIPickerView* datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    //datePicker.showsSelectionIndicator = YES;
    datePicker.tag = 103;
    
    [alertController.view addSubview:datePicker];
    [self presentViewController:alertController
                       animated:YES
                     completion:^{
                         
                     }];
}

#pragma mark -初始化类别选择器

- (void)startCateDialog
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet* dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                            delegate:(id)self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"选择",
                                                   nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog showInView:self.view];
    UIPickerView* datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    dateDialog.tag = 104;
    datePicker.tag = 103;
    [dateDialog addSubview:datePicker];
}

#pragma mark -初始化码数选择器
- (void)startSizeDialog
{
    NSString* title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet* dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                            delegate:(id)self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"选择", @"回退",
                                                   nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog showInView:self.view];
    UIPickerView* datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    dateDialog.tag = 108;
    datePicker.tag = 107;
    [dateDialog addSubview:datePicker];
}

#pragma mark -uipickview的代理实现
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{

    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 105) {
        return [adddata count];
    }
    else if (pickerView.tag == 103) {
        return [catdata count];
    }
    else {
        return [sizedata count];
    }
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 105) {
        return [[adddata objectAtIndex:row] objectForKey:@"Address1"];
    }
    else if (pickerView.tag == 103) {
        return [[catdata objectAtIndex:row] objectForKey:@"CategoryName"];
    }
    else {
        return [[sizedata objectAtIndex:row] objectForKey:@"size"];
    }
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

#pragma mark -sheet回调

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    //选择时间
    if (actionSheet.tag == 102) {
        UIDatePicker* datePicker = (UIDatePicker*)[actionSheet viewWithTag:101];
        NSDate* date = [datePicker date];
        // NSLog(@"%d",buttonIndex);

        if (buttonIndex == 0) {
            NSDateFormatter* dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"YYYY-MM-dd"];
            switch (dataindex) {
            case 1:
                changevaule.text = [dateformat stringFromDate:date];
                [senddata setObject:[dateformat stringFromDate:date] forKey:@"DeliveryTime"];
                break;
            default:
                changevaule.text = [dateformat stringFromDate:date];
                [senddata setObject:[dateformat stringFromDate:date] forKey:@"GiveSampleDate"];
                break;
            }
        }
    }

    //获取选择的类别
    if (actionSheet.tag == 104) {

        UIPickerView* datePicker = (UIPickerView*)[actionSheet viewWithTag:103];

        NSInteger selecom1 = [datePicker selectedRowInComponent:0];

        if (buttonIndex == 0) {
            NSString* prov = [[catdata objectAtIndex:selecom1] objectForKey:@"CategoryName"];
            NSString* catid = [[catdata objectAtIndex:selecom1] objectForKey:@"CategoryID"];
            changevaule.text = prov;
            [senddata setObject:catid forKey:@"catid"];
            [senddata setObject:prov forKey:@"CategoryName"];
            [self initSize:catid];
        }
    }

    //获取选择的地址
    if (actionSheet.tag == 106) {
        UIPickerView* datePicker = (UIPickerView*)[actionSheet viewWithTag:105];
        NSInteger selecom1 = [datePicker selectedRowInComponent:0];

        if (buttonIndex == 0) {
            NSString* prov = [[adddata objectAtIndex:selecom1] objectForKey:@"Address1"];
            NSString* Addid = [[adddata objectAtIndex:selecom1] objectForKey:@"AddressID"];
            changevaule.text = prov;
            [senddata setObject:Addid forKey:@"GiveSampleAddressID"];
            [senddata setObject:prov forKey:@"Address1"];
        }
    }

    //获取选择的地址
    if (actionSheet.tag == 108) {
        UIPickerView* datePicker = (UIPickerView*)[actionSheet viewWithTag:107];
        NSInteger selecom1 = [datePicker selectedRowInComponent:0];
        // NSLog(@"%d",buttonIndex);
        if (buttonIndex == 0) {
            NSString* size = [[sizedata objectAtIndex:selecom1] objectForKey:@"size"];
            NSString* va = changevaule.text;
            if (va != nil) {
                va = [va stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if ([va rangeOfString:size].location == NSNotFound) {
                    changevaule.text = [changevaule.text stringByAppendingFormat:@"-%@", size];
                }
            }
            else {
                changevaule.text = size;
            }

            [senddata setObject:size forKey:@"Size"];
        }
        else if (buttonIndex == 1) {
            NSString* va = changevaule.text;
            if (va != nil) {
                NSInteger len = va.length;
                if (len > 2) {
                    changevaule.text = [va substringToIndex:len - 2];
                }
                else {
                    changevaule.text = @"";
                }
            }
        }
    }

    //选择图片
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
            case 0:
                //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                // 取消
                return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else {
                return;
            }
        }

        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = (id)self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController
                           animated:YES
                         completion:^{
                         }];
    }
}

#pragma mark - 选择图片
- (void)choiceimg:(UIButton*)btn
{
    UITableViewCell* tcell = (UITableViewCell*)[[[btn superview] superview] superview];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:tcell];
    ImageChangeTableViewCell* cell = (ImageChangeTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView* img = (UIImageView*)[cell viewWithTag:btn.tag * 2];
    choiceimage = img;
    [self imagefromwhere];
}

#pragma mark -图片源函数
- (void)imagefromwhere
{
    UIActionSheet* action;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        action = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"相机", nil];
    }
    else {

        action = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
    }

    action.tag = 255;
    action.actionSheetStyle = UIActionSheetStyleAutomatic;
    [action showInView:self.view];
}
#pragma mark -图片设置到控件
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                               }];

    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];

    choiceimage.image = image;
    int index = (int)choiceimage.tag / 200;

    NSString* imagenamekey = [Tool Append:@"imagename" witnstring:[Tool intToString:index]];
    NSString* imagenamevaule = [Tool Append:@"imagenamedata" witnstring:[Tool intToString:index]];
    NSString* imagename = [[Tool GetOnlyString] stringByAppendingString:@".jpg"];
    NSData* dataimg = UIImageJPEGRepresentation(image, 0.01);
    NSString* datastring1 = [Tool NSdatatoBSString:dataimg]; //压缩编码发送
    [senddata setObject:imagename forKey:imagenamekey];
    [senddata setObject:datastring1 forKey:imagenamevaule];

    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
}

#pragma mark -键盘回收

- (void)textFieldDidEndEditing:(UITextField*)textField
{

    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    // CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
}

#pragma mark -保存输入的值

- (void)textFieldWithText:(UITextField*)text
{

    switch (text.tag) {
    case 2:
        [senddata setObject:text.text forKey:@"ProductNumber"];
        break;
    case 3:
        [senddata setObject:text.text forKey:@"ProductName"];
        break;
    case 4:
        [senddata setObject:text.text forKey:@"Price"];
        break;
    case 7:
        [senddata setObject:text.text forKey:@"FirstOrderCount"];
        break;
    case 8:
        [senddata setObject:text.text forKey:@"ReorderDays"];
        break;
    case 10:
        [senddata setObject:text.text forKey:@"BigSize"];

        break;
    case 12:
        [senddata setObject:text.text forKey:@"VendorRemarks"];

        break;
    default:
        break;
    }
}

#pragma mark - 新建事件触发
- (void)newproduct:(UIBarButtonItem*)btn
{
    [self isSand];
}

#pragma mark -弹出是否直接发送还是草稿的选择
- (void)isSand
{
    UIAlertView* myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是保存草稿还是直接发送？" delegate:self cancelButtonTitle:@"取消新建" otherButtonTitles:@"保存草稿", @"直接发送", nil];
    myAlertView.tag = 888;
    [myAlertView show];
}
#pragma mark -uialertview代理
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [AppHelper showHUD:@"loading"];
    if (alertView.tag == 888) {
        // NSLog(@"按的是%d",buttonIndex);
        switch (buttonIndex) {
        case 1:
            //保存草稿
            //  NSLog(@"保存草稿");
            [self sendNewproduct:@"0"];
            // viewindex=2;
            break;
        case 2:
            //直接发送
            // NSLog(@"直接发送");
            [self sendNewproduct:@"1"];
            //viewindex=0;
            break;

        default:

            break;
        }
    }
}
#pragma mark -实现新建的网络请求
- (void)sendNewproduct:(NSString*)vstate
{

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults valueForKey:@"UserName"];
    NSString* password = [defaults valueForKey:@"Password"];
    NSString* UserID = [defaults valueForKey:@"UserID"];

    NSString* strurl = [Tool Append:defaultWebServiceUrl witnstring:@"UploadImage3"];
    NSURL* myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:[senddata objectForKey:@"imagenamedata1"] forKey:@"data1"];
    [request setPostValue:[senddata objectForKey:@"imagename1"] forKey:@"filename1"];
    [request setPostValue:[senddata objectForKey:@"imagenamedata2"] forKey:@"data2"];
    [request setPostValue:[senddata objectForKey:@"imagename2"] forKey:@"filename2"];
    [request setPostValue:[senddata objectForKey:@"imagenamedata3"] forKey:@"data3"];
    [request setPostValue:[senddata objectForKey:@"imagename3"] forKey:@"filename3"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request startSynchronous];

    NSError* error = [request error];
    if (!error) {
        NSString* responseString = [request responseString];

        NSMutableDictionary* arr = [SoapXmlParseHelper rootNodeToArray:responseString];
        NSString* dictstring = [arr objectForKey:@"text"];
        NSDictionary* dict = [Tool StringTojosn:dictstring];
        if (dict) {
            NSString* state = [dict objectForKey:@"state"];
            if ([state isEqual:@"1"]) {

                //添加产品表数据
                NSString* strurl = [Tool Append:defaultWebServiceUrl witnstring:@"AddOneProductT"];
                NSURL* myurl = [NSURL URLWithString:strurl];
                ASIFormDataRequest* addproduct = [ASIFormDataRequest requestWithURL:myurl];
                NSString* ImageURL1 = [username stringByAppendingFormat:@"/%@", [senddata objectForKey:@"imagename1"]];
                NSString* ImageURL2 = [username stringByAppendingFormat:@"/%@", [senddata objectForKey:@"imagename2"]];
                NSString* ImageURL3 = [username stringByAppendingFormat:@"/%@", [senddata objectForKey:@"imagename3"]];
                [addproduct setPostValue:@"1" forKey:@"ProductID"];
                [addproduct setPostValue:UserID forKey:@"UserID"];
                [addproduct setPostValue:vstate forKey:@"Status"];
                [addproduct setPostValue:[senddata objectForKey:@"ProductName"] forKey:@"ProductName"];
                [addproduct setPostValue:[senddata objectForKey:@"Size"] forKey:@"Size"];
                [addproduct setPostValue:[senddata objectForKey:@"Price"] forKey:@"Price"];
                [addproduct setPostValue:[senddata objectForKey:@"DeliveryTime"] forKey:@"DeliveryTime"];
                [addproduct setPostValue:[senddata objectForKey:@"FirstOrderCount"] forKey:@"FirstOrderCount"];
                [addproduct setPostValue:[senddata objectForKey:@"ReorderDays"] forKey:@"ReorderDays"];
                [addproduct setPostValue:[senddata objectForKey:@"BigSize"] forKey:@"BigSize"];
                [addproduct setPostValue:[senddata objectForKey:@"GiveSampleDate"] forKey:@"GiveSampleDate"];
                [addproduct setPostValue:[senddata objectForKey:@"GiveSampleAddressID"] forKey:@"GiveSampleAddressID"];
                [addproduct setPostValue:[senddata objectForKey:@"VendorRemarks"] forKey:@"VendorRemarks"];
                [addproduct setPostValue:@"" forKey:@"ManagerRemarks"];
                [addproduct setPostValue:[Tool GetDate:@"YYYY-MM-dd"] forKey:@"AddedDate"];
                [addproduct setPostValue:ImageURL1 forKey:@"ImageURL1"];
                [addproduct setPostValue:ImageURL2 forKey:@"ImageURL2"];
                [addproduct setPostValue:ImageURL3 forKey:@"ImageURL3"];
                [addproduct setPostValue:@"" forKey:@"ImageURL4"];
                [addproduct setPostValue:@"" forKey:@"Discription"];
                [addproduct setPostValue:[senddata objectForKey:@"catid"] forKey:@"catid"];
                [addproduct setPostValue:username forKey:@"username"];
                [addproduct setPostValue:password forKey:@"password"];
                [addproduct setDelegate:self];
                [addproduct setDidFinishSelector:@selector(addProductResult:)];
                [addproduct setDidFailSelector:@selector(addproductErr:)];
                [addproduct startAsynchronous];
            }
            else {
                [Tool alert:@"执行添加操作失败，请重试！"];
                [AppHelper removeHUD];
            }
        }
        else {
            [Tool alert:@"发生未知错误!1"];
            [AppHelper removeHUD];
        }
    }
    else {
        [Tool alert:@"请检查您的网络"];
        [AppHelper removeHUD];
    }
}

//添加产品的网络代理
- (void)addProductResult:(ASIHTTPRequest*)req
{
    NSLog(@"请求数据成功");
    NSString* responseString = [req responseString];
    NSMutableDictionary* arr = [SoapXmlParseHelper rootNodeToArray:responseString];
    NSString* dictstring = [[arr objectForKey:@"text"] mutableCopy];
    NSDictionary* dict = [Tool StringTojosn:dictstring];
    if (dict) {
        NSString* state = [dict objectForKey:@"state"];
        if ([state isEqual:@"1"]) {
            [AppHelper removeHUD];

            [Tool alert:@"新建成功"];
            [senddata removeAllObjects];
            [self.tableView reloadData];
            self.tabBarController.selectedIndex = viewindex;
        }
        else {
            [AppHelper removeHUD];

            [Tool alert:@"新建失败，请重试！"];
        }
    }
    else {
        [AppHelper removeHUD];

        [Tool alert:@"发生未知错误!2"];
    }
}
- (void)addproductErr:(ASIHTTPRequest*)req
{
    [AppHelper removeHUD];
    [Tool alert:@"请求类别数据出错，请检查网络"];
}

@end
