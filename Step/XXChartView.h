//
//  XXChartView.h
//  Step
//
//  Created by corepass on 17/4/19.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXChartView : UIView

@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong) NSArray *titleArray;
- (instancetype)initWithFrame:(CGRect)frame;

@end
