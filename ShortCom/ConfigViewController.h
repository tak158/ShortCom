//
//  ConfigViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/22.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@end
