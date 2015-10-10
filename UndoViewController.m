//
//  UndoViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "UndoViewController.h"
#import "UndoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "DetailViewController.h"

@interface UndoViewController ()
{
    
    UITableView * tableview;
    NSMutableArray* data;
    UIRefreshControl* refreshControl;
    UIView *background;
}
- (void) initTableview;
- (void)initDataResult:(ASIHTTPRequest *) req;
- (void)initDataErr:(ASIHTTPRequest *) req;
-(void) refreshView:(UIRefreshControl *)refresh;

@end

@implementation UndoViewController

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
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.navigationItem.title=@"待审";
   
    [self initData];
    [self initTableview];
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear:(BOOL)animated
{
    [self initData];
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
    
    
    //初始化刷新事件
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                        action:@selector(refreshView:)
              forControlEvents:UIControlEventValueChanged];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Loading...."]];
    [tableview addSubview:refreshControl];
    
}

#pragma  mark-下拉刷新
-(void) refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refresh..."];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Done"];
    [self initData];
    [refresh endRefreshing];
}



#pragma mark- 初始化数据
- (void) initData
{
    NSLog(@"待审初始化数据");

    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults valueForKey:@"UserName"];
    NSString *password = [defaults valueForKey:@"Password"];
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"GetProductByUserAndUnaudit"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
   
    //设置表单提交项
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(initDataResult:)];
    [request setDidFailSelector:@selector(initDataErr:)];
    [request startAsynchronous];
}






- (void)initDataResult:(ASIHTTPRequest *) req
{
    // Use when fetching text data
    NSLog(@"请求数据成功");
    NSString *responseString = [req responseString];
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[arr objectForKey:@"text"];
    data=[Tool StringTojosn:dictstring];
    if (data.count>0) {
        [tableview reloadData];
    }
   
    // Use when fetching binary data
    // NSData *responseData = [request responseData];
    
}
- (void)initDataErr:(ASIHTTPRequest *) req
{
    NSLog(@"请求数据失败");
    data=nil;
    // NSError *error = [req error];
    
  //  msg.text=@"登录出错，请检查您的网络";
    
}


#pragma mark- 表格代理是需要实现的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count=0;
    count=[data count];
    if (count) {
        return count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * idtcell=@"cell";
    UndoTableViewCell * cell=[tableview dequeueReusableCellWithIdentifier:idtcell];
    if (cell==nil) {
        cell=[[UndoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idtcell];
    }
    
    if(data!=nil)
    {
        
        NSDictionary * dict=[data objectAtIndex:[indexPath row]];
        
        NSString * ProductName=[dict objectForKey:@"ProductName"];
        NSString * Price=[dict objectForKey:@"Price"];
        NSString * ImageURL1=[dict objectForKey:@"ImageURL1"];
        NSString * urlstring=rootsmallimageurl;
        //[[NSString alloc] initWithString:defaultWebServiceUrl];
        urlstring=[urlstring stringByAppendingFormat:@"%@",ImageURL1];
        [cell.productimage sd_setImageWithURL:[NSURL URLWithString:urlstring]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.productimage.userInteractionEnabled = YES;
        cell.productimage.tag=[indexPath row];
        //添加手试
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fangda:)] ;
        [cell.productimage addGestureRecognizer:singleTap];
        
        
        cell.name.text=ProductName;
        cell.price.text=[Price substringToIndex:Price.length-2];
    }
     cell.accessoryType=UITableViewCellAccessoryDetailButton;
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >=7.0) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

//选择行事件

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // CanNotChangeViewController *controller = [[CanNotChangeViewController alloc]initWithNibName:@"CanNotChangeViewController" bundle:nil];
    DetailViewController *Cannotview=[[DetailViewController alloc] init];
    Cannotview.dict=[data objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:Cannotview animated:NO];
}


#pragma mark- 图片缩放
- (void)fangda:(UITapGestureRecognizer *) pic
{
    
    
    UIView *temView = [pic view];
    NSInteger temIndex = temView.tag;
    NSDictionary * dict=[data objectAtIndex:temIndex];
    NSString * ImageURL1=[dict objectForKey:@"ImageURL1"];
    NSString * urlstring=rootimageurl;
    //[[NSString alloc] initWithString:defaultWebServiceUrl];
    urlstring=[urlstring stringByAppendingFormat:@"%@",ImageURL1];
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
    [imgView sd_setImageWithURL:[NSURL URLWithString:urlstring]
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
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
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
