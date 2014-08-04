//
//  TDDBOperate.h
//  NewTuanDai
//
//  Created by Dee on 14-5-5.
//  Copyright (c) 2014年 TD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDDBOperate : NSObject

+(NSNumber*)getGestureForUserID:(NSString*)userID;

+(BOOL)createDB;


+(void)setGesture:(NSNumber*)theGesture forUserID:(NSString*)userID;


+(void)deleteGestureForUserID:(NSString*)userID;


+(BOOL)checkGesture:(NSString*)gestureString forUserID:(NSString*)userID;



+(BOOL)checkGestureExistForUserID:(NSString*)userID;

///

+(NSArray*)getAllProvince;

+(NSArray*)getAllCityBy:(NSString*)proID;

@end
