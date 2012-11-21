//
//  SyncViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "SyncViewController.h"
#import "TutorialViewController.h"
#import "LogOutViewController.h"
#import "ESpeakEngine.h"
#import "AppDelegate.h"

@interface SyncViewController ()

@end
//Hello
@implementation SyncViewController
//@synthesize tutorialMode;

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
            [engine speak:@"To access the log out page, swipe left or right. To sync your data, double tap the screen"];
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
    
    /*
    if([segue.identifier isEqualToString:@"syncToTutorial"]){
        TutorialViewController *tvc = [segue destinationViewController];
        tvc.tutorialMode = self.tutorialMode;
    }
   
    
    if([segue.identifier isEqualToString:@"syncToLogOutRight"]){
        LogOutViewController *lvc = [segue destinationViewController];
        lvc.tutorialMode = self.tutorialMode;
    }
    
    if([segue.identifier isEqualToString:@"syncToLogOutLeft"]){
        LogOutViewController *lvc = [segue destinationViewController];
        lvc.tutorialMode = self.tutorialMode;
    }
     */
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:170];
     
     
    NSLog(@"TutorialMode is ");
    if (tutorialMode) {
        NSLog(@"ON");
        [engine speak:@"To access the log out page, swipe left or right. To sync your data, double tap the screen"];
        
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
