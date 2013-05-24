//
//  PostModalViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/20.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardViewController.h"

@protocol InputTextDelegate;

@interface PostModalViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *postText;

@end
