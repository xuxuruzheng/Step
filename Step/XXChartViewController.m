//
//  XXChartViewController.m
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "XXChartViewController.h"
#import "XXChartView.h"

#import "XXStepDataManager.h"
#import "StepModel.h"

@interface XXChartViewController ()

@end

@implementation XXChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    XXChartView *chartView = [[XXChartView alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 250)];
    //时间
    chartView.titleArray = [self compareTime];
    
    NSArray *dataArray = [XXStepDataManager stepModels];
    
    NSMutableArray *mutArray = [[NSMutableArray alloc]init];
    
    if (dataArray.count > 7) {
        for (int i = (int)(dataArray.count-7); i < dataArray.count; i++) {
            StepModel *stepM = dataArray[i];
            [mutArray addObject:[NSString stringWithFormat:@"%d",stepM.step]];
        }
        
    }else{
        for (StepModel *stepM in dataArray) {
            [mutArray addObject:[NSString stringWithFormat:@"%d",stepM.step]];
        }
    }
    
    chartView.dataArray = mutArray.copy;
    [self.view addSubview:chartView];
    
}

- (NSArray *)compareTime
{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 6; i >= 0; i--) {
        NSTimeInterval secondPerDay = 24*60*60*i;
        NSDate * oldDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
        NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
        dateFromatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [dateFromatter stringFromDate:oldDay];
        NSString *date = [dateStr substringFromIndex:6];
        [mutArray addObject:date];
    }
    return [mutArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
