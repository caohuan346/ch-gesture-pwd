//
//  TDSwitchGestureViewController.m
//  NewTuanDai
//
//  Created by Dee on 14-5-12.
//  Copyright (c) 2014年 TD. All rights reserved.
//

#import "CHSwitchGestureViewController.h"
#import "CHGesturePwdViewController.h"
#import "TDDBOperate.h"

@interface CHSwitchGestureViewController ()<TDGestureDelegate>{
    
    
    UISwitch *allSwitch;
    UILabel *dealUL;
    
    UIButton *myInvestBtn;
    
}

@end

@implementation CHSwitchGestureViewController

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
    // Do any additional setup after loading the view.
    self.title = @"修改手势密码";
    
    [self initView];
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton   setImage:[UIImage imageNamed:@"invest_detail_nav_back"] forState:UIControlStateNormal];
    [leftBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [leftBarButton setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBarButton  addTarget:self action:@selector(popWithAnimate) forControlEvents:UIControlEventTouchUpInside];
    leftBarButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
       [leftBarButton  setTitle:@"返回" forState:UIControlStateNormal];
    
    
    if (DSystemVersion < 7 ) {
        
        [leftBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    };

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithCustomView:leftBarButton];
    
    
}



-(void)initView{
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *uiv = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, 320, 60)];
    uiv.image = [[UIImage imageNamed:@"verify2_choose_id_type1"]  resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 20, 2)];
    [self.view addSubview:uiv];
    
    dealUL = [[UILabel alloc]   initWithFrame:CGRectMake(10, 9, 320, 25)];
    dealUL.text = @"手势密码:开启";
    dealUL.font = [UIFont boldSystemFontOfSize:16];
    dealUL.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dealUL];
    
   
    
    UILabel *rankUL = [[UILabel alloc]   initWithFrame:CGRectMake(10,34, 300, 15)];
    rankUL.backgroundColor = [UIColor clearColor];
    rankUL.font = [UIFont systemFontOfSize:10];
    rankUL.text  = [NSString stringWithFormat:@"进入应用时需要手势密码验证" ] ;
    rankUL.textColor = [UIColor grayColor];
    [self.view addSubview:rankUL];
    
    [rankUL sizeToFit];
    
    
    
	BOOL isPatternSet = ([[NSUserDefaults standardUserDefaults] valueForKey:kCurrentPattern]) ? YES: NO;
    
    allSwitch = [[UISwitch alloc]  initWithFrame:CGRectMake(236, 13, 60, 30)];
    [allSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventTouchUpInside];
    allSwitch.on = isPatternSet;
    [self.view addSubview:allSwitch];
    
    if (DSystemVersion  < 7.0) {
        allSwitch.frame = CGRectMake(236 - 20, 13, 60, 30);
    }
  
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    myInvestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myInvestBtn.frame = CGRectMake(10, CGRectGetMaxY(uiv.frame) + 20, 300, 46);
    [myInvestBtn  setBackgroundImage:[[UIImage imageNamed:@"user_table"]  resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 10, 15)] forState:UIControlStateNormal];
    [myInvestBtn addTarget:self action:@selector(modifyDealPSW) forControlEvents:UIControlEventTouchUpInside];
    [myInvestBtn  setBackgroundImage:[[UIImage imageNamed:@"user_table_tap"]  resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 10, 15)] forState:UIControlStateHighlighted];
    [self.view addSubview:myInvestBtn];
    
    
    UILabel *btnName = [[UILabel alloc]  initWithFrame:CGRectMake(10, 0, 200, 46)];
    btnName.backgroundColor = [UIColor clearColor];
    btnName.text = @"修改手势密码";
    btnName.font = [UIFont boldSystemFontOfSize:15];
    [myInvestBtn addSubview:btnName];
    
    
    if (allSwitch.on) {
        
        dealUL.text = @"手势密码:开启";
        myInvestBtn.hidden = false;
        
    }else {
        
        dealUL.text = @"手势密码:关闭";
        myInvestBtn.hidden = true;
        
    }
    
    
}


#pragma mark - gesture

