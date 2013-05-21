//
//  BoardViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "BoardViewController.h"
#import <Social/Social.h>
#import "PostModalViewController.h"
#import "CommentViewCell.h"

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
  
  //タイマー絡みのプログラム
  _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerInfo) userInfo:nil repeats:YES];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


// 定期的に処理する関数
- (void)timerInfo
{
  CommentViewCell* cell = (CommentViewCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  UILabel* label = (UILabel*)[cell viewWithTag:1];
  label.text = @"you are not alone.";
  // アニメーションを実装してみる
  [UIView beginAnimations:nil context:NULL];
  cell.frame = CGRectMake(self.view.frame.size.width, 0, cell.bounds.size.width, cell.bounds.size.height);
  cell.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
  [UIView commitAnimations];
  // ここまでアニメーション
  //  cell.textLabel.text = @"aoeu";
  [cell setNeedsLayout];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

- (IBAction)pushedButton:(id)sender
{
  PostModalViewController* modalView = [[PostModalViewController alloc] init];
  [self presentViewController:modalView animated:YES completion:NULL];
  
}

// 画面のCellは5個しか表示しない
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"テーブル数の設定");
  return 5;
  
}

// Commentの初期設定を行うメソッド
- (void)setupComment
{
  _comments = [Comment getComments:self.boardId];

  return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CommentViewCell* cell = (CommentViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BoardCell" forIndexPath:indexPath];
  NSLog(@"indexPath.row is %d", indexPath.row);
  if (indexPath.row < _comments.count) {
    Comment* comment = _comments[indexPath.row];
    UILabel* idLabel = (UILabel *)[cell viewWithTag:1];
    idLabel.text = [NSString stringWithFormat:@"%@", comment.note];
  }

  NSLog(@"%@", cell.textLabel.text);
  return cell;
}

// Cellが表示される直前に実行されるメソッド
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  // For even
  if (indexPath.row % 2 == 0) {
    cell.backgroundColor = [UIColor whiteColor];
  }
  // For odd
  else {
    cell.backgroundColor = [UIColor colorWithHue:0.61
                                      saturation:0.09
                                      brightness:0.99
                                           alpha:1.0];
  }
}

- (IBAction)commentUpdated:(UIStoryboardSegue *)segue
{
  PostModalViewController* postModal = [segue sourceViewController];

  Comment* comment = [Comment commentWithNote:postModal.postText.text threadId:self.boardId userId:[NSNumber numberWithInt:1]];
  [_comments addObject:comment];
  [_tableView reloadData];
  comment.save;
}

// 別の画面に遷移する直前のメソッド
- (void)viewWillDisappear:(BOOL)animated
{
  NSLog(@"move!");
  [_timer invalidate];
}


@end
