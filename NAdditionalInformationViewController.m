//
//  NAdditionalInformationViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 5/18/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NAdditionalInformationViewController.h"

@interface NAdditionalInformationViewController ()

@end

@implementation NAdditionalInformationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"additionalInformation"];
    [query whereKey:@"user" equalTo:self.user];
    
   
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            
            NSLog(@"error %@ %@", error, [error userInfo]);
            
        }
        else{
            NSArray *usersDetails = [query findObjects];
            NSLog(@"%@", usersDetails);
            
            
        }
    }];
    
    
  
}




@end
