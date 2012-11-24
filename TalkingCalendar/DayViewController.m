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
#import "AppDelegate.h"
#import "ConfirmViewController.h"

@interface DayViewController ()


@end

@implementation DayViewController

@synthesize stopRec;
@synthesize playRec;
@synthesize isRecording;
@synthesize prev,next,curr;

@synthesize GELabel;
@synthesize rightUpdateDate;
@synthesize leftUpdateDate;
@synthesize screenUpdateDate;
@synthesize dateR,currentDate;

@synthesize currentdayInMonth1;

@synthesize longPressForRecord;
@synthesize userName;
@synthesize generalEvents;
@synthesize hasEvent;
@synthesize whatConfrim;



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
    
            [engine speak:@"To access the Week view, swipe up. To change the date, swipe left or right. To record an event on the current date, hold the screen for three seconds. Double tap the screen when you are finished. To delete an event."];
            
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

- (IBAction)LeftSwipe:(id)sender {
    [engine stop];
     [longPressForRecord stop];
    [repeater invalidate];
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format                           
    [dateFormatter setDateFormat:@"yyyy\nMMMM\nEEEE\n\ndd"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"dd"];
    
    
    
    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:-aDay];
    
    leftUpdateDate= [currentDate dateByAddingTimeInterval:-2*aDay];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: leftUpdateDate];
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
    [self prepareForRec];
   
    
    
    //*********************************************GeneralEvents********************
   generalEvents=[[GeneralEvents alloc]init];
    
    NSDateFormatter *dateFormatForGE = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatForGE setDateFormat:@"dd-MM-YYYY"];
    NSString *dateInStringForGE = [dateFormatForGE stringFromDate: screenUpdateDate];
    NSString *GEDate= [[NSString alloc] initWithFormat:@"%@",dateInStringForGE];
    NSString *GEevent=[generalEvents searchGEfor:GEDate];
    if(![GEevent isEqualToString:@"No events"]){
        [GELabel setText:GEevent];
    }
    else{
        [GELabel setText:@" "];
    }
    
    repeater=[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(addOneForPlaying) userInfo:nil repeats:YES];
    
}
- (IBAction)RightSwipe:(id)sender {
    // instantiate a NSDateFormatter
     [longPressForRecord stop];
    [engine stop];
    [repeater invalidate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy\nMMMM\nEEEE\n\ndd"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"dd"];
    
    
    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:+aDay];
    
    rightUpdateDate= [currentDate dateByAddingTimeInterval:+2*aDay];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter2 stringFromDate: currentDate];
    currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter2 stringFromDate: rightUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:+aDay];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    NSString *dayViewRight = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
   
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
    [self prepareForRec];
    
    
    //*********************************************GeneralEvents********************
    generalEvents=[[GeneralEvents alloc]init];
    
    NSDateFormatter *dateFormatForGE = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatForGE setDateFormat:@"dd-MM-YYYY"];
    NSString *dateInStringForGE = [dateFormatForGE stringFromDate: screenUpdateDate];
    NSString *GEDate= [[NSString alloc] initWithFormat:@"%@",dateInStringForGE];
    NSString *GEevent=[generalEvents searchGEfor:GEDate];
    if(![GEevent isEqualToString:@"No events"]){
        [GELabel setText:GEevent];
        NSString *say=[dayViewRight stringByAppendingString:GEevent];
        [engine speak:say];
    }
    else{
        [GELabel setText:@" "];
         [engine speak:dayViewRight];
    }
    
    
    repeater=[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(addOneForPlaying) userInfo:nil repeats:YES];
    
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
    
    if([segue.identifier isEqualToString:@"goWeekView"]){
        WeekViewController *wvc = [segue destinationViewController];
        [wvc setCurrentDate:currentDate];
        [wvc setUserName:userName];
        
    }
    if([segue.identifier isEqualToString:@"confirm"]){
        ConfirmViewController *cvc = [segue destinationViewController];
        [cvc setUserName:userName];
        [cvc setCurrentDate:currentDate];
        
    }
    if([segue.identifier isEqualToString:@"dayToMain"]){
        ConfirmViewController *cvc = [segue destinationViewController];
        [cvc setUserName:userName];
        
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
    
    //self.UIView.backgroundColour = [UIColor colorWithPatternImage:[UIImage imageNamed:@"testPicture.jpg"]];

    isRecording=NO;
    dateR=[[NSDate alloc] init];
    if(currentDate ==nil)
        currentDate=[[NSDate alloc] init];
    
    NSDate *tomorrowDate;
    NSDate *yesterdayDate;
    
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy\nMMMM\nEEEE\n\ndd"];
    
    //set Left/Right date format
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"dd"];
    
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
    
    NSString *dayView = [[NSString alloc] initWithFormat:@"Day, View, %@",dateInString];
    
    engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:150];
    
    

    
    
