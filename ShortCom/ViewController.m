//
//  ViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "ViewController.h"
#import "Thread.h"
#import "ThreadDetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSLog(@"data is : %@", [Thread all]);
  [self setupThread];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setupThread
{
  _threads = [[NSMutableArray alloc] init];
  _threads = [[Thread all] mutableCopy];
  NSLog(@"%@", _threads);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_threads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadCell" forIndexPath:indexPath];
  Thread* thread = _threads[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", thread.name, thread.commentCount];
  return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
  [super setEditing:editing animated:animated];
  [_tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_threads[indexPath.row] destroy];
    [_threads removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  ThreadDetailViewController* detailViewController = [segue destinationViewController];
  if ([[segue identifier] isEqualToString:@"new"]) {
    detailViewController.thread = [Thread threadWithName:@"" threadId:0];
    _updateIndexPath = [NSIndexPath indexPathForRow:[_threads count] inSection:0];
  }else if([[segue identifier] isEqualToString:@"edit"]){
    _updateIndexPath = _tableView.indexPathForSelectedRow;
    [self.tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
    detailViewController.thread = _threads[_updateIndexPath.row];
  }
}

- (IBAction)threadUpdated:(UIStoryboardSegue *)segue
{
  if (_updateIndexPath.row == [_threads count]) {
    ThreadDetailViewController* detailViewController = [segue sourceViewController];
    [_threads addObject:detailViewController.thread];
    [_tableView insertRowsAtIndexPaths:@[_updateIndexPath] withRowAnimation:UITableViewRowAnimationNone];
  }else{
    [_tableView reloadRowsAtIndexPaths:@[_updateIndexPath] withRowAnimation:UITableViewRowAnimationNone];
  }
  [_threads[_updateIndexPath.row] save];
}

@end
