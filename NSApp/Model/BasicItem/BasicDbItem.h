//
//  BasicDbItem.h
//  WorldTimer
//
//  Created by DongCai on 6/9/14.
//  Copyright (c) 2014 ___DanielStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBService.h"

@interface BasicDbItem : NSObject

+(NSArray *)getAllFromDB;
-(BOOL)saveToDB;
-(BOOL)deleteFromDB;

@end
