//
//  AuthenticationViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/5/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accounts.h"
#import "MainViewController.h"

@interface AuthenticationViewController : UIViewController

@property Accounts *accounts;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property BOOL tutorialMode;

-(IBAction)login:(id)sender;
- (IBAction)dissmissKeyboard:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
@end
