//
//  WeekViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "WeekViewController.h"
#import "DayViewController.h"
#import "MonthViewController.h"
@interface WeekViewController ()

@end

@implementation WeekViewController
@synthesize currentDate,dateR,leftUpdateDate,rightUpdateDate,screenUpdateDate,Left,Right,prev,curr,next,swipe;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)LeftSwipe:(id)sender {
    // instantiate a NSDateFormatter
    swipe=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"w,MMMM,yyyy"];
    
    
    NSTimeInterval aWeek = 7*24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:-aWeek];
    
    leftUpdateDate= [currentDate dateByAddingTimeInterval:-2*aWeek];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:-aWeek];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *weekViewLeft = [[NSString alloc] initWithFormat:@"Week%@",dateInString2];
    
    [engine speak:weekViewLeft];
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:currentdayInMonth1];
    
    [curr setText:msg2];
    [prev setText:msg3];
}
- (IBAction)RightSwipe:(id)sender {
    // instantiate a NSDateFormatter
    swipe=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"w,MMMM,yyyy"];
    
    NSTimeInterval aWeek = 7*24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:+aWeek];
    
    rightUpdateDate= [currentDate dateByAddingTimeInterval:+2*aWeek];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: rightUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:+aWeek];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *weekViewRight = [[NSString alloc] initWithFormat:@"Week%@",dateInString2];
    
    [engine speak:weekViewRight];
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
    
    
    
}
- (void) getSunday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"ee"];
    
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *msg = [[NSString alloc] initWithFormat:@"%@",dateInString];
    int a = [msg integerValue];
    if (msg == @"01") {
        return;
    }
    NSTimeInterval aDay = 24*60*60;
    while ( a> 1) {
        currentDate= [currentDate dateByAddingTimeInterval:-    aDay];
        a--;
    }
    return;
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"backDayView"]){
        DayViewController *dvc = [segue destinationViewController];
        if(swipe)
            [self getSunday];
        [dvc setCurrentDate:currentDate];
    }
    else if ([segue.identifier isEqualToString:@"goMonthView"]){
        MonthViewController *mvc = [segue destinationViewController];
        [mvc setCurrentDate:currentDate];
    }


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    dateR=[[NSDate alloc] init];
    
    NSDate *tomorrowDate;
    NSDate *yesterdayDate;
    
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"w,MMMM,yyyy"];
    
    // NSString *currentdayInMonth = [dateFormatter stringFromDate:currentDateTime];
    //NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",currentDateTime];
    NSTimeInterval aWeek = 7*24*60*60;
    // add one date by + aDay
    tomorrowDate = [currentDate dateByAddingTimeInterval:aWeek];
    //NSString *tomorrowInMonth = [dateFormatter stringFromDate:tomorrowDate];
    // decre one date by - aDay
    yesterdayDate= [currentDate dateByAddingTimeInterval:-aWeek];
    //NSString *yesterdayInMonth = [dateFormatter stringFromDate:yesterdayDate];
    
    
    // NSString *message2 = [[NSString alloc] initWithFormat:@"%@",tomorrowDate];
    // NSString *message3 = [[NSString alloc] initWithFormat:@"%@",yesterdayDate];
    //get the substring from different.
    // get the substring from current
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: tomorrowDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: yesterdayDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [curr setText:currentdayInMonth1];
    
    [next setText:msg2];
    [prev setText:msg3];
    // Do any additional setup after loading the view, typically from a nib.
	// Do any additional setup after loading the view.
    
    NSString *weekView = [[NSString alloc] initWithFormat:@"Week, View, Week%@",dateInString];
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    [engine speak:weekView];
    
    //************************* General Events ***************************
    // All of the days of the week in string with this format: DD/MM/YYYY to be named correctly as Monday, Sunday,....

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}

@end
