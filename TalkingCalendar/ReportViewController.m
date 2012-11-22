//
//  ReportViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/21/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "ReportViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "voiceRecPlay.h"
#import "MainViewController.h"
#import "LogOutViewController.h"
#import "GeneralEvents.h"
#import "EspeakEngine.h"
#import "AppDelegate.h"

@interface ReportViewController()

@end

@implementation ReportViewController
@synthesize userName;
// ############### Tutorial on/off doesn't work

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
            [engine speak:@"To send a report of your plan for next 30 day, double tap.To access the main page, swipe left. To access the Log out page, swipe right."];
        }
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [engine stop];
  
    if([segue.identifier isEqualToString:@"reportToLogout"]){
        LogOutViewController *svc2 = [segue destinationViewController];
        [svc2 setUserName:userName];
    }
    
    
 
    if([segue.identifier isEqualToString:@"reportToMain"]){
        MainViewController *svc2 = [segue destinationViewController];
        [svc2 setUserName:userName];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	engine = [[ESpeakEngine alloc] init];
    [engine setLanguage:@"en"];
    [engine setSpeechRate:165];
    
    
    NSLog(@"TutorialMode is ");
    if (tutorialMode) {
        NSLog(@"ON");
        [engine speak:@"To send a report of your plan for next 30 day, double tap.To access the main page, swipe left. To access the Log out page, swipe right."];
    }
    else if (!(tutorialMode)) {
        NSLog(@"OFF");
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)showPicker:(id)sender{
    /*Class mailClass=[NSClassFromString(@"MFMailComposeViewController")];
    if(mailClass !=nil){
        if([mailClass canSendMail]){
            
        }
   
      else{
        UIAlertView * cannot=[[UIAlertView alloc]initWithTitle:@"email error" message:@"can't send email" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [cannot show];
      }
    }
    else{
        
    }*/
}





- (IBAction)openEmail:(id)sender {
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    [mailComposer setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail]){
        [engine stop];
        //*********** getting the date for title**********
        NSDate *tmp=[[NSDate alloc] init];;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/YYYY"];
        NSString *dateInString = [dateFormatter stringFromDate: tmp];
        
        
        
        
        [mailComposer setToRecipients:[NSArray arrayWithObjects:@"yourEmail@sfu.ca",nil]];
        // [mailComposer setToRecipients:[NSArray arrayWithObject:@"email@email.co.uk",nil]];
        [mailComposer setSubject:[[NSString alloc] initWithFormat:@"Plan Report (sent day: %@)",dateInString]];
        [mailComposer setMessageBody:[self getReport] isHTML:NO];
        
        // u can choose any sytle
        [mailComposer setModalPresentationStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:mailComposer animated:YES];
 
    }
    
    else{

    }

}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)


result error:(NSError *)error {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error %@", [error description]] delegate:nil cancelButtonTitle:@"Canel" otherButtonTitles:nil,nil];
        [alert show];
        [self dismissModalViewControllerAnimated:YES];
    }
    
    else{
        [self dismissModalViewControllerAnimated:YES];
        [engine speak:@"the report is sent"];
    }
    
}

-(NSMutableString *)getReport{
    
   voiceRecPlay* vrp=[[voiceRecPlay alloc]init];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *tmp=[[NSDate alloc] init];;
    NSString *dateInString4;
    NSString *msg4;
    NSTimeInterval aDay = 24*60*60;
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    dateInString4 = [dateFormatter stringFromDate: tmp];
    msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
    GeneralEvents *ge=[[GeneralEvents alloc]init];

    NSMutableString *content=[[NSMutableString alloc] initWithFormat:@"Hello %@,\n This message is from \"Talking Calendar Application\". Your plan for the next month is the following:",userName];
    for (int counter=1; counter<30; counter++) {
        tmp= [tmp dateByAddingTimeInterval:aDay];
        dateInString4 = [dateFormatter stringFromDate: tmp];
        msg4 = [[NSString alloc] initWithFormat:@"%@",dateInString4];
        
        if([vrp hasEvent:userName date:msg4]){
            [content appendString:[[NSString alloc] initWithFormat:@"    \n%@ :event",dateInString4]];
            if(!([[ge searchGEfor:dateInString4]isEqualToString:@"No events"])){
            [content appendString:[[NSString alloc] initWithFormat:@"and (%@)!",[ge searchGEfor:dateInString4]]];
         }}
        
    }
   
    [content appendString:@"\nTo know about the details, run \"Talking Calendar\" and listen to recorded events."];
    return content;
    
}





@end
