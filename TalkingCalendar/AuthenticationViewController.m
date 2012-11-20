//
//  AuthenticationViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/5/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController
@synthesize accounts;
@synthesize userName;
@synthesize password;
@synthesize tutorialMode;


- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"Tutorial Mode has been toggled.");
        if (tutorialMode) {
            NSLog(@"Tutorial Mode has been turned off.");
            tutorialMode = NO;
        }
        else if (!(tutorialMode)) {
            tutorialMode = YES;
            NSLog(@"Tutorial Mode has been turned on.");
        }
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"gotomain"]){
    MainViewController * mvc=[segue destinationViewController];
    [mvc setUserName:[userName text]];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)login:(id)sender{
    [password resignFirstResponder];
    [userName resignFirstResponder];
    accounts=[[Accounts alloc]init];
   if([accounts validateUsername:[userName text] password:[password text]]){
       NSLog(@"Test");
       [self performSegueWithIdentifier:@"gotomain" sender:self];
      NSLog(@"Test2");
    }
   else{
       UIAlertView *notValid=[[UIAlertView alloc]initWithTitle:@"Authentication"
                                                 message:@"The username or password is invalid!"
                                                 delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil, nil];
       [notValid show];
   }
        
     
  }

- (IBAction)dissmissKeyboard:(id)sender {
    [password resignFirstResponder];
    [userName resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
