//
//  XXStepDataManager.m
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "XXStepDataManager.h"

#import "FMDB.h"

#import "StepModel.h"

static FMDatabase *_db;

@implementation XXStepDataManager

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"step.sqlite"];
    NSLog(@"path:%@",path);
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    
    //创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_step (id integer PRIMARY KEY, step integer NOT NULL, recordtime text,cdate date, savenum integer, content text, distance double);"];
}
//增
+ (void)addStep:(StepModel *)step
{
    /*
     step
     date
     savenum
     content
     */
    [_db executeUpdateWithFormat:@"INSERT INTO t_step(step, recordtime,cdate, savenum, content,distance) VALUES (%d, %@,%@,%ld, %@, %f);",step.step,step.record_time,step.date,step.savenum,step.content,step.distance];
    
}

+ (NSArray *)stepModels
{
    //查
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_step;"];
    
    
    NSMutableArray *mutArray = [NSMutableArray array];
    while (set.next) {
        StepModel *stepM = [[StepModel alloc]init];
        stepM.step = [set intForColumn:@"step"];
        stepM.date = [set dateForColumn:@"cdate"];
        stepM.record_time = [set stringForColumn:@"recordtime"];
        stepM.savenum = [set intForColumn:@"savenum"];
        stepM.content = [set stringForColumn:@"content"];
        stepM.distance = [set doubleForColumn:@"distance"];
        [mutArray addObject:stepM];
    }
    return mutArray;
    
}


//查询是否存有今天数据
+ (BOOL)selectStep
{
    BOOL isStep = NO;
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
    dateFromatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFromatter stringFromDate:currentDate];
    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_step;"];
    while (set.next) {
        StepModel *stepM = [[StepModel alloc]init];
        stepM.record_time = [set stringForColumn:@"recordtime"];
        
        if ([stepM.record_time isEqualToString:dateStr]) {
            isStep = YES;
        }
    }
    return isStep;
    
}


//更新
+ (void)updateStep:(StepModel *)step
{
    [_db executeUpdateWithFormat:@"UPDATE t_step SET step = %d,distance = %f,cdate =%@ WHERE recordtime = %@;",step.step,step.distance,step.date,step.record_time];
    
}

//删除表中所有数据
+ (void)deleteStep
{
    BOOL success = [_db executeUpdate:@"DELETE FROM t_step"];
    //DELETE FROM t_step 删除表中所有数据
    //DROP TABLE IF EXISTS t_step 删除表
}

@end
