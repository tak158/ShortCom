//
//  BoardViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "BoardViewController.h"
#import <Social/Social.h>

@interface BoardViewController ()

@end

@implementation BoardViewController

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
  [self setupComment];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

- (IBAction)pushedButton:(id)sender
{
  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
    SLComposeViewController* composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //個々で代入するデータを用意する必要があるかもしれない
    
    [self presentViewController:composeViewController animated:YES completion:nil];
  }
  
  
  Comment* comment = [Comment commentWithNote:_inputText.text];
  [_comments addObject:[Comment commentWithNote:_inputText.text]];
  [comment save];
  [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"テーブル数の設定");
  return [_comments count];
}

- (void)setupComment
{
  _comments = [[NSMutableArray alloc] init];
  _comments = [[Comment all] mutableCopy];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BoardCell" forIndexPath:indexPath];
  Comment* comment = _comments[indexPath.row];
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@", comment.note];
  NSLog(@"%@", cell.textLabel.text);
  return cell;
}

@end
