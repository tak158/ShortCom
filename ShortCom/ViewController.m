//
//  ViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "ViewController.h"
#import "Thread.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray* threads;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [self setupThread];
}

- (void)setupThread
{
  _threads = [[NSMutableArray alloc] init];
  [_threads addObject:[Thread threadWithName:@"やきうの実況"]];
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
  cell.textLabel.text = [NSString stringWithFormat:@"%@", thread.name];
  return cell;
}

@end
