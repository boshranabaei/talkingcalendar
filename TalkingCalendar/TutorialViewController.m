//
//  TutorialViewController.m
//  TalkingCalendar
//
//  Created by Pamela Lee on 11/16/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "TutorialViewController.h"
#import "SyncViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

@synthesize tutorialMode;




- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"goSyncView"]){
        SyncViewController *svc = [segue destinationViewController];
        svc.tutorialMode = YES;
    }
}


-(IBAction)doubleTap:(id)sender {
    if (tutorialMode) {
        tutorialMode = NO;
    }
    else {
        tutorialMode = YES;
        NSLog(@"Tutorial Mode has been turned on.");

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
