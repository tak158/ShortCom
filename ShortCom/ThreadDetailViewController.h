//
//  ThreadDetailViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thread.h"

@interface ThreadDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) Thread* thread;
@end
