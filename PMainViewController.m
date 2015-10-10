//
//  PMainViewController.m
//  RAJSupply
//
//  Created by apple on 14-9-20.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "PMainViewController.h"
#import "UntreatedViewController.h"
#import "TreatedViewController.h"

@interface PMainViewController ()
- (void)creatControls;
- (void)creatTabBar;
@end

@implementation PMainViewController

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
    //self.tabBar.hidden=YES;
    [self creatControls];
  //  [self creatTabBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatTabBar
{
    UIImageView * bgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-49, [[UIScreen mainScreen] bounds].size.width, 49)];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.tag=520;
    [self.view addSubview:bgView];
    bgView.userInteractionEnabled=YES;
    
    CGFloat space=([[UIScreen mainScreen] bounds].size.width-2*30)/(2+1);
    NSArray * name=[NSArray arrayWithObjects:@"待审",@"已审", nil];
    for (int i=0; i<2; i++)
    {
        
        NSString * iamgename=[NSString stringWithFormat:@"tab_%d.png",i];
        NSString * iamgenameS=[NSString stringWithFormat:@"tabS_%d.png",i];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:iamgename] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:iamgenameS] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        
        [btn setFrame:CGRectMake(space+(space+30)*i, 3, 30, 30)];
        [bgView addSubview:btn];
        
        UILabel * lab=[[UILabel alloc] init];
        lab.text=[name objectAtIndex:i];
        lab.font = [UIFont systemFontOfSize:10];//采用系统默认文字设置大小
        lab.textAlignment = NSTextAlignmentCenter;
        // lab.font = [UIFont fontWithName:@"Arial" size:30];
        lab.textColor=[UIColor whiteColor];
        lab.tag=(i+1)*10;
        [lab setFrame:CGRectMake(space+(space+30)*i, 37, 30, 11)];
        [bgView addSubview:lab];
        /*  if (i==0) {
         btn.selected=YES;
         lab.textColor=[UIColor grayColor];
         }
         */
    }
    UILabel * labt=[[UILabel alloc] init];
    labt.tag=999;
    [labt setBackgroundColor:[UIColor redColor]];
    [labt setFrame:CGRectMake(space, 48, 30, 2)];
    [bgView addSubview:labt];
    
    
    
}

- (void) btnSelect:(UIButton *)btn
{
    self.selectedIndex=btn.tag;
    UIImageView *bagview=(UIImageView *)[self.view viewWithTag:520];
    for (UIView * subview in bagview.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            UIButton * btn1=(UIButton *)subview;
            //UILabel *lab1=(UILabel *)[self.view viewWithTag:(btn1.tag+1)*10];
            // lab1.textColor=[UIColor whiteColor];
            if(btn.tag==btn1.tag)
            {
                btn1.selected=YES;
                
                //  lab1.textColor=[UIColor grayColor];
                
            }
            else
            {
                btn1.selected=NO;
                
                
            }
        }
        
        
    }
    
    CGFloat space=([[UIScreen mainScreen] bounds].size.width-2*30)/(2+1);
    UILabel * golabe=(UILabel *)[bagview viewWithTag:999];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect  fram=golabe.frame;
        fram.origin.x=space+btn.tag*(space+30);
        golabe.frame=fram;
        
    }];
    
    
    
}
//将试图控制器添加到tabbar上面
- (void)creatControls
{
    UntreatedViewController * firstview=[[UntreatedViewController alloc] init];
    firstview.tabBarItem.image=[UIImage imageNamed:@"tab_0.png"];
    firstview.tabBarItem.title=@"待审";
    
    UINavigationController * nvifirst=[[UINavigationController alloc] init];
    [nvifirst addChildViewController:firstview];
    
    TreatedViewController * secondview=[[TreatedViewController alloc]init];
    secondview.tabBarItem.image=[UIImage imageNamed:@"tab_1.png"];
    secondview.tabBarItem.title=@"已审";
    UINavigationController * nvisecond=[[UINavigationController alloc] init];
    [nvisecond addChildViewController:secondview];
    
    
    
    NSArray * controls=[NSArray arrayWithObjects:nvifirst,nvisecond, nil];
    
    self.viewControllers=controls;
    
    
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
