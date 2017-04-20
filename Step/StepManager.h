//
//  StepManager.h
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface StepManager : NSObject

- (void)startStep:(void (^)(CMPedometerData * pedometer))pedometer ;


@property (nonatomic) NSInteger step;                       // 运动步数（总计）

+ (StepManager *)sharedManager;
//开始计步
- (void)startWithStep;

//调取系统计步
//- (void)startStepAndCMPedometer;

////得到计步所消耗的卡路里
//+ (NSInteger)getStepCalorie;
//
////得到所走的路程(单位:米)
//+ (CGFloat)getStepDistance;
//
////得到运动所用的时间
//+ (NSInteger)getStepTime;

@end
