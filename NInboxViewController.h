//
//  NInboxViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface NInboxViewController : UITableViewController
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessages;

- (IBAction)logout:(id)sender;

@end
