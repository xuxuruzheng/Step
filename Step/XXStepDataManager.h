//
//  XXStepDataManager.h
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StepModel;

@interface XXStepDataManager : NSObject

//查询并返回所有数据
+ (NSArray *)stepModels;

//插入数据
+ (void)addStep:(StepModel *)step;

//查询是否有今天的数据
+ (BOOL)selectStep;

// 更新今天的数据
+ (void)updateStep:(StepModel *)step;

//删除表数据
+ (void)deleteStep;

@end
