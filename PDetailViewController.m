//
//  PDetailViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "PDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ImageNotChangeTableViewCell.h"
#import "LableTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "TextTableViewCell.h"
#import "ButtonTableViewCell.h"


@interface PDetailViewController ()
{
    
    UITableView * tableview;
    NSArray * keys;
    NSArray * values;
    NSString * img1;
    NSString * img2;
    NSString * img3;
    UIView *background;
    NSMutableDictionary * senddata;
    
    NSArray * userinfokeys;
    NSArray * userinfovalues;
    
    // NSMutableArray* data;
    //UIRefreshControl* refreshControl;
    //UIView *background;
}
- (void) initTableview;
- (void) initData;
@end

@implementation PDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    [self initData];
    [self initTableview];
    //监听键盘事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 初始化页面控件
- (void) initTableview
{
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
}

- (void) initData
{
    
    NSString * img1name=[self.dict objectForKey:@"ImageURL1"] ;
    NSString * img2name=[self.dict objectForKey:@"ImageURL2"];
    NSString * img3name=[self.dict objectForKey:@"ImageURL3"];
    NSString *  txtKH=[self.dict objectForKey:@"CategoryName"];
    NSString *  txtPM=[self.dict objectForKey:@"ProductName"];
    NSString *  txtJG=[self.dict objectForKey:@"Price"];
    NSString *   txtCHSJ=[Tool GetFemate:[self.dict objectForKey:@"DeliveryTime"]];
    NSString *    txtSDSL=[self.dict objectForKey:@"FirstOrderCount"];
    NSString *    txtFDZQ=[self.dict objectForKey:@"ReorderDays"];
    NSString *   txtDHCC=[self.dict objectForKey:@"BigSize"];
    NSString *   txtSBSJ=[Tool GetFemate:[self.dict objectForKey:@"GiveSampleDate"]];
    NSString *    txtSBDZ=[self.dict objectForKey:@"Address"];
    NSString *  txtSBLY=[self.dict objectForKey:@"VendorRemarks"];
    NSString *  txtSJLY=[self.dict objectForKey:@"ManagerRemarks"];
    NSString * size=[self.dict objectForKey:@"Size"];
    
    
    NSString * firstname=[self.dict objectForKey:@"FirstName"];
    NSString * lastname=[self.dict objectForKey:@"LastName"];
    NSString * email=[self.dict objectForKey:@"Email"];
    NSString * phone=[self.dict objectForKey:@"Phone"];
    NSString * name=[Tool Append:firstname witnstring:lastname];
    
    NSString *urlstring=rootimageurl;
    img1=[urlstring stringByAppendingFormat:@"%@",img1name];
    img2=[urlstring stringByAppendingFormat:@"%@",img2name];
    img3=[urlstring stringByAppendingFormat:@"%@",img3name];
    keys=[NSArray arrayWithObjects:@"款号",@"品名",@"价格",@"码数",@"出货时间",@"首单数量"
          ,@"翻单周期",@"送版时间",@"大货尺寸",@"送版地址",@"送版留言",@"商家留言",nil];
    values=[NSArray arrayWithObjects:txtKH,txtPM,txtJG,size,txtCHSJ,txtSDSL,txtFDZQ,
            txtSBSJ,txtDHCC,txtSBDZ,txtSBLY,txtSJLY,nil];
    userinfokeys=[NSArray arrayWithObjects:@"姓名",@"联系电话",@"联系邮箱",nil];
    userinfovalues=[NSArray arrayWithObjects:name,phone,email,nil];
    
    
    senddata=[[NSMutableDictionary alloc] init];
    
}


