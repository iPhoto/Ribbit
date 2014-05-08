//
//  NInboxViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NInboxViewController.h"
#import <Parse/Parse.h>

@interface NInboxViewController ()

@end

@implementation NInboxViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        NSLog(@"Current user : %@", currentUser.username);
    
    }
    else{
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}



- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {

    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }


}
@end
