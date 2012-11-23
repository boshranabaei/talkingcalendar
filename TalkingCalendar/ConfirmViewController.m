//
//  ConfirmViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/20/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "ConfirmViewController.h"
#import "DayViewController.h"
#import "ESpeakEngine.h"
#import "AppDelegate.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

@synthesize userName;
@synthesize decision;
@synthesize currentDate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    [engine stop];
        DayViewController * dvc=[segue destinationViewController];
        [dvc setUserName:userName];
        [dvc setCurrentDate:currentDate];
        [dvc setWhatConfrim:decision];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    decision=0;
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:165];
    [engine speak:@"an event was saved before, to delete,  double tap, to overwrite, press for three seconds. to cancel, drag left or right"];    
    
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

- (IBAction)longPress:(id)sender {
    decision=1;
    [self performSegueWithIdentifier:@"backAfterConfirm" sender:self];
    
}

- (IBAction)swipeRight:(id)sender {
    [self performSegueWithIdentifier:@"backAfterConfirm" sender:self];
}

- (IBAction)doubleTab:(id)sender {
    decision=2;
    [self performSegueWithIdentifier:@"backAfterConfirm" sender:self];
}
- (IBAction)swipeLeft:(id)sender {
    [self performSegueWithIdentifier:@"backAfterConfirm" sender:self];
}
@end
