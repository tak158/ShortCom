//
//  ConfigViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/22.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UIButton *openPickerButton;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (IBAction)didPushButton:(id)sender;

@property (strong, nonatomic) UIImagePickerController* pickerController;

@end
