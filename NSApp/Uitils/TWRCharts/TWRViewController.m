//
//  TWRViewController.m
//  NSApp
//
//  Created by DongCai on 8/23/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "TWRViewController.h"
#import "TWRChart.h"

@interface TWRViewController ()

@property(strong, nonatomic) TWRChartView *chartView;
@property(strong, nonatomic) UISegmentedControl *segmentedControl;

- (void)switchChart:(UISegmentedControl *)sender;

@end

@implementation TWRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Charts";
    
    // Segmented Control
//    _segmentedControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
//    [_segmentedControl setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:_segmentedControl];
    [_segmentedControl addTarget:self action:@selector(switchChart:) forControlEvents:UIControlEventValueChanged];
    
    // Chart View
    _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(35, 64, 240, 260)];
    _chartView.backgroundColor = [UIColor clearColor];
    // User interaction is disabled by default. You can enable it again if you want
    // _chartView.userInteractionEnabled = YES;
    
    // Load chart by using a ChartJS javascript file
//    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    NSString *jsFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"OA.bundle/js/index.js"]; 
    [_chartView setChartJsFilePath:jsFilePath];
    
    // Add the chart view to the controller's view
    [self.view addSubview:_chartView];
    [self loadPieChart];

}
/**
 *  Loads a bar chart using native code
 */
- (void)loadBarChart {
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:@[@10, @15, @5, @15, @5]
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];
    
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:@[@5, @10, @5, @15, @10]
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    
    NSArray *labels = @[@"A", @"B", @"C", @"D", @"E"];
    TWRBarChart *bar = [[TWRBarChart alloc] initWithLabels:labels
                                                  dataSets:@[dataSet1, dataSet2]
                                                  animated:YES];
    // Load data
    [_chartView loadBarChart:bar];
}

/**
 *  Loads a line chart using native code
 */
- (void)loadLineChart {
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:@[@10, @15, @5, @15, @5]];
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:@[@5, @10, @5, @15, @10]];
    
    NSArray *labels = @[@"A", @"B", @"C", @"D", @"E"];
    
    TWRLineChart *line = [[TWRLineChart alloc] initWithLabels:labels
                                                     dataSets:@[dataSet1, dataSet2]
                                                     animated:NO];
    // Load data
    [_chartView loadLineChart:line];
}

/**
 *  Loads a pie / doughnut chart using native code
 */
- (void)loadPieChart {
    // Values
    NSArray *values = @[@20, @30, @15, @5];
    
    // Colors
    UIColor *color1 = [UIColor colorWithHue:0.5 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color2 = [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color3 = [UIColor colorWithHue:0.7 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color4 = [UIColor colorWithHue:0.8 saturation:0.6 brightness:0.6 alpha:1.0];
    NSArray *colors = @[color1, color2, color3, color4];
    
    // Doughnut Chart
    TWRCircularChart *pieChart = [[TWRCircularChart alloc] initWithValues:values
                                                                   colors:colors
                                                                     type:TWRCircularChartTypeDoughnut
                                                                 animated:YES];
    
    // You can even leverage callbacks when chart animation ends!
    [_chartView loadCircularChart:pieChart withCompletionHandler:^(BOOL finished) {
        if (finished) {
            NSLog(@"Animation finished!!!");
        }
    }];
}
#pragma mark - UISegmentedController switch methods

- (void)switchChart:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
            //Line
        case 0: {
            [self loadLineChart];
        }
            break;
            
            //Bar
        case 1: {
            [self loadBarChart];
        }
            break;
            
            //Pie
        case 2: {
            [self loadPieChart];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
