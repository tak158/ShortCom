//
//  PostModalViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/20.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "PostModalViewController.h"
#import "BoardViewController.h"

@interface PostModalViewController ()

@end

@implementation PostModalViewController
//@synthesize inputTextdelegate_;

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
  [_postText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeModalDialog:(id)sender {
  // デリゲートでテキストデータを渡す
//  [inputTextdelegate_ inputText:_postText.text];
  [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}




@end
