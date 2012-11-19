//
//  MainViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "MainViewController.h"
#import "ESpeakEngine.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize reminder;
@synthesize reminderTomorrow;
@synthesize ge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
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
    
    
    NSString * holidays =[[NSString alloc]initWithFormat:@"To toggle the tutorial, shake the phone. %Today: %@. Tomorrow: %@", [ge searchGEfor:currentdayInMonth1],[ge searchGEfor:tomorrow2]];
    [engine speak:holidays];

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
    [super viewDidUnload];
}


@end
