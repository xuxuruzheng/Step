//
//  BarChartViewController.m
//  Step
//
//  Created by corepass on 17/4/20.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "BarChartViewController.h"
#import "ZFChart.h"
#import "XXStepDataManager.h"

#import "StepModel.h"

@interface BarChartViewController ()<ZFGenericChartDataSource, ZFBarChartDelegate>
@property (nonatomic, strong)ZFBarChart *barChart;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BarChartViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setup{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        //
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT *0.5;
    }else{
        _height = SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *dataArray = [XXStepDataManager stepModels];
    
//    if (dataArray.count > 7) {
//        for (int i = (int)(dataArray.count-7); i < dataArray.count; i++) {
//            StepModel *stepM = dataArray[i];
//            [self.dataArray addObject:[NSString stringWithFormat:@"%d",stepM.step]];
//        }
//        
//    }else{
        for (StepModel *stepM in dataArray) {
            [self.dataArray addObject:[NSString stringWithFormat:@"%d",stepM.step]];
        }
//    }

    self.barChart = [[ZFBarChart alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, _height-100)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"步行柱状图";
    self.barChart.unit = @"步";
    self.barChart.isAnimated = NO;
    self.barChart.isShowSeparate = YES;
    
    [self.view addSubview:self.barChart];
    [self.barChart strokePath];

}

#pragma mark - dataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart
{
    return self.dataArray;
}
- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart
{
    return [self compareTime];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart
{
    return @[ZFMagenta];
}

#pragma mark - ZFBarChartDelegate

- (NSInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart
{
    return 10;
}


- (NSArray *)compareTime
{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = (int)(self.dataArray.count-1); i >= 0; i--) {
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


#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
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
