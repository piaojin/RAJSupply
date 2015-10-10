//
//  CanChangeTableViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-24.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "CanChangeTableViewController.h"
#import "ImageChangeTableViewCell.h"
#import "LableTableViewCell.h"
#import "TextTableViewCell.h"
#import "LablebuttonTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CanChangeTableViewController ()
{
    NSArray * keys;
    NSArray * values;
    
    NSArray * enkeys;
    CGRect y;
    int dataindex;
    UILabel * changevaule;
    UIImageView * choiceimage;
    NSMutableDictionary * senddata;
    
    NSMutableArray* catdata;
    NSMutableArray* adddata;
    NSMutableArray* sizedata;
    
    NSInteger  viewindex;
    
    
    NSString * vimg1;
    NSString * vimg2;
    NSString * vimg3;
    NSMutableDictionary *udict;

}
- (void) initData;
- (void) initCate;
- (void) initAddr;

@end

@implementation CanChangeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initCate];
    [self initAddr];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 初始化页面控件
- (void) initData
{
    dataindex=1;
    keys=[NSArray arrayWithObjects:@"类别",@"款号",@"品名",@"价格",@"码数",@"出货时间",@"首单数量"
          ,@"翻单周期",@"送版时间",@"大货尺寸",@"送版地址",@"送版留言",nil];
    enkeys=[NSArray arrayWithObjects:@"CategoryName",@"ProductName",@"ProductName",@"Price",@"Size",@"DeliveryTime",@"FirstOrderCount"
            ,@"ReorderDays",@"GiveSampleDate",@"BigSize",@"Address",@"VendorRemarks",nil];
   
    
    
    NSString * oldcat=[self.dict objectForKey:@"CategoryID"];
    NSString * ProductID=[self.dict objectForKey:@"ProductID"];
    NSString * img1name=[self.dict objectForKey:@"ImageURL1"] ;
    NSString * img2name=[self.dict objectForKey:@"ImageURL2"];
    NSString * img3name=[self.dict objectForKey:@"ImageURL3"];
    NSString *  txtKH=[self.dict objectForKey:@"CategoryName"];
    NSString *  txtPM=[self.dict objectForKey:@"ProductName"];
    NSString *  txtJG=[self.dict objectForKey:@"Price"];
    NSString *   txtCHSJ=[Tool GetFemate2:[self.dict objectForKey:@"DeliveryTime"]];
    NSString *    txtSDSL=[self.dict objectForKey:@"FirstOrderCount"];
    NSString *    txtFDZQ=[self.dict objectForKey:@"ReorderDays"];
    NSString *   txtDHCC=[self.dict objectForKey:@"BigSize"];
    NSString *   txtSBSJ=[Tool GetFemate2:[self.dict objectForKey:@"GiveSampleDate"]];
    NSString *    txtSBDZ=[self.dict objectForKey:@"Address"];
    NSString *  txtSBLY=[self.dict objectForKey:@"ManagerRemarks"];
    NSString *  txtSJLY=[self.dict objectForKey:@"VendorRemarks"];
    NSString * size=[self.dict objectForKey:@"Size"];
    
    NSString *urlstring=rootimageurl;
    vimg1=[urlstring stringByAppendingFormat:@"%@",img1name];
    vimg2=[urlstring stringByAppendingFormat:@"%@",img2name];
    vimg3=[urlstring stringByAppendingFormat:@"%@",img3name];
    values=[NSArray arrayWithObjects:txtKH,txtKH,txtPM,txtJG,size,txtCHSJ,txtSDSL,txtFDZQ,
            txtSBSJ,txtDHCC,txtSBDZ,txtSBLY,txtSJLY,nil];
    
   
    udict=[[NSMutableDictionary alloc] initWithDictionary:self.dict];

    senddata=[[NSMutableDictionary alloc] initWithDictionary:self.dict];
    
    [senddata setObject:txtCHSJ forKey:@"DeliveryTime"];
    [udict setObject:txtCHSJ forKey:@"DeliveryTime"];
    
    [senddata setObject:txtSBSJ forKey:@"GiveSampleDate"];
     [udict setObject:txtSBSJ forKey:@"GiveSampleDate"];
    
    [senddata setObject:img1name forKey:@"ImageURL1"];
    [senddata setObject:img2name forKey:@"ImageURL2"];
    [senddata setObject:img3name forKey:@"ImageURL3"];
    
    [senddata setObject:ProductID forKey:@"ProductID"];
    [senddata setObject:oldcat forKey:@"catid"];
     [senddata setObject:oldcat forKey:@"oldcatid"];
    // self.dict=nil;
    
}

