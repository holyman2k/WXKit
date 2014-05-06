//
//  WXTableViewController.m
//  WXKit
//
//  Created by Charlie Wu on 5/05/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXTableViewController.h"
#import "WXTextInput.h"
#import "WXTextLabel.h"

@interface WXTableViewController ()
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSDictionary *values;
@end

@implementation WXTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"D6B849" withAlpha:1];
    self.labels = @[@"Description", @"Location", @"Service", @"Due Date", @"Assignee"];
    self.values = @{self.labels[0] : @"Broken Window",
                    self.labels[1] : @"Westmead Hopsital - Building A - Level 2 - Room 126",
                    self.labels[2] : @"Building Service - Window"};
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.labels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    WXTextLabel *textField = cell.contentView.subviews.firstObject;

    textField.labelText = self.labels[indexPath.row];
    textField.text = self.values[textField.labelText];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *label = self.labels[indexPath.row];
    NSString *text = self.values[label];
    static CGFloat textFieldWidth;
    static CGFloat otherFieldHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textFieldWidth = self.view.frame.size.width - 16 - WXTextLabel.leftRightPadding;
        otherFieldHeight = WXTextLabel.topBottomPadding + WXTextLabel.labelHeight;
    });

    return MAX([text heightForFont:[UIFont systemFontOfSize:15] andWidth:textFieldWidth] + otherFieldHeight, WXTextLabel.defaultHeight);
}
@end
