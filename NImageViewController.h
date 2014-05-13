//
//  NImageViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 5/9/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface NImageViewController : UIViewController
@property (nonatomic, strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