//*********************************************GeneralEvents********************   
    generalEvents=[[GeneralEvents alloc]init];
    
    NSDateFormatter *dateFormatForGE = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatForGE setDateFormat:@"dd-MM-YYYY"];
    NSString *dateInStringForGE = [dateFormatForGE stringFromDate: currentDate];
    NSString *GEDate= [[NSString alloc] initWithFormat:@"%@",dateInStringForGE];
    NSString *GEevent=[generalEvents searchGEfor:GEDate];
    if(![GEevent isEqualToString:@"No events"]){
        [GELabel setText:GEevent];
    }
    
    
    
    
    //*********************************************Events********************
    
    
    longPressForRecord=[[voiceRecPlay alloc]init];
    [self prepareForRec];
    if(whatConfrim==1){
        [engine speak:@"start recording"];
        [engine2 speak:@" "];
        [self record];
        hasEvent=YES;
        
    }
    else if(whatConfrim==2){
        [self deleteVoice];
        hasEvent=NO;
        [engine speak:@"event deleted"];
        [engine2 speak:@" "];
    }
    else{
        repeater=[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(addOneForPlaying) userInfo:nil repeats:YES];
    
    whatConfrim=0;
    
    
    
    if (tutorialMode) {
        NSLog(@"Tutorial mode is on");
        if (![GEevent isEqualToString:@"No events"]) {
            // There are events.

            NSString * mid =[dayView stringByAppendingString:GEevent];
            
       
            [engine speak:[mid stringByAppendingString:@", To access the Week view, swipe up. To change the date, swipe left or right. To record an event on the current date, hold the screen for three seconds. Double tap the screen when you are finished. To delete an event. The event is, " ]];
        }
        else {
            // There are no events.
           NSString *dayView = [[NSString alloc] initWithFormat:@"To access the week view, swipe up. To change the date, swipe left or right. To record an event on the current date, hold the screen for three seconds. Double tap the screen when you are finished. To delete an event %@",dateInString];
            [engine speak:dayView];
        }
    }
    
    else if (!(tutorialMode)) {
        NSLog(@"Tutorial mode is off");
        if (![GEevent isEqualToString:@"No events"]) {
            // There are events.
            
            
            [engine speak:[dayView stringByAppendingString:GEevent]];
        }
        else {
            // There are no events.
    
            [engine speak:dayView];
        }}

    }
    
    

    

}

-(void)prepareForRec{
    NSDateFormatter *formatForRecord=[[NSDateFormatter alloc]init];
    [formatForRecord setDateFormat:@"dd-MM-YYYY"];
    NSString *stringForRecord = [[NSString alloc] initWithFormat:@"%@",[formatForRecord stringFromDate: currentDate]];
    [longPressForRecord prepareForRecord:userName date:stringForRecord];
}
-(void)ViewPlay
{
    NSDateFormatter *formatForRecord=[[NSDateFormatter alloc]init];
    [formatForRecord setDateFormat:@"dd-MM-YYYY"];
    NSString *stringForRecord = [[NSString alloc] initWithFormat:@"%@",[formatForRecord stringFromDate: currentDate]];
    hasEvent=[longPressForRecord playAudio:userName date:stringForRecord];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


- (void)viewDidUnload {
    currentDate = nil;
    [self setStopRec:nil];
    [self setPlayRec:nil];
    GELabel = nil;
    [self setGELabel:nil];
    [super viewDidUnload];
    [engine stop];
}
- (IBAction)addEvent:(id)sender {
    if(![longPressForRecord isRecording]){
    NSLog(@"addevent");
    
    isRecording=YES;
    if(hasEvent){
        
        [self performSegueWithIdentifier:@"confirm" sender:self];
        
    }
    else{
        [engine speak:@"start"];
        hasEvent=YES;
        [longPressForRecord recordAudio];
        seconds=0;
        repeater=[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(addOneForRecording) userInfo:nil repeats:YES];
    }
        
    }
}

-(void)addOneForPlaying
{
    seconds++;
    NSLog(@"%d",seconds);
    if(![engine isPlaying])
    {
        [repeater invalidate];
        NSLog(@"Not Playing,ddd%d",seconds);
        seconds=0;
        [self ViewPlay];
    }
}

-(void)addOneForRecording
{
    seconds++;
    NSLog(@"%d",seconds);
    if((seconds>=30 )|| ![longPressForRecord isRecording])
    {
        [repeater invalidate];
        NSLog(@"ddd%d",seconds);
        [self stop];
        if(seconds>=7)
            [engine speak: @"30 seconds"];
    }
}


- (void)record {
            [engine speak:@"start"];
            hasEvent=YES;
            [longPressForRecord recordAudio];
            seconds=0;
            repeater=[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(addOneForRecording) userInfo:nil repeats:YES];

}
- (void)deleteVoice {
    NSDateFormatter *formatForDelete=[[NSDateFormatter alloc]init];
    [formatForDelete setDateFormat:@"dd-MM-YYYY"];
    NSString *stringForDelete = [[NSString alloc] initWithFormat:@"%@",[formatForDelete stringFromDate: currentDate]];

    [longPressForRecord deleteVoice:userName date:stringForDelete];
   
    
}
- (IBAction)stopRec:(id)sender {
    if([longPressForRecord isRecording]){
        [self stop];}
    
}
 
- (void) stop
{
    NSDateFormatter *formatForSpeak=[[NSDateFormatter alloc]init];
    [formatForSpeak setDateFormat:@"EEEE,dd,MMMM"];
    NSString *stringForSpeak = [[NSString alloc] initWithFormat:@"%@",[formatForSpeak stringFromDate: currentDate]];
    
    NSString *say=[[NSString alloc]initWithFormat:@"event added to %@",stringForSpeak];
    [engine speak:say];
    [longPressForRecord stop];
    isRecording=NO;
}

@end
