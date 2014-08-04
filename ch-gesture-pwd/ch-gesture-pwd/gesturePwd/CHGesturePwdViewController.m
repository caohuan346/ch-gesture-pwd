//
//  TDGestureViewController.m
//  NewTuanDai
//
//  Created by Dee on 14-5-12.
//  Copyright (c) 2014年 TD. All rights reserved.
//

#import "CHGesturePwdViewController.h"
#import "NormalCircle.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "TDLoginViewController.h"

#import "TDDBOperate.h"

#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)


// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]


@interface CHGesturePwdViewController ()<LockScreenDelegate>

@property (nonatomic) NSInteger wrongGuessCount;

@property (nonatomic,retain) NSString *username;

@end

@implementation CHGesturePwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype)initWithUserName:(NSString*)userName{
    
    self = [super init];
    if (self) {
        // Custom initialization
        self.username = userName;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *backgroundUIV = [[UIImageView alloc]   initWithImage:[UIImage imageNamed:@"gesture_password_bg"]];
    [self.view addSubview:backgroundUIV];
	
	self.lockScreenView = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
	self.lockScreenView.center = self.view.center;
	self.lockScreenView.delegate = self;
	self.lockScreenView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.lockScreenView];
	
	self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 20)];
	self.infoLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.font = [UIFont systemFontOfSize:13];
	self.infoLabel.textColor = [UIColor whiteColor];
	self.infoLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.infoLabel];
	
	[self updateOutlook];
    
    
    
    UIImageView *imageUIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gesture_password_avtar_bg"]];
    [imageUIV setCenter:CGPointMake(160, 100)];
    [self.view addSubview:imageUIV];
    
    CGPoint point = imageUIV.center;
    
    if (!isiPhone5) {
        
        [imageUIV setCenter:CGPointMake(160, 100 -30)];
        self.infoLabel.frame= CGRectMake(0, 110, self.view.frame.size.width, 20);
    }
    
    
    UIImageView *avatorImageView = [[UIImageView alloc] initWithFrame:CGRectInset(imageUIV.frame, 5, 5)];
    avatorImageView.layer.masksToBounds=YES;
    avatorImageView.layer.cornerRadius = CGRectGetWidth(avatorImageView.frame)/2 ;
    [self.view addSubview:avatorImageView];
    
    avatorImageView.center = imageUIV.center;
    
    
    //[avatorImageView  setImageWithURL:[NSURL URLWithString:[[[NSUserDefaults standardUserDefaults] valueForKey:@"TDHeadImage"] description]]];
    
    
    
    imageUIV = [[UIImageView alloc] initWithFrame:CGRectMake(43, 65, 70, 70)];
    //    [imageUIV setImageWithURL:[NSURL URLWithString:[dic[@"InvestInfo"][@"UserAvatarUrl"] description]]];
    imageUIV.alpha = 1 ;
    imageUIV.layer.masksToBounds=YES;
    imageUIV.center = point;
    imageUIV.layer.cornerRadius = CGRectGetWidth(imageUIV.frame)/2;
    [self.view addSubview:imageUIV];
   	
	
    if (_infoLabelStatus == InfoStatusNormal) {
        
        
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetBtn   setTitle:@"用账号登录" forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forgetBtn addTarget:self action:@selector(forgetPsw) forControlEvents:UIControlEventTouchUpInside];
        [forgetBtn setTitleColor:UIColorFromRGB(0x676c71) forState:UIControlStateNormal];
        forgetBtn.frame = CGRectMake(205, 480 , 110, 30);
        [self.view addSubview:forgetBtn];
        
        // Test with Circular Progress
        
        if (!isiPhone5) {
            
            forgetBtn.frame = CGRectMake(205, 430 , 110, 30);
            
            
        }
        
        
        if (InfoStatusResetPSW == _infoLabelStatus) {
            
            
            forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [forgetBtn   setTitle:@"返回" forState:UIControlStateNormal];
            forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [forgetBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            [forgetBtn setTitleColor:UIColorFromRGB(0x676c71) forState:UIControlStateNormal];
            forgetBtn.frame = CGRectMake(225, 480 , 110, 30);
            [self.view addSubview:forgetBtn];
            
            // Test with Circular Progress
            
            if (!isiPhone5) {
                
                forgetBtn.frame = CGRectMake(225, 430 , 110, 30);
                
                
            }
            
        }
        
     


        
    }else if  (InfoStatusResetPSW == _infoLabelStatus) {
        
        
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetBtn   setTitle:@"返回" forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forgetBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [forgetBtn setTitleColor:UIColorFromRGB(0x676c71) forState:UIControlStateNormal];
        forgetBtn.frame = CGRectMake(215, 480 , 110, 30);
        [self.view addSubview:forgetBtn];
        
        // Test with Circular Progress
        
        if (!isiPhone5) {
            
            forgetBtn.frame = CGRectMake(215, 430 , 110, 30);
            
            
        }
        
    }
    
  
}


