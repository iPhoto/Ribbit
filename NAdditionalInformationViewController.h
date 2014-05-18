//
//  NAdditionalInformationViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 5/18/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NAdditionalInformationViewController : UIViewController

@property (nonatomic, strong) PFUser *user;
@property (weak, nonatomic) IBOutlet UITextView *detailText;

@end
