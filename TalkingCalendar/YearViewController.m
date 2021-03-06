//
//  YearViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "YearViewController.h"
#import "MonthViewController.h"
#import "EspeakEngine.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@interface YearViewController ()

@end


@implementation YearViewController

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
            
            [engine speak:@"Swipe down to access the week view. To change the year, swipe left or right. To return to the open calendar menu, swipe up"];
            
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"YYYY"];
    
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:-1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    screenUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setYear:-2];
    leftUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    
    [dateComponents setYear:-1];
    currentDate=[calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    NSString *yearViewLeft = [[NSString alloc] initWithFormat:@"Year %@",dateInString2];
    
    [engine speak:yearViewLeft];
    
    
    [next setText:currentdayInMonth1];
    [curr setText:msg2];
    [prev setText:msg3];
}
- (IBAction)RightSwipe:(id)sender {
    swipe = YES;
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:+1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    screenUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setYear:+2];
    leftUpdateDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    
    
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    
    [dateComponents setYear:+1];
    currentDate=[calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    NSString *yearViewRight = [[NSString alloc] initWithFormat:@"Year %@",dateInString2];
    
    [engine speak:yearViewRight];
    
    
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];

    if([segue.identifier isEqualToString:@"backMonthView"]){
        MonthViewController *mvc= [segue destinationViewController];
        [mvc setCurrentDate:currentDate];
        [mvc setUserName:userName];
    }
    if([segue.identifier isEqualToString:@"yearToMain"]){
        MainViewController *mvc= [segue destinationViewController];
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
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:+1];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    tomorrowDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    [dateComponents setYear:-1];
    yesterdayDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    
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
    
    NSString *yearView = [[NSString alloc] initWithFormat:@"Year, View, %@",dateInString];
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    
    if (tutorialMode) {
        NSString *yearView2 = [[NSString alloc] initWithFormat:@"Swipe down to access the week view. To change the year, swipe left or right. To return to the open calendar menu, swipe up%@", yearView];
        
        [engine speak:yearView2];
    }
    
    else if (!(tutorialMode)) {
        [engine speak:yearView];
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

@end
