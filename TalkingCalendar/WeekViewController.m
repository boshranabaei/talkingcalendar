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
#import "ESpeakEngine.h"
#import "AppDelegate.h"
@interface WeekViewController ()

@end

@implementation WeekViewController
@synthesize currentDate,dateR,leftUpdateDate,rightUpdateDate,screenUpdateDate,Left,Right,prev,curr,next,swipe;
@synthesize userName;
@synthesize dateSun;
@synthesize vrp;

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
            
            NSString *weekView2 = [[NSString alloc] initWithFormat:@"Swipe up or down to access the month view or the day view respectively. To change the week, swipe left or right"];
            
            [engine speak:weekView2];
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


- (IBAction)LeftSwipe:(id)sender {
    // instantiate a NSDateFormatter
    swipe=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy\nMMMM\n\n\nw"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"w"];
    
    
    NSTimeInterval aWeek = 7*24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:-aWeek];
    
    leftUpdateDate= [currentDate dateByAddingTimeInterval:-2*aWeek];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:-aWeek];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    //NSString *weekViewLeft = [[NSString alloc] initWithFormat:@"Week%@",dateInString2];
    
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"w,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    NSString *weekView2 = [[NSString alloc] initWithFormat:@"%@", testDate1];
    
    
    
    
    
    
    [self getSunday];
    NSDate *tmp=dateSun;
    NSString *dateInString4;
    NSString *msg4;
    NSTimeInterval aDay = 24*60*60;
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    dateInString4 = [dateFormatter stringFromDate: tmp];
    msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
    int howManyEvents=0;
    if([vrp hasEvent:userName date:msg4]){
        howManyEvents++;
    }
    for (int counter=1; counter<7; counter++) {
        tmp= [tmp dateByAddingTimeInterval:aDay];
        dateInString4 = [dateFormatter stringFromDate: tmp];
        msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
        if([vrp hasEvent:userName date:msg4]){
            howManyEvents++;
        }
    }
    
    
    NSString *say;
    if(howManyEvents==0){
        say = [[NSString alloc] initWithFormat:@"%@. No events are in this week.", weekView2];
    }
    else{
        say= [[NSString alloc] initWithFormat:@"%@. %i events are in this week.", weekView2, howManyEvents];
    }
    
    [engine speak:say];
    

    
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
    [dateFormatter setDateFormat:@"yyyy\nMMMM\n\n\nw"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"w"];
    
    NSTimeInterval aWeek = 7*24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:+aWeek];
    
    rightUpdateDate= [currentDate dateByAddingTimeInterval:+2*aWeek];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: rightUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:+aWeek];
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"w,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    NSString *weekView2 = [[NSString alloc] initWithFormat:@"%@", testDate1];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *weekViewRight = [[NSString alloc] initWithFormat:@"Week%@",dateInString2];
    
    [self getSunday];
    NSDate *tmp=dateSun;
    NSString *dateInString4;
    NSString *msg4;
    NSTimeInterval aDay = 24*60*60;
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    dateInString4 = [dateFormatter stringFromDate: tmp];
    msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
    int howManyEvents=0;
    if([vrp hasEvent:userName date:msg4]){
        howManyEvents++;
    }
    for (int counter=1; counter<7; counter++) {
        tmp= [tmp dateByAddingTimeInterval:aDay];
        dateInString4 = [dateFormatter stringFromDate: tmp];
        msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
        if([vrp hasEvent:userName date:msg4]){
            howManyEvents++;
        }
    }

    
    NSString *say;
    if(howManyEvents==0){
        say = [[NSString alloc] initWithFormat:@"%@. No events are in this week.", weekView2];
    }
    else{
        say= [[NSString alloc] initWithFormat:@"%@. %i events are in this week.", weekView2, howManyEvents];
    }
    
    [engine speak:say];
    
    

    
    
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
        dateSun= [currentDate dateByAddingTimeInterval:-    aDay];
        a--;
    }
    return;
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
    if([segue.identifier isEqualToString:@"backDayView"]){
        DayViewController *dvc = [segue destinationViewController];
        if(swipe)
            [self getSunday];
        currentDate=dateSun;
        [dvc setCurrentDate:currentDate];
        [dvc setUserName:userName];
        [dvc setWhatConfrim:0];
    }
    else if ([segue.identifier isEqualToString:@"goMonthView"]){
        MonthViewController *mvc = [segue destinationViewController];
        [mvc setCurrentDate:currentDate];
        [mvc setUserName:userName];
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
    [dateFormatter setDateFormat:@"yyyy\nMMMM\n\n\nw"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"w"];
    
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
    
    NSString *dateInString2 = [dateFormatter2 stringFromDate: tomorrowDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: yesterdayDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"w,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    //NSString *weekView2 = [[NSString alloc] initWithFormat:@"%@", testDate1];
    
    
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
    

    NSString *weekView = [[NSString alloc] initWithFormat:@"Week, View, Week%@",testDate];
    
    //************************* General Events ***************************
    
    vrp=[[voiceRecPlay alloc]init];
    
    
    [self getSunday];
    NSDate *tmp=dateSun;
    NSString *dateInString4;
    NSString *msg4;
    NSTimeInterval aDay = 24*60*60;
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    dateInString4 = [dateFormatter stringFromDate: tmp];
    msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
    int howManyEvents=0;
    if([vrp hasEvent:userName date:msg4]){
        howManyEvents++;
    }
    for (int counter=1; counter<7; counter++) {
        tmp= [tmp dateByAddingTimeInterval:aDay];
        dateInString4 = [dateFormatter stringFromDate: tmp];
        msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
        if([vrp hasEvent:userName date:msg4]){
            howManyEvents++;
        }
    }
    // ############### week starts from Monday.

    
    
      //************************* Espeak ***************************
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    
    
    
    //NSDate *testWeek = [[NSDate alloc] init];
    //*testWeek = [week currentDate];
    //NSCalendar *calendar = [[NSCalendar alloc] init];
    //NSUInteger weeks = NSWeekCAlendarUnit;
    //NSDateComponents *components = [calendar components:weeks fromDate:[currentDate] options:0];
    //NSUInteger *testWeek = [components week];
    
    if (tutorialMode) {
        NSLog(@"Tutorial Mode is on : will speak everything");
        NSString *weekView2;
        if(howManyEvents==0){
        weekView2 = [[NSString alloc] initWithFormat:@"%@. No events are in this week. Swipe up or down to access the month view or the day view respectively. To change the week, swipe left or right", weekView];
        }
        else{
        weekView2 = [[NSString alloc] initWithFormat:@"%@. %i events are in this week. Swipe up or down to access the month view or the day view respectively. To change the week, swipe left or right", weekView, howManyEvents];
        }

        [engine speak:weekView2];
    }
    else if (!(tutorialMode)) {
        NSString *say;
        if(howManyEvents==0){
            say = [[NSString alloc] initWithFormat:@"%@. No events are in this week.", weekView];
        }
        else{
            say= [[NSString alloc] initWithFormat:@"%@. %i events are in this week.", weekView, howManyEvents];
        }
        
        [engine speak:say];
    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [engine stop];
    // Release any retained subviews of the main view.
}

@end
