//
//  SignUpViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/9/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passConfirm;

- (IBAction)create:(id)sender;

@end
