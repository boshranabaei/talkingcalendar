//
//  LogOutViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "LogOutViewController.h"
#import "ReportViewController.h"
#import "MainViewController.h"
#import "EspeakEngine.h"
#import "AppDelegate.h"

@interface LogOutViewController ()

@end

@implementation LogOutViewController
@synthesize userName;


- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"Tutorial Mode has been toggled.");
        if (tutorialMode) {
            NSLog(@"Tutorial Mode has been turned off.");
            tutorialMode = NO;
            [engine stop];
        }
        else if (!(tutorialMode)) {
            tutorialMode = YES;
            NSLog(@"Tutorial Mode has been turned on.");
            [engine speak:@" To log out of the current account, double tap the screen.To access the report send page, swipe left. To access the Main page, swipe right."];
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


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [engine stop];
    
    //swipe left: LogOut to Report
    if([segue.identifier isEqualToString:@"logoutToReport"]){
        ReportViewController *svc2 = [segue destinationViewController];
        [svc2 setUserName:userName];
    }
    
    
    //swipe right: LogOut to Sync
    if([segue.identifier isEqualToString:@"logoutToMain"]){
        MainViewController *svc2 = [segue destinationViewController];
    [svc2 setUserName:userName];
    }

    

    
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
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:165];
    
    
    NSLog(@"TutorialMode is ");
    if (tutorialMode) {
        NSLog(@"ON");
        [engine speak:@"To log out of the current account, double tap the screen.To access the report send page, swipe left. To access the Main page, swipe right."];
    }
    else if (!(tutorialMode)) {
        NSLog(@"OFF");
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
