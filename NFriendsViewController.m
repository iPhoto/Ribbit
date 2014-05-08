//
//  NFriendsViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 5/1/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NFriendsViewController.h"
#import "NEditFriendsViewController.h"
@interface NFriendsViewController ()

@end

@implementation NFriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
        
            NSLog(@"error %@ %@", error, [error userInfo]);
        
        }
        else{
            self.friends = objects;
            [self.tableView reloadData];
        
        
        
        }
    }];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{


    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
        NEditFriendsViewController *viewController = (NEditFriendsViewController *)segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
}




@end
