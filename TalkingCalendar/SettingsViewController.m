//
//  SettingsViewController.m
//  TalkingCalendar
//
//  Created by Pamela Lee on 11/20/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "ESpeakEngine.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

//@synthesize tutorialMode;

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"Tutorial Mode has been toggled.");
        if (tutorialMode) {
            [engine stop];
            NSLog(@"Tutorial Mode has been turned off.");
            tutorialMode = NO;
        }
        else if (!(tutorialMode)) {
            tutorialMode = YES;
            NSLog(@"Tutorial Mode has been turned on.");
            [engine speak:@"To access the open calendar page, swipe left or right. To open the Settings, double tap the screen."];
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
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:170];
    
    if (tutorialMode) {
        [engine speak:@"To access the Open Calendar page, swipe left or right. To open the Settings, double tap the screen."];
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    [engine stop];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
