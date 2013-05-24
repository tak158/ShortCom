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
#import <QuartzCore/QuartzCore.h>
#import "User.h"

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
  
  // ユーザアカウントを取得
  _userData = [NSUserDefaults standardUserDefaults];
  
  // アカウント情報が正しいか確認
  NSLog(@"name : %@", [_userData stringForKey:@"USER_NAME"]);
  NSLog(@"id : %d", [_userData integerForKey:@"USER_ID"]);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


// 定期的に処理する関数
- (void)timerInfo
{  
  // ThreadIdをもとにその掲示板の(サーバ内にある)最新5件のCommentを取得する
  NSMutableArray* recentComments = [Comment getComments:self.boardId];
  // 新規CommentのcommentIdを取得する
  NSMutableArray* recentCommentIds = [[NSMutableArray alloc] init];
  // Commentidのみ取得する
  for (int i=0; i<5; i++) {
    Comment* tmpComment = recentComments[i];
    [recentCommentIds addObject:tmpComment.commentId];
  }
  
  /*--------------------------------------------------------
   CommentIdはすべて配列に(NSNumber *)型として格納すること！
   --------------------------------------------------------*/
  
  // 旧5件Commentのidを取得するし、その最大値を保存する
  NSInteger maxCommentId = 0;
  for (int i=0; i<5; i++) {
    Comment* tmpComment = _comments[i];
//    [oldCommentIds addObject:tmpComment.commentId];
    if ([tmpComment.commentId compare:[NSNumber numberWithInteger:maxCommentId]] == NSOrderedDescending) {
      maxCommentId = [tmpComment.commentId intValue];
    }
  }
  
  // 新しく取得したCommentのidが、旧コメントのidを超えているかを確認する
  for (int i=4; i>=0; i--) {
    Comment* tmpComment = recentComments[i];
    if ([tmpComment.commentId compare:[NSNumber numberWithInteger:maxCommentId]] == NSOrderedDescending) {
      NSInteger randPosition = arc4random_uniform(5);
      CommentViewCell* cell = (CommentViewCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:randPosition inSection:0]];
      UILabel* label = (UILabel*)[cell viewWithTag:1];
      UILabel* userLabel = (UILabel *)[cell viewWithTag:3];
      Comment* tmpComment = recentComments[i];  // 配列の添字を使いつつプロパティ参照ができないようなので仮のオブジェクトを用意しておく
      label.text = tmpComment.note;
      userLabel.text = [User getUserName:[tmpComment.userId intValue]];
      
      // またここで_comments[randPosition]を更新する
      _comments[randPosition] = tmpComment;
      
      // アニメーションによる擬似的な挿入処理
      [UIView beginAnimations:nil context:NULL];
      cell.frame = CGRectMake(self.view.frame.size.width, cell.bounds.size.height*randPosition, cell.bounds.size.width, cell.bounds.size.height);
      cell.frame = CGRectMake(0, cell.bounds.size.height*randPosition, cell.bounds.size.width, cell.bounds.size.height);
      [UIView setAnimationDuration:0.2+i*0.4];
      [UIView commitAnimations];
      // ここまでアニメーション
      
//      [cell setNeedsLayout];
    }
  }
  
  /*
  // 最新5件のCommentが旧5件のものとかぶっているか比較する
  for (int i=0; i<5; i++) {
    NSNumber* tmpRecentCommentId = recentCommentIds[i];
    // 既存と同じセルがあればそのまま次の処理へ
    if ([oldCommentIds containsObject:tmpRecentCommentId]) {
      NSLog(@"かぶったよ〜");
    // ない場合はランダムにセルをとり
    // その場所を更新する
    }else{
      NSInteger randPosition = 4;
      NSLog(@"かぶらなかったよ〜");
      CommentViewCell* cell = (CommentViewCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:randPosition inSection:0]];
      UILabel* label = (UILabel*)[cell viewWithTag:1];
      UILabel* userLabel = (UILabel *)[cell viewWithTag:3];
      Comment* tmpComment = recentComments[i];  // 配列の添字を使いつつプロパティ参照ができないようなので仮のオブジェクトを用意しておく
      label.text = tmpComment.note;
      userLabel.text = [User getUserName:[tmpComment.userId intValue]];
      
      // またここで_comments[randPosition]を更新する
      _comments[randPosition] = tmpComment;
      
      
      // アニメーションによる擬似的な挿入処理
      [UIView beginAnimations:nil context:NULL];
      cell.frame = CGRectMake(self.view.frame.size.width+i*90, cell.bounds.size.height*i, cell.bounds.size.width, cell.bounds.size.height);
      cell.frame = CGRectMake(0, cell.bounds.size.height*i, cell.bounds.size.width, cell.bounds.size.height);
      [UIView setAnimationDuration:0.2+i*0.4];
      [UIView commitAnimations];
      // ここまでアニメーション

      [cell setNeedsLayout];
       
    }
  }
*/
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
  return 5;
}

// Commentの初期設定を行うメソッド
- (void)setupComment
{
  _comments = [Comment getComments:self.boardId];

  return;
}

// 1つのCellの情報を更新する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CommentViewCell* cell = (CommentViewCell*)[tableView dequeueReusableCellWithIdentifier:@"BoardCell" forIndexPath:indexPath];
  
  // cellの形の変更
  CALayer* layer = [cell layer];
  [layer setMasksToBounds:YES];
  [layer setCornerRadius:20.0f];
  [layer setBorderWidth:0.2f];
  [layer setBorderColor:[[UIColor orangeColor] CGColor]];
  
  if (indexPath.row < _comments.count) {
    Comment* comment = _comments[indexPath.row];
    UILabel* idLabel = (UILabel *)[cell viewWithTag:1];
    UILabel* userLabel = (UILabel *)[cell viewWithTag:3];
    if (![comment.note isEqual: @"snthd"]) {
      idLabel.text = [NSString stringWithFormat:@"%@", comment.note];
      userLabel.text = [NSString stringWithFormat:@"%@", [User getUserName:[comment.userId intValue]]];
    }else{
      idLabel.text = [NSString stringWithFormat:@"kari"];
    }
  }

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

  Comment* comment = [Comment commentWithNote:postModal.postText.text threadId:self.boardId userId:[NSNumber numberWithInt:[_userData integerForKey:@"USER_ID"]]];
  [_comments addObject:comment];
  comment.save;
  [_tableView reloadData];
  _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerInfo) userInfo:nil repeats:YES];
}

// 別の画面に遷移する直前のメソッド
- (void)viewWillDisappear:(BOOL)animated
{
  [_timer invalidate];
}


@end
