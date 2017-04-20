//
//  StepModel.h
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepModel : NSObject

@property(nonatomic,strong) NSDate *date;

@property(nonatomic,assign) int record_no;

@property(nonatomic, strong) NSString *record_time;

@property(nonatomic,assign) int step;

@property (nonatomic, assign) NSInteger savenum;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,assign) double distance;

//g是一个震动幅度的系数,通过一定的判断条件来判断是否计做一步
@property(nonatomic,assign) double g;


@end
