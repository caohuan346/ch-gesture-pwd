//
//  TDGestureViewController.h
//  NewTuanDai
//
//  Created by Dee on 14-5-12.
//  Copyright (c) 2014年 TD. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SPLockScreen.h"

typedef enum {
	InfoStatusFirstTimeSetting = 0,
	InfoStatusConfirmSetting,
	InfoStatusFailedConfirm,
	InfoStatusNormal,
	InfoStatusFailedMatch,
	InfoStatusSuccessMatch,
    InfoStatusResetPSW,
    InfoStatusResetFail,
    InfoStatusCloseGesture,
	InfoStatusRegisterFinish,
}	InfoStatus;

@protocol TDGestureDelegate <NSObject>

-(void)setGestureFinish;


@optional
-(void)validateGestureFinish;

@end


@interface CHGesturePwdViewController : UIViewController

@property (nonatomic,weak) id<TDGestureDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet SPLockScreen *lockScreenView;
@property (nonatomic) InfoStatus infoLabelStatus;


-(instancetype)initWithUserName:(NSString*)userName;

@end
