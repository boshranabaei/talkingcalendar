//
//  SignUpViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/9/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "SignUpViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize userName;
@synthesize password;
@synthesize passConfirm;
@synthesize accounts;


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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setPassConfirm:nil];
    [super viewDidUnload];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)create:(id)sender {
    [userName resignFirstResponder];
    [password resignFirstResponder];
    [passConfirm resignFirstResponder];
    
    if(![[password text]isEqualToString:[passConfirm text]]){
        UIAlertView *notEq=[[UIAlertView alloc]initWithTitle:@"password"
                                               message:@"Password and confirmated password don't match!"
                                               delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
        [notEq show];
    }
    
    else{
    accounts=[[Accounts alloc]init];
    if([accounts insertusername:[userName text] password:[password text]]){
        [self performSegueWithIdentifier:@"zz" sender:self];
    }
    else{
        UIAlertView *exists=[[UIAlertView alloc]initWithTitle:@"signUp"
                                                message:@"The username already exists"
                                                delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
        [exists show];
    }}

}

- (IBAction)dismissKeyboard:(id)sender {
    [userName resignFirstResponder];
    [password resignFirstResponder];
    [passConfirm resignFirstResponder];
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