#pragma mark- 表格代理是需要实现的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return userinfokeys.count;
    }
    else
    {   if(self.opreat==1)
        {
           return keys.count+2;
        }else{
          return keys.count+1;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * idtcell=@"cell";
    NSInteger rowindex=[indexPath row] ;
    UITableViewCell * cell=nil;
   // NSLog(@"%d",rowindex);
    
   NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];

   if (indexPath.section==0)
    {
        LableTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celltemp==nil)
        {
            celltemp=[[LableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        celltemp.key.text=[userinfokeys objectAtIndex:rowindex];
        celltemp.value.text=[userinfovalues objectAtIndex:rowindex];
        cell=celltemp;

        
    }
    else
    {
        if (rowindex==0)
        {
            ImageNotChangeTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:CellIdentifier];
            if (celltemp==nil)
            {
                celltemp=[[ImageNotChangeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            [celltemp.img1 sd_setImageWithURL:[NSURL URLWithString:img1]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            celltemp.img1.tag=1;
            celltemp.img1.userInteractionEnabled=YES;
            UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
            [celltemp.img1 addGestureRecognizer:singleTap1];
            
            
            [celltemp.img2 sd_setImageWithURL:[NSURL URLWithString:img2]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            celltemp.img2.tag=2;
            celltemp.img2.userInteractionEnabled=YES;
            UITapGestureRecognizer *singleTap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
            [celltemp.img2 addGestureRecognizer:singleTap2];
            
            [celltemp.img3 sd_setImageWithURL:[NSURL URLWithString:img3]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            celltemp.img3.tag=3;
            celltemp.img3.userInteractionEnabled=YES;
            UITapGestureRecognizer *singleTap3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
            [celltemp.img3 addGestureRecognizer:singleTap3];
            
            cell=celltemp;
            
        }
        else if(self.opreat==1 && rowindex==keys.count) //添加留言
        {
            TextTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:CellIdentifier];
            if (celltemp==nil)
            {
                celltemp=[[TextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
            }
            
            celltemp.key.text=[keys objectAtIndex:rowindex-1];
            celltemp.value.text=@"";
            celltemp.value.delegate=self;
            celltemp.value.tag=rowindex;
            [celltemp.value addTarget:self action:@selector(textFieldDidEndEditing:)  forControlEvents:UIControlEventEditingDidEndOnExit];
            [celltemp.value addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
            
            
            cell=celltemp;
            return cell;

            
        }
        else if(self.opreat==1 && rowindex==keys.count+1)//添加操作按钮
        {
            
            ButtonTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:CellIdentifier];
            if (celltemp==nil)
            {
                celltemp=[[ButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            [celltemp.left setTitle:@"同意" forState:UIControlStateNormal];
            [celltemp.left setTitle:@"同意" forState:UIControlStateHighlighted];
            [celltemp.left addTarget:self action:@selector(agree:) forControlEvents: UIControlEventTouchUpInside];
            
            [celltemp.right setTitle:@"不同意" forState:UIControlStateNormal];
            [celltemp.right setTitle:@"不同意" forState:UIControlStateHighlighted];
            [celltemp.right addTarget:self action:@selector(disagee:) forControlEvents: UIControlEventTouchUpInside];
          
            cell=celltemp;
            return cell;
        }
        else
        {
                LableTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:idtcell];
                if (celltemp==nil)
                {
                    celltemp=[[LableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idtcell];
                }
                
                if ([[keys objectAtIndex:rowindex-1] isEqualToString:@"翻单周期"]) {
                    celltemp.unit.hidden=NO;
                    celltemp.unit.text=@"天";
                }
                celltemp.key.text=[keys objectAtIndex:rowindex-1];
                celltemp.value.text=[values objectAtIndex:rowindex-1];
                cell=celltemp;
        }

    
    }
    
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >=7.0)
    {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"联系信息";
    }
    else
    {
     return @"送版详情";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath section] && [indexPath row]==0)
    {
        return 71;
    }else
    {
        return 44;
    }
}

#pragma mark-审核执行
- (void) agree:(UIButton *)btn
{
     NSLog(@"同意");
    [self sendAuditData:@"3"];
}
- (void) disagee:(UIButton *)btn
{
     NSLog(@"不同意");
    [self sendAuditData:@"2"];
}

- (void) sendAuditData:(NSString *) state
{
    NSString  * vendorRemarks=[senddata objectForKey:@"ManagerRemarks"];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
    NSString * productid=[self.dict objectForKey:@"ProductID"];
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"UpdateProductstateAndVendorRemarks"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:productid forKey:@"productid"];
    [request setPostValue:state forKey:@"state"];
    [request setPostValue:vendorRemarks forKey:@"vendorRemarks"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(doAuditResult:)];
    [request setDidFailSelector:@selector(doAuditErr:)];
    [request startAsynchronous];

}

#pragma mark -审核数据返回
- (void) doAuditResult:(ASIHTTPRequest *) req
{
    // Use when fetching text data
    NSString *responseString = [req responseString];
    
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[arr objectForKey:@"text"];
    NSDictionary * dict=[Tool StringTojosn:dictstring];
    if(dict){
        NSString * state=[dict objectForKey:@"state"];
        if([state isEqual:@"1"])
        {
             [Tool alert:@"执行审核成功"];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
        else
        {
             [Tool alert:@"执行审核操作失败，请重试！"];
        }
        
        
    }else{
        [Tool alert:@"发生未知错误!"];
    }
    
    
    
    // Use when fetching binary data
    // NSData *responseData = [request responseData];
    
}
- (void)doAuditErr:(ASIHTTPRequest *) req
{
    // NSError *error = [req error];
     [Tool alert:@"审核出错，请检查您的网络"];
    
    
}


#pragma mark- 图片缩放
- (void)fangda:(UITapGestureRecognizer *) pic
{
    UIView *temView = [pic view];
    NSString * ImageURL1;
    NSInteger temIndex = temView.tag;
    if(temIndex==1)
    {
        ImageURL1=img1;
    }
    if(temIndex==2)
    {
        ImageURL1=img2;
    }
    if(temIndex==3)
    {
        ImageURL1=img3;
    }
    //创建灰色透明背景，使其背后内容不可操作
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                               green:0.3
                                                blue:0.3
                                               alpha:0.7]];
    [tableview addSubview:bgView];
    //创建边框视图
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,BIG_IMG_WIDTH+16, BIG_IMG_HEIGHT+16)];
    //将图层的边框设置为圆脚
    borderView.layer.cornerRadius = 8;
    borderView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    borderView.layer.borderWidth = 8;
    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                    green:0.9
                                                     blue:0.9
                                                    alpha:0.7]CGColor];
    [borderView setCenter:bgView.center];
    [bgView addSubview:borderView];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH, BIG_IMG_HEIGHT )];
    [imgView sd_setImageWithURL:[NSURL URLWithString:ImageURL1]
               placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    imgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suoxiao)];
    [imgView addGestureRecognizer:singleTap];
    [borderView addSubview:imgView];
    [self shakeToShow:borderView];//放大过程中的动画
    //动画效果
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView setAnimationDelegate:bgView];
    // 动画完毕后调用animationFinished
    //  [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)suoxiao
{
    [background removeFromSuperview];
}
//*************放大过程中出现的缓慢动画*************
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    //NSMutableArray *values = [NSMutableArray array];
    // [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    // [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    // animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


# pragma mark-键盘回收

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    // CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:0.2 animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0); // 这里是以每一次计算是以最开始的状态来的,所以键盘隐藏是应该是(0,0)
    }];
  
}



- (void)keyBoardWillChangeFrame:(NSNotification *)note;
{
    // 动画过程中会出现小黑框是窗口的颜色,所以需要改变
    self.view.window.backgroundColor = self.view.backgroundColor;
    
    // 取出动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 取得键盘最后的frame和键盘开始的frame
    CGRect keyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 计算移动的距离
    
    CGFloat moveY = keyboardEndFrame.origin.y - self.view.bounds.size.height;
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY); // 这里是以每一次计算是以最开始的状态来的,所以键盘隐藏是应该是(0,0)
    }];
}


#pragma mark-保存输入的值

- (void)textFieldWithText:(UITextField *) text
{
    
    switch (text.tag)
    {
        case 12:
            [senddata setObject:text.text forKey:@"ManagerRemarks"];
            break;
        default:
            break;
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

@end
