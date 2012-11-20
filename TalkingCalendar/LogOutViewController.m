//
//  LogOutViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "LogOutViewController.h"
#import "SyncViewController.h"

@interface LogOutViewController ()

@end

@implementation LogOutViewController
@synthesize tutorialMode;


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"LogoutToSync"]){
        SyncViewController *svc2 = [segue destinationViewController];
        svc2.tutorialMode = self.tutorialMode;
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
    
    NSLog(@"TutorialMode is ");
    if (tutorialMode) {
        NSLog(@"ON");
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
