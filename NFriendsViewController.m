//
//  NFriendsViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 5/1/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NFriendsViewController.h"
#import "NEditFriendsViewController.h"
#import "NAdditionalInformationViewController.h"
#import "GravatarUrlBuilder.h"

@interface NFriendsViewController ()

@end

@implementation NFriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
   
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
    else if( [segue.identifier isEqualToString:@"ShowAdditionalInformation"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NAdditionalInformationViewController *detailController = (NAdditionalInformationViewController *) segue.destinationViewController;
        PFUser *user = [self.friends objectAtIndex:indexPath.row];
        detailController.user = user;
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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //1. Fet email address
        NSString *email = [user objectForKey:@"email"];
        //2. create the md5 hash
        NSURL *gravataUrl = [GravatarUrlBuilder getGravatarUrl:email];
        //3. Request the image from Gravatar
        NSData *imageData = [NSData dataWithContentsOfURL:gravataUrl];
        
        
        if (imageData != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //4. Set image in cell
                cell.imageView.image = [UIImage imageWithData:imageData];
                [cell setNeedsLayout];
            });
        }
      
});
    cell.imageView.image = [UIImage imageNamed:@"icon_person"];
    
       return cell;
}




@end