-(void)goBack{
    
    [self.navigationController  dismissModalViewControllerAnimated:true];
    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[TDUtil submitAnalytics:@"手势密码" andPageDesc:self.description];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
    
   }





-(void)forgetPsw{
    
    /*
    TDLoginViewController *tdlv = [[TDLoginViewController alloc] init]  ;
    self.navigationController.navigationBarHidden = false;
    [self.navigationController pushViewController:tdlv animated:true];
    */
    
    //[TDDBOperate deleteGestureForUserID:[[NSUserDefaults standardUserDefaults]   valueForKey:@"TDUserId"]];
    
     //[[NSUserDefaults standardUserDefaults]  removeObjectForKey:kCurrentPattern];
    
    //[[NSNotificationCenter defaultCenter]  postNotificationName:TDLogOutNotification object:nil userInfo:nil];
    
    
}


- (void)updateOutlook
{
    
    self.infoLabel.textColor = [UIColor whiteColor];
    
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
            case InfoStatusRegisterFinish:
			self.infoLabel.text = @"请绘制手势密码";
			break;
		case InfoStatusConfirmSetting:
			self.infoLabel.text = @"确认手势密码";
			break;
		case InfoStatusFailedConfirm:
			self.infoLabel.text = @"两次手势不一样";
			break;
		case InfoStatusNormal:
			self.infoLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"TDNickName"] ? [[[NSUserDefaults standardUserDefaults] valueForKey:@"TDNickName"] stringByAppendingString:@",您好"]:[[[NSUserDefaults standardUserDefaults]  valueForKey:@"TDUsername"] description] ;
			break;
		case InfoStatusFailedMatch:
          case  InfoStatusResetFail:
            self.infoLabel.textColor = [UIColor redColor];
			self.infoLabel.text = [NSString stringWithFormat:@"密码错误,还可以再输入%d次",5 - self.wrongGuessCount];
			break;
		case InfoStatusSuccessMatch:
			self.infoLabel.text = @"欢迎";
			break;
        case InfoStatusResetPSW:
			self.infoLabel.text = @"请先输入之前的手势";
        break;
            case InfoStatusCloseGesture :
            
			self.infoLabel.text = @"请绘制手势密码以确认";
            
			break;
		default:
			break;
	}
	
}


#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
// 	NSLog(@"self status: %d %@",self.infoLabelStatus,patternNumber);
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
		case InfoStatusRegisterFinish:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusFailedConfirm:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusConfirmSetting:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPatternTemp]]) {
                
				[stdDefault setValue:patternNumber forKey:kCurrentPattern];
                
                [TDDBOperate setGesture:patternNumber forUserID:[[NSUserDefaults standardUserDefaults]   valueForKey:@"TDUserId"]];
                
                [stdDefault synchronize];
                
                if (_delegate) {
                    [_delegate setGestureFinish];
                }
                
                if (!self.username) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
			}
			else {
				self.infoLabelStatus = InfoStatusFailedConfirm;
				[self updateOutlook];
			}
			break;
		case  InfoStatusNormal:
        case InfoStatusCloseGesture:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]){
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
                if (_delegate) {
                    
                    if ([_delegate respondsToSelector:@selector(validateGestureFinish)]) {
                        [_delegate validateGestureFinish];
                    }
                    
                }
            }
                 
            
			else {
				self.infoLabelStatus = InfoStatusFailedMatch;
				self.wrongGuessCount ++;
				[self updateOutlook];
			}
			break;
		case InfoStatusFailedMatch:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]) [self dismissViewControllerAnimated:YES completion:nil];
			else {
				self.wrongGuessCount ++;
                
                if (self.wrongGuessCount >= 5) {
                    self.wrongGuessCount = 5;
                    
                    [self forgetPsw];
                    
                }
                
				self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
			}
			break;
		case InfoStatusSuccessMatch:
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
			
        case InfoStatusResetPSW:
            
            if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]) {
                
                [stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
                self.infoLabelStatus = InfoStatusFirstTimeSetting;
                [self updateOutlook];
                
            }else
            {
				self.infoLabelStatus = InfoStatusResetFail;
				self.wrongGuessCount ++;
				[self updateOutlook];
			}
            
            
            
			break;
            
        case InfoStatusResetFail:
            
            
            if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]) [self dismissViewControllerAnimated:YES completion:nil];
			else {
				self.wrongGuessCount ++;
                
                if (self.wrongGuessCount >= 5) {
                    self.wrongGuessCount = 5;
                    
                    [self forgetPsw];
                    
                }
                
				self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
			}

            
            break;
            
		default:
			break;
	}
}

- (void)viewDidUnload {
	[self setInfoLabel:nil];
	[self setLockScreenView:nil];
	[super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
