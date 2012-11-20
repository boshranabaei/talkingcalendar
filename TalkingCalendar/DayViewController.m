//
//  ViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-19.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//
#import "ESpeakEngine.h"
#import "DayViewController.h"
#import "WeekViewController.h"
#import "voiceRecPlay.h"
#import "GeneralEvents.h"

@interface DayViewController ()

@end

@implementation DayViewController
@synthesize stopRec;
@synthesize playRec;

@synthesize prev,next,curr;

@synthesize rightUpdateDate;
@synthesize leftUpdateDate;
@synthesize screenUpdateDate;
@synthesize dateR,currentDate;

@synthesize currentdayInMonth1;
@synthesize generalEventLabel;
@synthesize longPress;
@synthesize userName;
//@synthesize generalEvents;



- (IBAction)LeftSwipe:(id)sender {
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"EEEE,dd,MMMM,yyyy"];
    
    
    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:-aDay];
    
    leftUpdateDate= [currentDate dateByAddingTimeInterval:-2*aDay];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:-aDay];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *dayViewLeft = [[NSString alloc] initWithFormat:@"%@",dateInString2];

    [engine speak:dayViewLeft];
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:currentdayInMonth1];
    
    [curr setText:msg2];
    [prev setText:msg3];
}
- (IBAction)RightSwipe:(id)sender {
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"EEEE,dd,MMMM,yyyy"];
    
    
    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:+aDay];
    
    rightUpdateDate= [currentDate dateByAddingTimeInterval:+2*aDay];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: rightUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:+aDay];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *dayViewRight = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    [engine speak:dayViewRight];
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"goWeekView"]){
        WeekViewController *wvc = [segue destinationViewController];
        [wvc setCurrentDate:currentDate];
        [wvc setUserName:userName];
    }
}



- (void)viewDidLoad
{

    [super viewDidLoad];
//*********************************************Calendar and Text to speech********************
    
	//engine = [[ESpeakEngine alloc] init];
    //[engine setLanguage:@"en"];
    //[engine setSpeechRate:150];
    //[engine setPitch:50];
    //[engine setGender:kESpeakEngineGenerFemale];
    //[engine speak:cDate.currentdayInMonth1];

    dateR=[[NSDate alloc] init];
    if(currentDate ==nil)
        currentDate=[[NSDate alloc] init];
    
    NSDate *tomorrowDate;
    NSDate *yesterdayDate;
    
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"EEEE,dd,MMMM"];
    
    // NSString *currentdayInMonth = [dateFormatter stringFromDate:currentDateTime];
    //NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",currentDateTime];
    NSTimeInterval aDay = 24*60*60;
    // add one date by + aDay
    tomorrowDate = [currentDate dateByAddingTimeInterval:aDay];
    //NSString *tomorrowInMonth = [dateFormatter stringFromDate:tomorrowDate];
    // decre one date by - aDay
    yesterdayDate= [currentDate dateByAddingTimeInterval:-aDay];
    //NSString *yesterdayInMonth = [dateFormatter stringFromDate:yesterdayDate];
    
    
    // NSString *message2 = [[NSString alloc] initWithFormat:@"%@",tomorrowDate];
    // NSString *message3 = [[NSString alloc] initWithFormat:@"%@",yesterdayDate];
    //get the substring from different.
    // get the substring from current
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
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
    
    NSString *dayView = [[NSString alloc] initWithFormat:@"Day, View, %@",dateInString];
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    [engine speak:dayView];
    
//*********************************************Events********************
    [self ViewPlay];
    
//*********************************************GenralEvents********************   
    //generalEvents=[[GeneralEvents alloc]init];
    
    /*NSDateFormatter *dateFormatForGE = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatForGE setDateFormat:@"dd-MM-YYYY"];
    NSString *dateInStringForGE = [dateFormatForGE stringFromDate: currentDate];
    NSString *GEevent=[[NSString alloc] initWithFormat:@"%@",dateInStringForGE];
    
     [generalEventLabel setText:[generalEvents searchGEfor:GEevent]];*/

}
-(void)ViewPlay
{
    longPress=[[voiceRecPlay alloc]init];
    [longPress prepareForRecord:@"boshra" date:@"12-12-2014"];
    while([engine isPlaying]){};
    [longPress playAudio:@"boshra" date:@"12-12-2014"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    currentDate = nil;
    [self setStopRec:nil];
    [self setPlayRec:nil];
    [self setGeneralEventLabel:nil];
    [super viewDidUnload];
}
- (IBAction)addEvent:(id)sender {
    [engine speak:@"start"];
    
    
    [longPress recordAudio];
        
}
- (IBAction)stopRec:(id)sender {
   
    
    NSString *say=[[NSString alloc]initWithFormat:@"event added to %@",currentdayInMonth1];
    [engine speak:say];
    [longPress stop];
    
}
- (IBAction)playRec:(id)sender {
    
    [longPress playAudio:@"boshra" date:@"12-12-2014"];
    
}

@end
