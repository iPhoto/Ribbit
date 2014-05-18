//
//  NSignupViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NSignupViewController.h"
#import <parse/Parse.h>

@interface NSignupViewController ()

@end

@implementation NSignupViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)signup:(id)sender {
    
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *firstname = [self.firstnameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *lastname = [self.lastnameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *hometown = [self.hometownField.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *website = [self.websiteField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([username length] == 0 || [password length] == 0 ||[email length]==0 || [firstname length] == 0 || [lastname length] == 0 ||[hometown length]==0 || [website length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"oops!" message:@"Make sure you enter all necessary information!" delegate:nil cancelButtonTitle:@"ok!" otherButtonTitles:nil];
        [alertView show];
        
    }
    else{
    
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email   = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else{
            
                PFObject *additionalInformation = [PFObject objectWithClassName:@"Additional"];
                additionalInformation[@"Firstname"] = firstname;
                additionalInformation[@"Lastname"] = lastname;
                additionalInformation[@"Hometown"] = hometown;
                additionalInformation[@"Website"] = website;
                
                PFUser *currentUser =[PFUser currentUser];
                additionalInformation[@"User"] = currentUser;
                [additionalInformation save];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            
            
            
            }
        }];
    
       
    
    
    }
    
    
    
    
    
}
@end
