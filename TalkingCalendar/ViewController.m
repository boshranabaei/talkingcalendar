//
//  ViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-19.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize prev,next,curr;

@synthesize rightUpdateDate;
@synthesize leftUpdateDate;
@synthesize screenUpdateDate;
@synthesize dateR,currentDate;



-(IBAction)dayView:(id)sender{
    
    NSDate *tomorrowDate;
    NSDate *yesterdayDate;
    
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"d"];
    
    // NSString *currentdayInMonth = [dateFormatter stringFromDate:currentDateTime];
    //NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",currentDateTime];
    NSTimeInterval aDay = 24*60*60;
    // add one date by + aDay
    tomorrowDate = [dateR dateByAddingTimeInterval:aDay];
    //NSString *tomorrowInMonth = [dateFormatter stringFromDate:tomorrowDate];
    // decre one date by - aDay
    yesterdayDate= [dateR dateByAddingTimeInterval:-aDay];
    //NSString *yesterdayInMonth = [dateFormatter stringFromDate:yesterdayDate];
    
    
    // NSString *message2 = [[NSString alloc] initWithFormat:@"%@",tomorrowDate];
    // NSString *message3 = [[NSString alloc] initWithFormat:@"%@",yesterdayDate];
    //get the substring from different.
    // get the substring from current
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: dateR];
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
}

-(IBAction)leftSwipe:(id)sender{

    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"d"];
    

    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:-aDay];

    leftUpdateDate= [currentDate dateByAddingTimeInterval:-2*aDay];

    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: leftUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:-aDay];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:currentdayInMonth1];
    
    [curr setText:msg2];
    [prev setText:msg3];

}

-(IBAction)rightSwipe:(id)sender{
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"d"];
    
    
    NSTimeInterval aDay = 24*60*60;
    screenUpdateDate = [currentDate dateByAddingTimeInterval:+aDay];
    
    rightUpdateDate= [currentDate dateByAddingTimeInterval:+2*aDay];
    
    // passing the message to myLabel setter function.
    // myLabel.setText(message)    [myLabel setText:message];
    NSString *dateInString = [dateFormatter stringFromDate: currentDate];
    NSString *currentdayInMonth1 = [[NSString alloc] initWithFormat:@"%@",dateInString];
    
    NSString *dateInString2 = [dateFormatter stringFromDate: screenUpdateDate];
    NSString *msg2 = [[NSString alloc] initWithFormat:@"%@",dateInString2];
    
    NSString *dateInString3 = [dateFormatter stringFromDate: rightUpdateDate];
    NSString *msg3 = [[NSString alloc] initWithFormat:@"%@",dateInString3];
    currentDate=[currentDate dateByAddingTimeInterval:+aDay];
    
    // current.
    // onScreenDate.
    // swipe left -> onScreenDate - 1
    // swipe right -> onScreenDate + 1
    
    
    // disappear the keyborad, push button!
    // tell the system give up the firstResponder;
    [next setText:msg3];
    
    [curr setText:msg2];
    [prev setText:currentdayInMonth1];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateR=[[NSDate alloc] init];
    currentDate=[[NSDate alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
