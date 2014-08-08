//
//  MBProgressController.m
//  NSApp
//
//  Created by DongCai on 7/30/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "MBProgressController.h"

#import "CustomLocalizedString.h"
#define kCancelBtn_X 253
#define kCancelBtn_Y 172

@implementation MBProgressController
@synthesize HUD;
@synthesize safeConnet;
@synthesize delegate;
@synthesize message;
@synthesize staticClick;
@synthesize isCancleBlock;
static MBProgressController *currentMBProgressView;
+(MBProgressController*)getCurrentController
{
    if (nil == currentMBProgressView) {
		currentMBProgressView = [[MBProgressController alloc] init];
        currentMBProgressView.message=[[[NSString alloc]initWithString:@"Connecting"]autorelease];
        currentMBProgressView.safeConnet=NO;
	}
    return currentMBProgressView;
}

+(void)setMessage:(NSString*)aMessage
{
    if (!currentMBProgressView) {
        [MBProgressController getCurrentController];
    }
    currentMBProgressView.message=aMessage;
    [MBProgressController changeState:currentMBProgressView.HUD.mode withMessage:aMessage];
}

+(void)setMode:(MBProgressHUDMode)aMode
{
    if (!currentMBProgressView) {
        [MBProgressController getCurrentController];
    }
    [MBProgressController changeState:aMode withMessage:nil];
}

+(void)setSafeConnet
{
    if (!currentMBProgressView) {
        [MBProgressController getCurrentController];
    }
    currentMBProgressView.safeConnet=YES;
}

-(void)initProcessWithMessage:(NSString*)aMessage

{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    self.HUD = [[[MBProgressHUD alloc] initWithView:window] autorelease];
    UIButton *click=[[UIButton alloc] initWithFrame:CGRectMake(95, 275, 130, 30)];
    [click setTitle:CustomLocalizedString(@"点击此处取消连接",nil) forState:UIControlStateNormal];
    [click addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [click.titleLabel setFont:[UIFont fontWithName:@"helvetica" size:12]];
    [click setBackgroundColor:[UIColor clearColor]];
    
    [self.HUD addSubview:click];
    [click release];
    [window addSubview:self.HUD];
    self.HUD.alpha=0.8;
    self.HUD.delegate = self;
    self.HUD.labelText = aMessage;
    self.HUD.mode=MBProgressHUDModeIndeterminate;
    currentMBProgressView=self;
    
}

+(void)startQueryProcess
{
    if (!currentMBProgressView) {
        [MBProgressController getCurrentController];
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    currentMBProgressView.HUD = [[[MBProgressHUD alloc] initWithView:window] autorelease];
    
    //    UIButton *click=[[UIButton alloc] initWithFrame:CGRectMake(120, 272, 80, 25)];
    UIButton *click=[UIButton buttonWithType:UIButtonTypeCustom];
    CALayer *layer=[click layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    [layer setCornerRadius:6.0];
    
    
    [click setBackgroundImage: [UIImage imageNamed:@"btn_login_cancel.png"] forState:UIControlStateNormal];
    CGPoint centerOfHUD = currentMBProgressView.HUD.center;
#ifdef Device_Pad
    [click setFrame:CGRectMake(0, 0, 30, 30)];
    [click setCenter:CGPointMake(centerOfHUD.y+108, centerOfHUD.x-53)];
#else
    
    if (iPhone5)
    {
        [click setFrame:CGRectMake(kCancelBtn_X, 215, 30, 30)];
        
    }else
    {
        click.frame=CGRectMake(kCancelBtn_X, kCancelBtn_Y, 30, 30);
    }
#endif
    
    [click setBackgroundColor:[UIColor clearColor]];
    //    [click setTitle:@"取消" forState:UIControlStateNormal];
    
    [click addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [click.titleLabel setFont:[UIFont fontWithName:@"helvetica" size:16]];
    
    [currentMBProgressView.HUD addSubview:click];
    
    click.enabled=currentMBProgressView.safeConnet;
    click.hidden=!currentMBProgressView.safeConnet;
    
    [window addSubview:currentMBProgressView.HUD];
    currentMBProgressView.HUD.alpha=0.8;
    currentMBProgressView.HUD.delegate = currentMBProgressView;
    if (currentMBProgressView.HUD.labelText==nil) {
        if (currentMBProgressView.message) {
            currentMBProgressView.HUD.labelText=currentMBProgressView.message;
        }
        else {
            //            currentMBProgressView.HUD.labelText=CustomLocalizedString(@"连接中",nil);
        }
    }
    currentMBProgressView.HUD.mode=MBProgressHUDModeIndeterminate;
    currentMBProgressView.staticClick=click;
}


+(void)changeState:(MBProgressHUDMode)aMode withMessage:(NSString *)aMessage
{
    if(!currentMBProgressView)
    {
        [MBProgressController getCurrentController];
    }
    //        if (aImage) {
    //            currentMBProgressView.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:aImage]] autorelease];
    //        }
    if (aMode) {
        currentMBProgressView.HUD.mode=aMode;
    }
    if (aMessage) {
        currentMBProgressView.HUD.labelText=aMessage;
    }
}

+(void)correctComplete
{
    //    currentMBProgressView.staticClick.frame=CGRectMake(92, 273, 136, 25);
    //    currentMBProgressView.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
    //    currentMBProgressView.HUD.mode=MBProgressHUDModeCustomView;
    //    currentMBProgressView.HUD.labelText=@"Completed";
    [MBProgressController dismiss];
}

+(void)failedCompelete
{
    //    currentMBProgressView.staticClick.frame=CGRectMake(87, 275, 146, 30);
    currentMBProgressView.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]] autorelease];
    currentMBProgressView.HUD.mode=MBProgressHUDModeCustomView;
    currentMBProgressView.HUD.labelText=CustomLocalizedString(@"网络异常",nil);
    [MBProgressController dismiss];
}

+(void)dismiss
{
    if (currentMBProgressView) {
        currentMBProgressView.message=nil;
        currentMBProgressView.safeConnet=NO;
        [currentMBProgressView.HUD hide:YES];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

+(void)cancel:(id)sender
{
    [MBProgressController dismiss];
    if (currentMBProgressView.delegate)
    {
        [currentMBProgressView.delegate cancelTheRequest];
        if ([MBProgressController getCurrentController].isCancleBlock)
        {
            [MBProgressController getCurrentController].isCancleBlock(YES);
        }
    }
}



-(void)dealloc
{
    self.HUD=nil;
    self.message=nil;
    self.staticClick=nil;
    self.isCancleBlock=nil;
    [super dealloc];
}


#pragma mark -- MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

#pragma mark -- ASIProgressDelegate methods

- (void)setProgress:(float)newProgress {//进度条的代理
	NSLog(@"------%f",newProgress);
    if (newProgress>0)
    {
        
        //           self.staticClick.frame=CGRectMake(95, 275, 130, 30);
        self.HUD.mode = MBProgressHUDModeDeterminate;
        self.HUD.labelText = CustomLocalizedString(@"读取中",nil);
        self.HUD.progress=newProgress;
        
    }
}
@end