-(void)validateGestureFinish{
    
    allSwitch.on = !allSwitch.on;
   
    
    
    if (allSwitch.on) {
        
        dealUL.text = @"手势密码:开启";
        myInvestBtn.hidden = false;
        
    }else {
        
        dealUL.text = @"手势密码:关闭";
        myInvestBtn.hidden = true;
        
        
        [TDDBOperate deleteGestureForUserID:[[NSUserDefaults standardUserDefaults]   valueForKey:@"TDUserId"]];
        
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:kCurrentPattern];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
}


-(void)setGestureFinish{
    
    
    allSwitch.on = true;
    
        
    dealUL.text = @"手势密码:开启";
    
    
    if (allSwitch.on) {
        
        dealUL.text = @"手势密码:开启";
        myInvestBtn.hidden = false;
        
    }else {
        
        dealUL.text = @"手势密码:关闭";
        myInvestBtn.hidden = true;
        
        
        [TDDBOperate deleteGestureForUserID:[[NSUserDefaults standardUserDefaults]   valueForKey:@"TDUserId"]];
        
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:kCurrentPattern];
        
    }
    
  
}


#pragma mark -


-(void)modifyDealPSW{
    
    
    BOOL isPatternSet = ([[NSUserDefaults standardUserDefaults] valueForKey:kCurrentPattern]) ? YES: NO;
	if(self.navigationController.presentingViewController == nil && isPatternSet){
		CHGesturePwdViewController *lockVc = [[CHGesturePwdViewController alloc]init];
		lockVc.infoLabelStatus = InfoStatusResetPSW;
        lockVc.delegate = self;
	
        
        UINavigationController *unc = [[UINavigationController  alloc]  initWithRootViewController:lockVc];
        [unc.navigationBar   setBackgroundImage:[UIImage imageNamed:@"nav_bg_part_bottom"] forBarMetrics:UIBarMetricsDefault];
        unc.navigationBarHidden = true;
        

        
        if (DSystemVersion >= 6.0) {
            
            [self.navigationController.tabBarController presentModalViewController:unc animated:true];
            
        }else {
            
            [self.navigationController.tabBarController presentViewController:unc animated:true completion:^{
                //
            }];
            
        }
        
	}
    
}


-(void)backSwitch{
    
    
    allSwitch.on = !allSwitch.on;
    

}


-(void)switchAction{
    
    
    
    [self performSelector:@selector(backSwitch) withObject:nil afterDelay:.3f];
    
    
    BOOL isPatternSet = ([[NSUserDefaults standardUserDefaults] valueForKey:kCurrentPattern]) ? YES: NO;
	if(self.navigationController.presentingViewController == nil && isPatternSet){
		CHGesturePwdViewController *lockVc = [[CHGesturePwdViewController alloc]init];
		lockVc.infoLabelStatus = InfoStatusCloseGesture;
        lockVc.delegate = self;
        
        UINavigationController *unc = [[UINavigationController  alloc]  initWithRootViewController:lockVc];
        [unc.navigationBar   setBackgroundImage:[UIImage imageNamed:@"nav_bg_part_bottom"] forBarMetrics:UIBarMetricsDefault];
        unc.navigationBarHidden = true;

        
	    if (DSystemVersion >= 6.0) {
            
            [self.navigationController.tabBarController presentModalViewController:unc animated:true];
            
        }else {
            
            [self.navigationController.tabBarController presentViewController:unc animated:true completion:^{
                //
            }];
            
        }
        
	}else if( !isPatternSet && allSwitch.on){
        
        CHGesturePwdViewController *lockVc = [[CHGesturePwdViewController alloc]init];
		lockVc.infoLabelStatus = InfoStatusFirstTimeSetting;
        lockVc.delegate = self;
        
        UINavigationController *unc = [[UINavigationController  alloc]  initWithRootViewController:lockVc];
        [unc.navigationBar   setBackgroundImage:[UIImage imageNamed:@"nav_bg_part_bottom"] forBarMetrics:UIBarMetricsDefault];
        unc.navigationBarHidden = true;

        
	    if (DSystemVersion >= 6.0) {
            
            [self.navigationController.tabBarController presentModalViewController:unc animated:true];
            
        }else {
            
            [self.navigationController.tabBarController presentViewController:unc animated:true completion:^{
                //
            }];
            
        }
        
    }
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
