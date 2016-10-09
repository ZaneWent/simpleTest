//
//  ZWTimeSystem.m
//  xxx
//
//  Created by zane on 14-7-11.
//  Copyright (c) 2014年 Zane Went. All rights reserved.
//

#import "ZWTimeSystem.h"

static ZWTimeSystem *timeSystem = nil;

@implementation ZWTimeSystem

@synthesize curDateStr,curDate;

+ (ZWTimeSystem *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!timeSystem) {
            timeSystem = [[self alloc]init];
        }
    });
    return timeSystem;
    
}


- (id)init
{
    self = [super init];
    if (self) {
        [self getRealTime];
    }
    return self;
}

- (void)cancleAllTimer
{
    [self cancleRunCurDate];

}

- (void)getRealTime;
{
    if (!curTimer) {
        NSURL *url=[NSURL URLWithString:@"https://cn.avoscloud.com/"];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        [connection start];
        
    }
}


- (NSString *)getOneDayAfterTime
{
    NSDate *newDate = [curDate dateByAddingTimeInterval:3600*24];
    return [self getDateString:newDate withDateStyle:ZWTimeFormatStyleDefault];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response%@",response);
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dic=[httpResponse allHeaderFields];
        NSString *time=[dic objectForKey:@"Date"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
        NSDate *date = [formatter dateFromString:time];
        NSLog(@"%@",date);
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        curDateStr = [outputFormatter stringFromDate:date];//得到当前网络时间
        NSLog(@"testDate:%@",curDateStr);
        
        curDate = [self getDate:curDateStr withDateStyle:ZWTimeFormatStyleDefault];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NOWGETTHECURRENTDATEANDTIME" object:nil];
        //开始对当前时间计时
        if (!curTimer) {
            [self startRunCurDate];
        }
        
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"网络连接错误" delegate:self cancelButtonTitle:@"重新加载" otherButtonTitles:nil, nil];
    [view show];
}


- (void)runCurrentTimeIYTS
{
    NSDate *newDate = [NSDate dateWithTimeInterval:1 sinceDate:curDate];
    curDateStr = [self getDateString:newDate withDateStyle:ZWTimeFormatStyleDefault];
    NSLog(@"curDateStr:%@",curDateStr);
    curDate = newDate;
}

- (void)startRunCurDate
{
    curTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runCurrentTimeIYTS) userInfo:nil repeats:YES];
}

- (void)cancleRunCurDate
{
    [curTimer invalidate];
    curTimer = nil;
}



- (NSString *)getDateString:(NSDate *)date withDateStyle:(ZWTimeFormatStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    
    switch (style) {
        case ZWTimeFormatStyleDefault:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case ZWTimeFormatStyleHHMMSS:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
        case ZWTimeFormatStyleMMSS:
            [formatter setDateFormat:@"mm:ss"];
            break;
        case ZWTimeFormatStyleYMD:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        default:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
    }
    
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSDate *)getDate:(NSString *)dateStr withDateStyle:(ZWTimeFormatStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    switch (style) {
        case ZWTimeFormatStyleDefault:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case ZWTimeFormatStyleHHMMSS:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
        case ZWTimeFormatStyleMMSS:
            [formatter setDateFormat:@"mm:ss"];
            break;
        case ZWTimeFormatStyleYMD:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        default:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
    }
    NSDate *date = [formatter dateFromString:dateStr];
    NSLog(@"%@",date);
    return date;
}

//根据datestr与当前时间str进行比较，大于或等于则返回yes，否则为no
- (BOOL)curDateStrMoreThanDateStr:(NSString *)dataStr
{
    if (dataStr) {
        if ([curDateStr compare:dataStr] == NSOrderedAscending) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}



#pragma mark - timeHandleMethod



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex  // after animation
{
    if (buttonIndex == 0) {
        //重新加载
//        [[IYSameView defaultInstance]showIndicatorView:curView];
//        [self performSelector:@selector(doNewLoad) withObject:nil afterDelay:1];
        [self getRealTime];
    }
}

- (void)doNewLoad
{
    UIView *tempView = curView;
    [self getRealTime];
    curView = tempView;
}

@end
