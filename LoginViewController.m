//
//  LoginViewController.m
//  JustCode
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "PMainViewController.h"
#import "AppHelper.h"
//#import "MyKeyChainHelper.h"


@interface LoginViewController ()
{
    UILabel * lbusername;
    UILabel * lbpassword;
    UITextField * txtusername;
    UITextField * txtpassword;
    UILabel * msg;
    UILabel * mima;
    UISwitch * swith;
    UIButton * btnLogin;
}

- (void) initInterface;
- (void) Login:(UIButton *)btn;
- (void)isSave;
@end

BOOL issave=YES;
NSString * const KEY_USERNAME = @"cn.rspread.app.username";
NSString * const KEY_PASSWORD = @"cn.rspread.app.password";

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark- 界面控件初始化
- (void)initInterface
{
    //用户名提示
    lbusername=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 51, 21)];
    lbusername.text=@"用户名";
    lbusername.font=[UIFont systemFontOfSize:17];
    //密码提示
    lbpassword=[[UILabel alloc]initWithFrame:CGRectMake(37, 185, 34, 21)];
    lbpassword.text=@"密码";
    lbpassword.font=[UIFont systemFontOfSize:17];
    
    //用户名输入看
    txtusername=[[UITextField alloc] initWithFrame:CGRectMake(89, 146, 211, 30)];
    txtusername.font=[UIFont systemFontOfSize:17];
    txtusername.borderStyle=UITextBorderStyleRoundedRect;  //设置边框的的样试，当前设置为圆角矩形；
    txtusername.placeholder=@"用户名"; //设置没有内容的时候显示的值
    txtusername.clearButtonMode = UITextFieldViewModeAlways;
    txtusername.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtusername.returnKeyType =UIReturnKeyDone;
    [txtusername addTarget:self action:@selector(textFieldNameDidEndEditing:)  forControlEvents:UIControlEventEditingDidEndOnExit];
    txtusername.delegate=self;
    
    
    //密码输入框
    txtpassword=[[UITextField alloc] initWithFrame:CGRectMake(89, 181, 211, 30)];
    txtpassword.font=[UIFont systemFontOfSize:17];
    txtpassword.borderStyle=UITextBorderStyleRoundedRect;
    txtpassword.clearButtonMode = UITextFieldViewModeAlways;
    txtpassword.placeholder=@"密码";
    txtpassword.secureTextEntry=YES;
    txtpassword.returnKeyType =UIReturnKeyDone;
    [txtpassword addTarget:self action:@selector(textFieldLoginDidEndEditing:)  forControlEvents:UIControlEventEditingDidEndOnExit];
    txtpassword.delegate=self;
    

    
    //错误提示框
    msg=[[UILabel alloc]initWithFrame:CGRectMake(37, 263, 263, 21)];
    msg.font=[UIFont systemFontOfSize:17];
    msg.textColor=[UIColor redColor];
    
    
    //记住密码提示
    mima=[[UILabel alloc]initWithFrame:CGRectMake(126, 234, 68 , 21)];
    mima.font=[UIFont systemFontOfSize:17];
    mima.text=@"记住密码";
    
    //开关按钮
    swith=[[UISwitch alloc] initWithFrame:CGRectMake(210, 229, 51, 31)];
    [swith addTarget:self action:@selector(isSave) forControlEvents:UIControlEventValueChanged];
    [swith setOn:YES];
    
    //登录按钮
    btnLogin=[[UIButton alloc] initWithFrame:CGRectMake(20, 301, 280, 30)];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitle:@"登录" forState:UIControlStateHighlighted];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btnLogin setBackgroundColor:[UIColor colorWithRed:0.2 green:0.3 blue:0.4 alpha:0.5]];
    [btnLogin addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
   
    
    [self.view addSubview:lbusername];
    [self.view addSubview:lbpassword];
    [self.view addSubview:txtusername];
    [self.view addSubview:txtpassword];
    [self.view addSubview:msg];
    [self.view addSubview:mima];
    [self.view addSubview:swith];
    [self.view addSubview:btnLogin];
    
    


}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initInterface];
    issave=YES;
    NSLog(@"%@",[MyKeyChainHelper getUserNameWithService:KEY_USERNAME]);
    txtusername.text=[MyKeyChainHelper getUserNameWithService:KEY_USERNAME];
    txtpassword.text=[MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
   // self.view.backgroundColor=[UIColor colorWithRed:0.2 green:0.3 blue:0.4 alpha:0.5];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-登录
- (void) Login:(UIButton *)btn
{
    [AppHelper showHUD:@"loging"];
    
    NSLog(@"点击登录咯");
    
    NSString * name=txtusername.text;
    NSString * pass=[Tool md5HexDigest:txtpassword.text];
    if (issave)
    {
        [MyKeyChainHelper saveUserName:name userNameService:KEY_USERNAME psaaword:txtpassword.text psaawordService:KEY_PASSWORD];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [defaults valueForKey:@"DeviceToken"];
    
    NSString * strurl=[Tool Append:defaultWebServiceUrl witnstring:@"GetOneUserWithRoleT"];
    NSURL *myurl = [NSURL URLWithString:strurl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:name forKey:@"username"];
    [request setPostValue:pass forKey:@"password"];
    [request setPostValue:deviceToken forKey:@"deviceToken"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(LoginResult:)];
    [request setDidFailSelector:@selector(LoginErr:)];
    [request startAsynchronous];
}

- (void)LoginResult:(ASIHTTPRequest *) req
{
    // Use when fetching text data
    NSString *responseString = [req responseString];
    
    NSMutableDictionary * arr=[SoapXmlParseHelper rootNodeToArray :responseString];
    NSString * dictstring=[arr objectForKey:@"text"];
    NSDictionary * dict=[Tool StringTojosn:dictstring];
    if(dict){
        NSString * state=[dict objectForKey:@"status"];
        NSString * role=[dict objectForKey:@"Role"];
        if([state isEqual:@"1"])
        {
             [AppHelper removeHUD];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setValue:[dict objectForKey:@"UserName"] forKey:@"UserName"];
            [defaults setValue:[dict objectForKey:@"UserID"] forKey:@"UserID"];
            [defaults setValue:[dict objectForKey:@"Password"] forKey:@"Password"];
            [defaults synchronize];
            
            if([role isEqual:@"A"]||[role isEqual:@"V"]){
                
                
                MainViewController * mainview=[[MainViewController alloc] init];
                [self presentViewController: mainview animated:YES completion:nil];
                
            }
            else if([role isEqual:@"P"])
            {
                PMainViewController * mainview=[[PMainViewController alloc] init];
                [self presentViewController: mainview animated:YES completion:nil];
                
                
            }else if([role isEqual:@"T"]){
                
                
                [self performSegueWithIdentifier:@"loginT" sender:self];
                
            }else{
                
                msg.text=@"账号未经许可";
                 
                
            }
            
        }
        else
        {
            
          msg.text=@"您的账号未审核，请审核后登录";
              [AppHelper removeHUD];
        }
        
        
    }else{
        msg.text=@"账号密码错误";
          [AppHelper removeHUD];
        
    }

    
    
    // Use when fetching binary data
   // NSData *responseData = [request responseData];
    
}
- (void)LoginErr:(ASIHTTPRequest *) req
{
     // NSError *error = [req error];
    
     msg.text=@"登录出错，请检查您的网络";
      [AppHelper removeHUD];

}
#pragma mark-是否记住密码
- (void)isSave
{
    NSLog(@"记住密码");
    if(swith.isOn)
      {
         issave=YES;
        [MyKeyChainHelper deleteWithUserNameService:KEY_USERNAME psaawordService:KEY_PASSWORD];
      }
      else
      {
       issave=NO;
    
      }
}

#pragma mark-键回收

- (void)textFieldNameDidEndEditing:(UITextField *)textField
{
    
    [txtpassword becomeFirstResponder];
  
  
}
- (void)textFieldLoginDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void)hidenKeyboard
{
    [txtpassword resignFirstResponder];
    [txtusername resignFirstResponder];
    
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
