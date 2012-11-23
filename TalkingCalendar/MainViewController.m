//
//  MainViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "MainViewController.h"
#import "ESpeakEngine.h"
#import "DayViewController.h"
#import "AppDelegate.h"
#import "LogOutViewController.h"
#import "ReportViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize reminder;
@synthesize reminderTomorrow;
@synthesize ge;
@synthesize welcome;
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
            [engine speak: @"To access the Settings page, swipe left or right. To open the calendar, double tap the screen. ."];
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


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
    [engine2 stop];
    
    if([segue.identifier isEqualToString:@"mainToDay"]){
        DayViewController * dvc=[segue destinationViewController];
        [dvc setUserName:userName];
        [dvc setWhatConfrim:0];
    }
    if([segue.identifier isEqualToString:@"mainToReport"]){
        ReportViewController * dvc=[segue destinationViewController];
        [dvc setUserName:userName];
    }
    if([segue.identifier isEqualToString:@"mainToLogout"]){
        LogOutViewController * lvc=[segue destinationViewController];
        [lvc setUserName:userName];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [welcome setText:userName];
    NSLog(userName);
    
    
     //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"testPicture.png"]]];
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    NSTimeInterval aDay = 24*60*60;
    NSDate *today=[[NSDate alloc] init];
    NSDate *tomorrowDate;
    tomorrowDate = [today dateByAddingTimeInterval:aDay];
    
    NSString *dateInString = [dateFormatter stringFromDate: today];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    NSString *dateInString2 = [dateFormatter stringFromDate: tomorrowDate];
    NSString *tomorrow2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
  
    //NSLog(currentdayInMonth1);
    //NSLog(tomorrow2);
     
    ge=[[GeneralEvents alloc]init];
   
    //Text to speech : "To toggle the Tutorial, shake the phone."
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:165];
    
    engine2 = [[ESpeakEngine alloc] init];
    [engine2 setLanguage:@"en"];
    [engine2 setSpeechRate:165];
    
   
    if (tutorialMode) {
        NSLog(@"Tutorial mode is on");
     
        NSString * holidays =[[NSString alloc]initWithFormat:@"To access the Settings page, swipe left or right. To open the calendar, double tap the screen,%Today: %@. Tomorrow: %@", [ge searchGEfor:currentdayInMonth1],[ge searchGEfor:tomorrow2]];
        [engine2 speak:holidays];
        
       }
    else if (!(tutorialMode)) {
                NSLog(@"Tutorial mode is off");
        NSString * holidays =[[NSString alloc]initWithFormat:@"%Today: %@. Tomorrow: %@", [ge searchGEfor:currentdayInMonth1],[ge searchGEfor:tomorrow2]];
        [engine speak:holidays];
    }

	[reminder setText:[ge searchGEfor:currentdayInMonth1]];
    [reminderTomorrow setText:[ge searchGEfor:tomorrow2]];
    // This function (ge) returns a string - read out this string.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setReminder:nil];
    [self setReminderTomorrow:nil];
    [self setWelcome:nil];
    [super viewDidUnload];
    [engine stop];
}


@end
