//
//  MainViewController.m
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize reminder;
@synthesize ge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"goWeekView"]){
        //set currentDate to nil;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Help!
    //Get today date
    //convert it to string
    
    //get today
    //make it string
    //with format: month/day
    // instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // set the dateFormatter format
    [dateFormatter setDateFormat:@"EEEE,dd,MMMM,yyyy"];
 ge=[[GeneralEvents alloc]init];
   
	[reminder setText:[ge searchGEfor:@"1/1"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setReminder:nil];
    [super viewDidUnload];
}


@end
