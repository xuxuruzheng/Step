//
//  LianChartViewController.m
//  Step
//
//  Created by corepass on 17/4/20.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "LianChartViewController.h"
#import "ZFChart.h"

#import "XXStepDataManager.h"
#import "StepModel.h"

@interface LianChartViewController ()<ZFGenericChartDataSource, ZFLineChartDelegate>
@property (nonatomic, strong) ZFLineChart *lineChart;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LianChartViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setUp{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    
    NSArray *dataArray = [XXStepDataManager stepModels];
    for (StepModel *stepM in dataArray) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%d",stepM.step]];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, _height-100)];
    self.lineChart.dataSource = self;
    self.lineChart.delegate = self;
    
    self.lineChart.topicLabel.text = @"步行折线图";
    self.lineChart.unit = @"步";
    self.lineChart.topicLabel.textColor = ZFPurple;
    self.lineChart.isResetAxisLineMinValue = YES;
    self.lineChart.isShowSeparate = YES;
    [self.view addSubview:self.lineChart];
    [self.lineChart strokePath];
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

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart
{
    return 10000;
}

- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart
{
    return 0;
}


#pragma mark - ZFBarChartDelegate

- (NSInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart
{
    return 10;
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectCircleAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex{
    NSLog(@"第%ld个", (long)circleIndex);
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectPopoverLabelAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex{
    NSLog(@"第%ld个" ,(long)circleIndex);
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
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.lineChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.lineChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.lineChart strokePath];
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
