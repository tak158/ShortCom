//
//  ViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreadDetailViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSIndexPath* updateIndexPath;
@property (weak, nonatomic) IBOutlet UIToolbar *configBar;
@property (strong, nonatomic) NSMutableArray* threads;
@end
