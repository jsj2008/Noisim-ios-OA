//
//  TWRChartView.m
//  ChartJS
//
//  Created by Michelangelo Chasseur on 21/04/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRChartView.h"
#import "TWRLineChart.h"
#import "TWRBarChart.h"
#import "TWRChartBuilder.h"
#import "TWRCircularChart.h"

@interface TWRChartView () <UIWebViewDelegate>

@property (copy, nonatomic) NSString *htmlFilePath;
@property (copy, nonatomic) NSString *jsFileString;
@property (copy, nonatomic) TWRAnimationCompletionBlock block;

@end

@implementation TWRChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // Setting self as the delegate
    self.delegate = self;
    
    // Let the view be transparent
    self.opaque = NO;
    self.delegate = self;
    // HTML index file
    
//    NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *htmlFilePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"OA.bundle/html/index.html"];
    _htmlFilePath = htmlFilePath;
    self.userInteractionEnabled = NO;
}

- (void)didMoveToSuperview {
    // Init request
    NSError *error;
    
    // Load Javascript and store it in local ivar
    _jsFileString = [NSString stringWithContentsOfFile:_chartJsFilePath encoding:NSUTF8StringEncoding error:&error];
    
    [self loadIndex];
    //    [self loadRequest:request];
}

- (void)loadBarChart:(TWRBarChart *)barChart {
    if ([barChart isKindOfClass:[TWRBarChart class]] ) {
        _jsFileString = [TWRChartBuilder buildChartWithElement:barChart];
        [self stringByEvaluatingJavaScriptFromString:_jsFileString];
        [self loadIndex];
    } else {
        NSException *exception = [NSException exceptionWithName:@"TWRChartInvalicChartElement"
                                                         reason:@"The element object provided to the chart view is not a valid bar chart."
                                                       userInfo:nil];
        [exception raise];
    }
}

- (void)loadBarChart:(TWRBarChart *)barChart withCompletionHandler:(TWRAnimationCompletionBlock)block {
    _block = block;
    [self loadBarChart:barChart];
}

- (void)loadLineChart:(TWRLineChart *)lineChart {
    if ([lineChart isKindOfClass:[TWRLineChart class]]) {
        _jsFileString = [TWRChartBuilder buildChartWithElement:lineChart];
        [self stringByEvaluatingJavaScriptFromString:_jsFileString];
        [self loadIndex];
    } else {
        NSException *exception = [NSException exceptionWithName:@"TWRChartInvalicChartElement"
                                                         reason:@"The element object provided to the chart view is not a valid line chart."
                                                       userInfo:nil];
        [exception raise];
    }
}

- (void)loadLineChart:(TWRLineChart *)lineChart withCompletionHandler:(TWRAnimationCompletionBlock)block {
    _block = block;
    [self loadLineChart:lineChart];
}

- (void)loadCircularChart:(TWRCircularChart *)circularChart {
    if ([circularChart isKindOfClass:[TWRCircularChart class]]) {
        _jsFileString = [TWRChartBuilder buildChartWithElement:circularChart];
        [self stringByEvaluatingJavaScriptFromString:_jsFileString];
        [self loadIndex];
    } else {
        NSException *exception = [NSException exceptionWithName:@"TWRChartInvalicChartElement"
                                                         reason:@"The element object provided to the chart view is not a valid circular chart."
                                                       userInfo:nil];
        [exception raise];
    }
}

- (void)loadCircularChart:(TWRCircularChart *)circularChart withCompletionHandler:(TWRAnimationCompletionBlock)block {
    _block = block;
    [self loadCircularChart:circularChart];
}

#pragma mark - Private API

- (void)loadIndex {
    NSError *error;
    // Load index.html
    NSString *htmlString = [NSString stringWithContentsOfFile:_htmlFilePath encoding:NSUTF8StringEncoding error:&error];
    
    // Set canvas size according to frame dimensions. Leave space for labels at the bottom.
    NSString *canvasString = [NSString stringWithFormat:@"<canvas id=\"canvas\" height=\"%d\" width=\"%d\"></canvas>", (int)CGRectGetHeight(self.frame)-20, (int)CGRectGetWidth(self.frame) - 10];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<canvas></canvas>" withString:canvasString];
    
    // Load it!
//    double delayInSeconds = 5.8f;
//    dispatch_time_t initTime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delayInSeconds*NSEC_PER_SEC));
//    dispatch_after(initTime,dispatch_get_main_queue(),^(void){
//        [self loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
//    });
//    [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"file://Users/dongcai/Library/Application%20Support/iPhone%20Simulator/7.1/Applications/DB449D94-B3BF-49CB-A028-8B9B0D17F3A2/NSApp.app/"]];
    [self loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}

#pragma mark - Web View Delegate methods

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"载入结束...");
    [self stringByEvaluatingJavaScriptFromString:_jsFileString];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // Listen for Javasrcipt callback when chart ends animation
    NSLog(@"888%@",[[request URL] scheme]);
    if ( [[[request URL] scheme] isEqualToString:@"callback"] ) {
        if (_block) {
            _block(YES);
        }
        return NO;
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    NSLog(@"开始载入...");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"错误：%@",error);
    [self stringByEvaluatingJavaScriptFromString:_jsFileString];
//    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102))
//    {
//        if (!(([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == -999) ||
//              ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102)))
//        {
//            [self dismissWithError:error animated:YES];
//        }
//    }
}
-(void)dealloc
{
    self.delegate = nil;
}
@end
