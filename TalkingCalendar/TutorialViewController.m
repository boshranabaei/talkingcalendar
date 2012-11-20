//
//  TutorialViewController.m
//  TalkingCalendar
//
//  Created by Pamela Lee on 11/16/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "TutorialViewController.h"
#import "SyncViewController.h"
#import "AppDelegate.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController
@synthesize tap;

@synthesize test;
//@synthesize tutorialMode;


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    /*
    if([segue.identifier isEqualToString:@"tutorialToSync"]){
        SyncViewController *svc = [segue destinationViewController];
        svc.tutorialMode = self.tutorialMode;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)viewDidUnload
{
    [self setTap:nil];
    [self setTest:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// DEFAULT: TUTORIAL MODE IS OFF
- (IBAction)doubleTap:(id)sender {
    
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
@end