#pragma mark-初始化类别数据
- (void) initCate
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"GetAllCategories"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCatResult:)];
    [request setDidFailSelector:@selector(getCatErr:)];
    [request startAsynchronous];
}
#pragma mark-类别数据请求结果
- (void) getCatResult:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[[arr objectForKey:@"text"] mutableCopy];
    catdata=[Tool StringTojosn:dictstring];
    
}
- (void) getCatErr:(ASIHTTPRequest *) req
{
    [Tool alert:@"请求类别数据出错，请检查网络"];
}


#pragma mark -初始化地址数据
- (void) initAddr
{
    
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
    [request setDidFinishSelector:@selector(getAddResult:)];
    [request setDidFailSelector:@selector(getAddErr:)];
    [request startAsynchronous];
}
#pragma mark-类别数据请求结果
- (void) getAddResult:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[[arr objectForKey:@"text"] mutableCopy];
    adddata=[Tool StringTojosn:dictstring];
    NSLog(@"adddata****************");
    NSLog(@"%@",adddata);
    
}
- (void) getAddErr:(ASIHTTPRequest *) req
{
    [Tool alert:@"请求地址数据出错，请检查网络"];
}

#pragma mark-初始化类别的码数信息

- (void) initSize:(NSString *)catid
{
    
    NSMutableDictionary * sizeone=[[NSMutableDictionary alloc]init];
    [sizeone setValue:@"S" forKey:@"size"];
    
    NSMutableDictionary * sizetwo=[[NSMutableDictionary alloc]init];
    [sizetwo setValue:@"M" forKey:@"size"];
    NSMutableDictionary * sizethird=[[NSMutableDictionary alloc]init];
    [sizethird setValue:@"L" forKey:@"size"];
    
    NSMutableArray * arr=[[NSMutableArray alloc] initWithObjects:sizeone,sizetwo,sizethird, nil];
    sizedata=arr;
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
#pragma mark-类别码数数据请求结果
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


#pragma mark- 表格代理是需要实现的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 14;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  static  NSString * idtcell=@"cell";
    NSInteger rowindex=[indexPath row] ;
    UITableViewCell * cell=nil;
   // NSLog(@"%d",rowindex);
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section],(long)[indexPath row]];
    
    if (rowindex==0)
    {
        
        ImageChangeTableViewCell * tempcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempcell==nil) {
            tempcell=[[ImageChangeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [tempcell.img1 sd_setImageWithURL:[NSURL URLWithString:vimg1]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [tempcell.img2 sd_setImageWithURL:[NSURL URLWithString:vimg2]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [tempcell.img3 sd_setImageWithURL:[NSURL URLWithString:vimg3]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [tempcell.addbut1 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];
        [tempcell.addbut2 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];
        [tempcell.addbut3 addTarget:self action:@selector(choiceimg:) forControlEvents:UIControlEventTouchUpInside];
        
        cell=tempcell;
    }
    else if (rowindex==1||rowindex==5||rowindex==6||rowindex==9||rowindex==11)
    {
        //static  NSString * labidtcell=@"labcell";
      //  LablebuttonTableViewCell * tempcell=[[LablebuttonTableViewCell alloc] init];
 
         LablebuttonTableViewCell * tempcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (tempcell==nil) {
         tempcell=[[LablebuttonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         }
       
        
        tempcell.key.text=[keys objectAtIndex:rowindex-1];
      //  if (self.dict!=nil) {
           // tempcell.value.text=[values objectAtIndex:rowindex-1];
       // }else{
           tempcell.value.text=[udict objectForKey:[enkeys objectAtIndex:rowindex-1]];
       // }
       
        tempcell.value.tag=999;
      //  if (rowindex==6||rowindex==9) {
           // tempcell.value.text=[Tool GetDate:@"YYYY-MM-dd"];
           //  tempcell.value.text=[Tool GetDate:@"YYYY-MM-dd"];
       // }
        [tempcell.choice setTitle:@"选择" forState:UIControlStateNormal];
        tempcell.choice.tag=rowindex;
        [tempcell.choice addTarget:self action:@selector(choicefunction:) forControlEvents: UIControlEventTouchUpInside];
        
        
        cell=tempcell;
        
        
        
    }
    else if (rowindex==13)
    {
        ButtonTableViewCell * celltemp=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celltemp==nil)
        {
            celltemp=[[ButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [celltemp.left setTitle:@"修改" forState:UIControlStateNormal];
        [celltemp.left setTitle:@"修改" forState:UIControlStateHighlighted];
        [celltemp.left addTarget:self action:@selector(updateProduct:) forControlEvents: UIControlEventTouchUpInside];
        
        [celltemp.right setTitle:@"发送" forState:UIControlStateNormal];
        [celltemp.right setTitle:@"发送" forState:UIControlStateHighlighted];
        [celltemp.right addTarget:self action:@selector(updateState:) forControlEvents: UIControlEventTouchUpInside];
        
        cell=celltemp;
        return cell;

        
    
    }
    else{
        
        // static  NSString * txtidtcell=@"txtcell";
        
        
        TextTableViewCell * tempcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (tempcell==nil)
        {
            tempcell=[[TextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        if ([[keys objectAtIndex:rowindex-1] isEqualToString:@"翻单周期"])
        {
            tempcell.choice.hidden=NO;
            tempcell.choice.backgroundColor=[UIColor clearColor];
            [tempcell.choice setTitle:@"天" forState:UIControlStateNormal];
            [tempcell.choice setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [tempcell.choice setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        }
        
        
        tempcell.key.text=[keys objectAtIndex:rowindex-1];
       // if (self.dict!=nil) {
          //  tempcell.value.text=[values objectAtIndex:rowindex-1];
       // }else{
            tempcell.value.text=[udict objectForKey:[enkeys objectAtIndex:rowindex-1]];
       // }
        tempcell.value.delegate=self;
        tempcell.value.tag=rowindex;
        [tempcell.value addTarget:self action:@selector(textFieldDidEndEditing:)  forControlEvents:UIControlEventEditingDidEndOnExit];
        [tempcell.value addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        
        
        
        cell=tempcell;
    }
    
    
    
    
    
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >=7.0) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==0)
    {
        return 71;
    }
    else
    {
        return 44;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark-选择功能的实现
- (void) choicefunction:(UIButton *)btn
{
    
    UITableViewCell *tcell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tcell];
    
    LablebuttonTableViewCell * cell=(LablebuttonTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UILabel * lab=(UILabel*)[cell viewWithTag:999];
    changevaule=lab;
    
    switch (btn.tag)
    {
        case 1:
         //   NSLog(@"1->%d",btn.tag);
            //弹出类别选择器
            [self startCateDialog];
            
            break;
        case 5:
            //弹出类别选择器
           // NSLog(@"2->%d",btn.tag);
            [self startSizeDialog];
            break;
        case 6:
        {
            //弹出时间选择器
            dataindex=1;
            [self startDateDialog];
            
            
        }
            break;
        case 9:
        {
            //弹出时间选择器
            dataindex=2;
            [self startDateDialog];
            
        }
            break;
        case 11:
            //弹出地址选择器
           // NSLog(@"5->%d",btn.tag);
            [self startAddreDialog];
            break;
        default:
            break;
    }
    
    
}
#pragma mark-初始化时间选择器
-(void)startDateDialog {
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet *dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                            delegate:(id)self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"选择",
                                 nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog showInView:self.view];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    dateDialog.tag=102;
    datePicker.tag = 101;
    [dateDialog addSubview:datePicker];
    
}

#pragma mark-初始化地址选择器

- (void) startAddreDialog{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet * dateDialog1 = [[UIActionSheet alloc] initWithTitle:title
                                                              delegate:(id)self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"选择",
                                   nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog1 showInView:self.view];
    UIPickerView *datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource=self;
    datePicker.delegate=self;
    dateDialog1.tag=106;
    datePicker.tag = 105;
    [dateDialog1 addSubview:datePicker];
}


#pragma mark-初始化类别选择器

- (void) startCateDialog{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet * dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:(id)self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"选择",
                                  nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog showInView:self.view];
    UIPickerView *datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource=self;
    datePicker.delegate=self;
    dateDialog.tag=104;
    datePicker.tag = 103;
    [dateDialog addSubview:datePicker];
}

#pragma mark-初始化码数选择器
- (void) startSizeDialog{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet * dateDialog = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:(id)self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"选择",@"回退",
                                  nil];
    // dateDialog.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    [dateDialog showInView:self.view];
    UIPickerView *datePicker = [[UIPickerView alloc] init];
    datePicker.dataSource=self;
    datePicker.delegate=self;
    dateDialog.tag=108;
    datePicker.tag = 107;
    [dateDialog addSubview:datePicker];
}

#pragma mark-uipickview的代理实现
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //地址
    if (pickerView.tag==105)
    {
        return [adddata count];
    }
    //类别
    else if(pickerView.tag==103)
    {
        return [catdata count];
    }
    //码数
    else
    {
        return [sizedata count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //地址
    if (pickerView.tag==105)
    {
        return [[adddata objectAtIndex:row]  objectForKey:@"Address"];
    }
    //类别
    else if(pickerView.tag==103)
    {
        return [[catdata objectAtIndex:row]  objectForKey:@"CategoryName"];
    }
    //码数
    else
    {
        return [[sizedata objectAtIndex:row]  objectForKey:@"size"];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSLog(@"%ld",(long)row);
}

#pragma mark-sheet回调

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //选择时间
    if (actionSheet.tag == 102)
    {
        UIDatePicker *datePicker = (UIDatePicker *)[actionSheet viewWithTag:101];
        NSDate *date = [datePicker date];
      //  NSLog(@"%d",buttonIndex);
        
        if (buttonIndex==0)
        {
            NSDateFormatter * dateformat=[[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"YYYY-MM-dd"];
            switch (dataindex)
            {
                case 1:
                    changevaule.text=[dateformat stringFromDate:date];
                    [senddata setObject:[dateformat stringFromDate:date] forKey:@"DeliveryTime"];
                    [udict setObject:[dateformat stringFromDate:date] forKey:@"DeliveryTime"];
                   
                    break;
                default:
                    changevaule.text=[dateformat stringFromDate:date];
                    [senddata setObject:[dateformat stringFromDate:date] forKey:@"GiveSampleDate"];
                     [udict setObject:[dateformat stringFromDate:date] forKey:@"GiveSampleDate"];
                    break;
            }
            
        }
        
    }
    
    //获取选择的类别
    if (actionSheet.tag == 104)
    {
        
        UIPickerView *datePicker = (UIPickerView *)[actionSheet viewWithTag:103];
        
        NSInteger selecom1=[datePicker selectedRowInComponent:0];
        
        if (buttonIndex==0)
        {
            NSString * prov=[[catdata  objectAtIndex:selecom1] objectForKey:@"CategoryName"];
            NSString * catid=[[catdata  objectAtIndex:selecom1] objectForKey:@"CategoryID"];
            changevaule.text=prov;
            [senddata setObject:catid forKey:@"catid"];
            [senddata setObject:prov forKey:@"CategoryName"];
            [udict setObject:prov forKey:@"CategoryName"];
            [self initSize:catid];
            
        }
    }
    
    //获取选择的地址
    if (actionSheet.tag == 106)
    {
        UIPickerView *datePicker = (UIPickerView *)[actionSheet viewWithTag:105];
        NSInteger selecom1=[datePicker selectedRowInComponent:0];
        
        if (buttonIndex==0)
        {
            NSString * prov=[[adddata  objectAtIndex:selecom1] objectForKey:@"Address"];
            NSString * Addid=[[adddata  objectAtIndex:selecom1] objectForKey:@"AddressID"];
            changevaule.text=prov;
            [senddata setObject:Addid forKey:@"GiveSampleAddressID"];
            [senddata setObject:prov forKey:@"Address"];
            [udict setObject:prov forKey:@"Address"];
            
        }
    }
    
    //获取选择的地址
    if (actionSheet.tag == 108)
    {
        UIPickerView *datePicker = (UIPickerView *)[actionSheet viewWithTag:107];
        NSInteger selecom1=[datePicker selectedRowInComponent:0];
      //  NSLog(@"%d",buttonIndex);
        if (buttonIndex==0)
        {
            NSString * size=[[sizedata  objectAtIndex:selecom1] objectForKey:@"size"];
            NSString * va=changevaule.text;
            if (va!=nil)
            {
                va = [va stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if ([va rangeOfString:size].location ==NSNotFound)
                {
                    changevaule.text=[changevaule.text stringByAppendingFormat:@"-%@",size];
                    
                }
                
            }
            else
            {
                changevaule.text=size;
                
            }
            
            [senddata setObject:size forKey:@"Size"];
            [udict setObject:size forKey:@"Size"];
            
            
        }
        else if(buttonIndex==1)
        {
            NSString * va=changevaule.text;
            if (va!=nil)
            {
                NSInteger len=va.length;
                if (len>2)
                {
                    changevaule.text=[ va substringToIndex:len-2];
                    [senddata setObject:changevaule.text forKey:@"Size"];
                    [udict setObject:changevaule.text forKey:@"Size"];
                }
                else
                {
                    changevaule.text=@"";
                }
                
            }
            
            
        }
    }
    
    //选择图片
    if (actionSheet.tag == 255)
    {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
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
        else
        {
            if (buttonIndex == 0)
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else
            {
                return;
            }
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = (id)self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    
    
}


#pragma mark- 选择图片
- (void)choiceimg:(UIButton *) btn
{
    UITableViewCell *tcell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tcell];
    ImageChangeTableViewCell * cell=(ImageChangeTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView * img=(UIImageView*)[cell viewWithTag:btn.tag*2];
    choiceimage=img;
    [self imagefromwhere];
    
    
}

#pragma mark-图片源函数
- (void) imagefromwhere
{
    UIActionSheet * action;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        action  =  [[UIActionSheet alloc]initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    }
    else
    {
        
        action =  [[UIActionSheet alloc]initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
    }
    
    action.tag = 255;
    action.actionSheetStyle=UIActionSheetStyleAutomatic;
    [action showInView:self.view];
}
#pragma mark -图片设置到控件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    choiceimage.image=image;
    int index=(int)choiceimage.tag/200;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    
    NSString * imagetty=[Tool Append:@"imagename" witnstring:[Tool intToString:index]];
    NSString *imagenamekey=[Tool Append:@"ImageURL" witnstring:[Tool intToString:index]];
    NSString *imagenamevaule=[Tool Append:@"imagenamedata" witnstring:[Tool intToString:index]];
    NSString *imagename=[[Tool GetOnlyString] stringByAppendingString:@".jpg"];
    [senddata setObject:imagename forKey:imagetty];

    imagename= [username stringByAppendingFormat:@"/%@",imagename];
    NSData * dataimg= UIImageJPEGRepresentation(image, 1.0);
    NSString * datastring1=[Tool NSdatatoBSString:dataimg];//压缩编码发送
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


# pragma mark-键盘回收

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    // CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
}



#pragma mark-保存输入的值

- (void)textFieldWithText:(UITextField *) text
{
    
    switch (text.tag)
    {
        case 2:
            [senddata setObject:text.text forKey:@"ProductNumber"];
            [udict setObject:text.text forKey:@"ProductNumber"];
            break;
        case 3:
            [senddata setObject:text.text forKey:@"ProductName"];
             [udict setObject:text.text forKey:@"ProductName"];
            break;
        case 4:
            [senddata setObject:text.text forKey:@"Price"];
            [udict setObject:text.text forKey:@"Price"];
            break;
        case 7:
            [senddata setObject:text.text forKey:@"FirstOrderCount"];
             [udict setObject:text.text forKey:@"FirstOrderCount"];
            break;
        case 8:
            [senddata setObject:text.text forKey:@"ReorderDays"];
             [udict setObject:text.text forKey:@"ReorderDays"];
            break;
        case 10:
            [senddata setObject:text.text forKey:@"BigSize"];
            [udict setObject:text.text forKey:@"BigSize"];
            
            break;
        case 12:
            [senddata setObject:text.text forKey:@"VendorRemarks"];
            [udict setObject:text.text forKey:@"VendorRemarks"];

            
            break;
        default:
            break;
    }
    
}

#pragma mark-修改
- (void) updateProduct:(UIButton *)btn
{
    NSLog(@"修改");
    [self uvpdateProduct:@"0"];
    
    
}
#pragma mark-发送
- (void) updateState:(UIButton *)btn
{
    NSLog(@"发送");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
   
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"UpdateProductstate"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:[senddata objectForKey:@"ProductID"] forKey:@"productid"];
    [request setPostValue: @"1" forKey:@"state"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(updatestateProductResult:)];
    [request setDidFailSelector:@selector(updatestateproductErr:)];
    [request startAsynchronous];

    
}


- (void) uvpdateProduct:(NSString *) vstate
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
    NSString *UserID = [defaults valueForKey:@"UserID"];
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"UploadImage3"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
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
    
    NSError *error = [request error];
    if (!error)
    {
        NSString *responseString = [request responseString];
        
        NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
        NSString * dictstring=[arr objectForKey:@"text"];
        NSDictionary * vdict=[Tool StringTojosn:dictstring];
        if(vdict)
        {
            NSString * state=[vdict objectForKey:@"state"];
            if([state isEqual:@"1"])
            {
                
                //添加产品表数据
                NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"UpdateProductT"];
                NSURL *myurl = [NSURL URLWithString:strurl];
                ASIFormDataRequest *addproduct = [ASIFormDataRequest requestWithURL:myurl];
                NSString * ImageURL1= [senddata objectForKey:@"ImageURL1"];
                NSString * ImageURL2=[senddata objectForKey:@"ImageURL2"];
                NSString * ImageURL3=[senddata objectForKey:@"ImageURL3"];
                [addproduct setPostValue:[senddata objectForKey:@"ProductID"] forKey:@"ProductID"];
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
                [addproduct setPostValue: ImageURL1 forKey:@"ImageURL1"];
                [addproduct setPostValue: ImageURL2 forKey:@"ImageURL2"];
                [addproduct setPostValue: ImageURL3 forKey:@"ImageURL3"];
                [addproduct setPostValue: @"" forKey:@"ImageURL4"];
                [addproduct setPostValue: @"" forKey:@"Discription"];
                
                [addproduct setPostValue: [senddata objectForKey:@"catid"] forKey:@"catid"];
                [addproduct setPostValue: [senddata objectForKey:@"oldcatid"] forKey:@"oldcatid"];
                [addproduct setPostValue:username forKey:@"username"];
                [addproduct setPostValue:password forKey:@"password"];
                [addproduct setDelegate:self];
                [addproduct setDidFinishSelector:@selector(updateProductResult:)];
                [addproduct setDidFailSelector:@selector(updateproductErr:)];
                [addproduct startAsynchronous];
            }
            else
            {
                [Tool alert:@"执行修改操作失败，请重试！"];
            }
            
            
        }
        else
        {
            [Tool alert:@"发生未知错误!1"];
        }
        
        
        
    }
    else
    {
        [Tool alert:@"请检查您的网络"];
        
    }
    
}

//添加产品的网络代理
- (void) updateProductResult:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[[arr objectForKey:@"text"] mutableCopy];
    NSDictionary * vdict=[Tool StringTojosn:dictstring];
    if(vdict){
        NSString * state=[vdict objectForKey:@"state"];
        if([state isEqual:@"1"])
        {
            [Tool alert:@"修改成功"];
            [self.navigationController popViewControllerAnimated:NO];
        }
        else
        {
            [Tool alert:@"新建失败，请重试！"];
        }
        
        
    }else{
        [Tool alert:@"发生未知错误!2"];
    }
    
}
- (void) updateproductErr:(ASIHTTPRequest *) req
{
    [Tool alert:@"请求类别数据出错，请检查网络"];
}

//添加产品的网络代理
- (void) updatestateProductResult:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[[arr objectForKey:@"text"] mutableCopy];
    NSDictionary * vdict=[Tool StringTojosn:dictstring];
    if(vdict){
        NSString * state=[vdict objectForKey:@"state"];
        if([state isEqual:@"1"])
        {
            [Tool alert:@"发送成功"];
            self.tabBarController.selectedIndex=0;
        }
        else
        {
            [Tool alert:@"新建失败，请重试！"];
        }
        
        
    }else{
        [Tool alert:@"发生未知错误!2"];
    }
    
}
- (void) updatestateproductErr:(ASIHTTPRequest *) req
{
    [Tool alert:@"请求类别数据出错，请检查网络"];
}




/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
