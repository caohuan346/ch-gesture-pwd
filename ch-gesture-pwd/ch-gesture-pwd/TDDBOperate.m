//
//  TDDBOperate.m
//  NewTuanDai
//
//  Created by Dee on 14-5-5.
//  Copyright (c) 2014年 TD. All rights reserved.
//

#import "TDDBOperate.h"
#import "FMDatabase.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation TDDBOperate

#pragma mark - gesture

+(NSString*)getDB{
    
    return [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Gesture.db"];
}

+(BOOL)createDB{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        
        return false;
    };
    // 'gestureId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE ,
    NSString *createStr=@"CREATE  TABLE  IF NOT EXISTS 'Gesture' ( 'userID' VARCHAR PRIMARY KEY, 'isEnable' INTEGER, 'gesture' VARCHAR )";
    
    BOOL worked = [db executeUpdate:createStr];
    
    [db close];

    return worked;
}

+(void)setGesture:(NSNumber*)theGesture forUserID:(NSString*)userID{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        
    };
    
    [db executeUpdate:@"Replace INTO Gesture (userID, gesture) VALUES (?,?)",userID,[theGesture description]];
    
    [db close];
    
}


+(void)deleteGestureForUserID:(NSString*)userID{
    
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        
    };
    
    NSString *deleteSt = [NSString stringWithFormat:@"delete from Gesture where userID = '%@'",userID];
    
    [db executeUpdate:deleteSt];
    
    [db close];
      
    
}


+(NSNumber*)getGestureForUserID:(NSString*)userID{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    
    if (![db open]) {
        
        return nil;
    };
    
    NSNumber *gesture = nil;
    
    NSString *querySt = [NSString stringWithFormat:@"SELECT * from Gesture where userID = '%@'",userID];
    
    FMResultSet *rs = [db executeQuery:querySt];
    
    
    while ([rs next]) {
        
        gesture =  [NSNumber numberWithInt:[[rs stringForColumn:@"gesture"] intValue]] ;
    }
    
    [rs close];
    [db close];
     
    
    
    
    return gesture;
}




+(BOOL)checkGesture:(NSString*)gestureString forUserID:(NSString*)userID{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    
    if (![db open]) {
        
        return true;
    };
    
    NSString *gesture = nil;
    
    NSString *querySt = [NSString stringWithFormat:@"SELECT * from Gesture where userID = '%@'",userID];
    
    FMResultSet *rs = [db executeQuery:querySt];
    
    
    while ([rs next]) {
        
        gesture = [rs stringForColumn:@"gesture"];
    }
    
    [rs close];
    [db close];
    
    BOOL returnBool = false;

    if (gesture) {
        
        if ([gesture isEqualToString:gestureString]) {
            
            returnBool = true;
        }
        
    }
    
    
    return returnBool;
}



+(BOOL)checkGestureExistForUserID:(NSString*)userID{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[TDDBOperate getDB]];
    if (![db open]) {
        
        return false;
    };

    BOOL isExist = false;
    
    NSString *querySt = [NSString stringWithFormat:@"SELECT * from Gesture where userID = '%@'",userID];
    
    FMResultSet *rs = [db executeQuery:querySt];
    
    
    	 while ([rs next]) {
       
        
             isExist = true;
         }
    
    [rs close];
    [db close];

    return isExist;
}



#pragma mark - city


+(NSArray*)getAllProvince{
    
  
    
    NSString *dbPath = [[NSBundle mainBundle]  pathForResource:@"city" ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
 
    if (![db open]) {
     
     
        return @[];
      
    }
    
    
    NSMutableArray *theArray = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:@"select * from province"];
 
    while ([rs next]) {
     
        NSString *name = [rs stringForColumn:@"ProName"];
   
        NSString *proID = [rs stringForColumn:@"ProID"];
        
        [theArray   addObject:@{@"ProName":name, @"ProID":proID}];
        
   
    }
    [rs close];

    [db close];
    

    return theArray;
    
}

+(NSArray*)getAllCityBy:(NSString*)proID{
    
    NSString *dbPath = [[NSBundle mainBundle]  pathForResource:@"city" ofType:@"sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    
    if (![db open]) {
        
        
        return @[];
        
    }
    
    
    NSMutableArray *theArray = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from city where ProID = %@",proID]];
    
    while ([rs next]) {
        
        NSString *name = [rs stringForColumn:@"CityName"];
        
        NSString *proID = [rs stringForColumn:@"CityID"];
        
        [theArray   addObject:@{ @"CityName":name, @"CityID":proID}];
        
    }
    [rs close];
    
    [db close];
    
    
    return theArray;
    
}

@end
