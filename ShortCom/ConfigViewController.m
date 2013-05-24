//
//  ConfigViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/22.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  _userNameText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"USER_NAME"];
  
  _pickerController = [[UIImagePickerController alloc] init];
  _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  _pickerController.delegate = self;
  [self presentViewController:_pickerController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)closeConfigModal:(id)sender {
  [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}
- (IBAction)didPushButton:(id)sender {
  NSLog(@"oreore");
  [self presentViewController:_pickerController animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  NSLog(@"ここ通ってますか？");
  [self dismissViewControllerAnimated:YES completion:NULL];
  _userImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];  
}
@end
