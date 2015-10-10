//
//  DetailViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageNotChangeTableViewCell.h"
#import "LableTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()
{
    
    UITableView * tableview;
    NSArray * keys;
    NSArray * values;
    NSString * img1;
    NSString * img2;
    NSString * img3;
    UIView *background;
    
   // NSMutableArray* data;
   // UIRefreshControl* refreshControl;
    //UIView *background;
}
- (void) initTableview;
- (void) initData;

@end

@implementation DetailViewController

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
    self.navigationItem.title=@"详情";
    [self initData];
    [self initTableview];
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
    NSString *urlstring=rootimageurl;
    img1=[urlstring stringByAppendingFormat:@"%@",img1name];
    img2=[urlstring stringByAppendingFormat:@"%@",img2name];
    img3=[urlstring stringByAppendingFormat:@"%@",img3name];
    keys=[NSArray arrayWithObjects:@"款号",@"品名",@"价格",@"码数",@"出货时间",@"首单数量"
                    ,@"翻单周期",@"送版时间",@"大货尺寸",@"送版地址",@"送版留言",@"商家留言",nil];
    values=[NSArray arrayWithObjects:txtKH,txtPM,txtJG,size,txtCHSJ,txtSDSL,txtFDZQ,
                                    txtSBSJ,txtDHCC,txtSBDZ,txtSBLY,txtSJLY,nil];
   
}


#pragma mark- 表格代理是需要实现的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return keys.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static  NSString * idtcell=@"cell";
   NSInteger rowindex=[indexPath row] ;
    UITableViewCell * cell;
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    if (rowindex==0) {
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
        celltemp.img1.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
        [celltemp.img2 addGestureRecognizer:singleTap2];
        
        [celltemp.img3 sd_setImageWithURL:[NSURL URLWithString:img3]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
         celltemp.img3.tag=3;
        celltemp.img1.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
        [celltemp.img3 addGestureRecognizer:singleTap3];
        
        cell=celltemp;
        
    }
    else
    {
        LableTableViewCell * celltemp=[tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (celltemp==nil)
        {
            celltemp=[[LableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if ([[keys objectAtIndex:rowindex-1] isEqualToString:@"翻单周期"]) {
            celltemp.unit.hidden=NO;
            celltemp.unit.text=@"天";
        }
        celltemp.key.text=[keys objectAtIndex:rowindex-1];
        celltemp.value.text=[values objectAtIndex:rowindex-1];
        cell=celltemp;
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
    }else
    {
     return 44;
    }
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
