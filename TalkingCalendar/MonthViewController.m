//
//  MonthViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "MonthViewController.h"
#import "YearViewController.h"
#import "ESpeakEngine.h"
#import "WeekViewController.h"
#import "AppDelegate.h"
@interface MonthViewController ()

@end

@implementation MonthViewController

@synthesize currentDate,dateR,leftUpdateDate,rightUpdateDate,screenUpdateDate,Left,Right,prev,curr,next,swipe;
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
            [engine speak:@"Swipe up or down to access the year view or the week view respectively. To change the month, swipe left or right."];
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
    
    swipe = YES;
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy\n\n\nMMMM"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"MMMM"];

    
    

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    screenUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setMonth:-2];
    leftUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];

    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    
    [dateComponents setMonth:-1];
    currentDate=[calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"MMMM,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    NSString *monthView2 = [[NSString alloc] initWithFormat:@"%@", testDate1];
    
    
    
    //NSString *monthViewLeft = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    [engine speak:monthView2];
    
    [next setText:currentdayInMonth1];
    [curr setText:msg2];
    [prev setText:msg3];
}
- (IBAction)RightSwipe:(id)sender {
    
    swipe = YES;
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy\n\n\nMMMM"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"MMMM"];
    

    
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:+1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    screenUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setMonth:+2];
    leftUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];

    
    
    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    
    // **** screenUpdateDate and leftUpdateDate ARE NULL!!!!!!!!!!
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    [dateComponents setMonth:+1];
    currentDate=[calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"MMMM,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    NSString *monthView2 = [[NSString alloc] initWithFormat:@"%@", testDate1];
    

    
    
    NSString *monthViewRight = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    [engine speak:monthView2];
    
    
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
    
    
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
    
    if([segue.identifier isEqualToString:@"goYearView"]){
        YearViewController *yvc = [segue destinationViewController];
        [yvc setCurrentDate:currentDate];
        [yvc setUserName:userName];
    }
    else if([segue.identifier isEqualToString:@"backWeekView"]){
        WeekViewController *wvc= [segue destinationViewController];
        [wvc setCurrentDate:currentDate];
        [wvc setUserName:userName];
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
    [dateFormatter setDateFormat:@"yyyy\n\n\nMMMM"];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter2 setDateFormat:@"MMMM"];
    
    

    
    
    
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:+1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    tomorrowDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setMonth:-1];
    yesterdayDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter2 stringFromDate: tomorrowDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: yesterdayDate];
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
    
    //NSString *monthView = [[NSString alloc] initWithFormat:@"Month, View, %@",dateInString];
    /*
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    */
    
    
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"MMMM,yyyy"];
    
    NSString *testDate = [dateFormatter3 stringFromDate: currentDate];
    NSString *testDate1 = [[NSString alloc] initWithFormat:@"%@", testDate];
    
    NSString *monthView2 = [[NSString alloc] initWithFormat:@"Month, View, %@", testDate1];
    
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    
    
    if (tutorialMode) {
        NSString *monthView = [[NSString alloc] initWithFormat:@"Swipe up or down to access the year view or the week view respectively. To change the month, swipe left or right%@",monthView2];
        
        [engine speak:monthView];
    }
    
    else if (!(tutorialMode)) {
           [engine speak:monthView2];
    }
    
 
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [engine stop];
    // Release any retained subviews of the main view.
}

- (IBAction)l:(id)sender {
}
@end
