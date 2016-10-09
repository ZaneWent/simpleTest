//
//  ZWTimeSystem.h
//  xxx
//
//  Created by zane on 14-7-11.
//  Copyright (c) 2014年 Zane Went. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZWTimeFormatStyle)
{
    ZWTimeFormatStyleDefault,//yyyy-MM-dd HH:mm:ss
    ZWTimeFormatStyleHHMMSS,//HH:mm:ss
    ZWTimeFormatStyleMMSS,//mm:ss
    ZWTimeFormatStyleYMD//yyyy-MM-dd
};


@interface ZWTimeSystem : NSObject
{
    UIView *curView;
    
    NSString *curDateStr;
    NSTimer *refreshTimer;
    NSTimeInterval sec;
    
    
    NSTimer *curTimer;
    

}

@property (nonatomic, copy) NSString *curDateStr;
@property (nonatomic, copy) NSDate *curDate;

+ (ZWTimeSystem *)sharedInstance;

	
- (void)getRealTime;
- (NSString *)getOneDayAfterTime;


- (NSString *)getDateString:(NSDate *)date withDateStyle:(ZWTimeFormatStyle)style;//根据date以及不同得时间格式获取时间str
- (NSDate *)getDate:(NSString *)dateStr withDateStyle:(ZWTimeFormatStyle)style;

//根据datestr与当前时间str进行比较，大于或等于则返回yes，否则为no
- (BOOL)curDateStrMoreThanDateStr:(NSString *)dataStr;

//取消内部时间自增
- (void)cancleRunCurDate;

//取消所有倒计时
- (void)cancleAllTimer;


@end
