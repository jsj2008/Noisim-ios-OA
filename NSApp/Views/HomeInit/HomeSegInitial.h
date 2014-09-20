//
//  HomeSegInitial.h
//  NSApp
//
//  Created by DongCai on 9/3/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSegmentedControl.h"

@interface HomeSegInitial : NSObject

+(NSArray *)titles;
+(NSArray *)views;
+(HMSegmentedControl *)initSegmentControl;
@property(strong, nonatomic)UIViewController *vc;
@end
