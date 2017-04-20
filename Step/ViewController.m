//
//  ViewController.m
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 corepass. All rights reserved.
//
#import "ViewController.h"
#import "StepManager.h"
#import "XXStepDataManager.h"
#import "StepModel.h"


@interface ViewController ()
{
    NSTimer *_timer;
    
}
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@property (nonatomic)int step;
@property (nonatomic)double distance;
@property (nonatomic)NSInteger num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //      [[StepManager sharedManager] startWithStep];
    
    //如果有记录就取出最后一条显示出来
    NSArray *stepArray = [XXStepDataManager stepModels];
    if (stepArray.count > 0) {
        StepModel *sModel = stepArray[stepArray.count-1];
        self.stepLabel.text = [NSString stringWithFormat:@"%d",sModel.step];
        
        self.distanceLabel.text = [NSString stringWithFormat:@"%.1f",sModel.distance];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getStepNumber) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

}


- (IBAction)saveCurrentSteps:(id)sender {
    StepModel *stepM = [[StepModel alloc]init];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
    dateFromatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFromatter stringFromDate:currentDate];
    
    stepM.record_time = @"2017-04-23";
    stepM.content = @"今天天气不错";
    stepM.savenum = 1;
    stepM.step = 4321;
    stepM.distance = self.distance;
//    if ([XXStepDataManager selectStep]) {
//        [XXStepDataManager updateStep:stepM];
//    }else
//    {
        [XXStepDataManager addStep:stepM];
//    }
    
}
- (IBAction)delete:(id)sender {
    [XXStepDataManager deleteStep];
}


- (void)getStepNumber
{
    //    self.stepLabel = [NSString stringWithFormat:@"我走了  %ld步",[StepManager sharedManager].step];
    
    //行走相关信息
    __weak typeof(self) weakSelf = self;
    [[StepManager sharedManager]startStep:^(CMPedometerData *pedometer) {
        self.step = [pedometer.numberOfSteps intValue];
        self.distance = [pedometer.distance doubleValue]/1000;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.stepLabel.text = [NSString stringWithFormat:@"%@",pedometer.numberOfSteps];
            weakSelf.distanceLabel.text = [NSString stringWithFormat:@"%.1f",self.distance];
            
        });
        
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"101"] ) {
        ViewController *vc = [segue destinationViewController];
        vc.title = @"Chart";
    }
    
}

@end

