//
//  BusinessViewController.h
//  NSApp
//
//  Created by DongCai on 8/10/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface BusinessViewController : ListViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;
@end
