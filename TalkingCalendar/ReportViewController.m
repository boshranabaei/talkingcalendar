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
@interface ReportViewController()

@end

@implementation ReportViewController
@synthesize email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEmail:nil];
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
        
        [mailComposer setToRecipients:[NSArray arrayWithObjects:@"yourEmail@sfu.ca",nil]];
        // [mailComposer setToRecipients:[NSArray arrayWithObject:@"email@email.co.uk",nil]];
        [mailComposer setSubject:@"Hi,this is a test"];
        [mailComposer setMessageBody:@"Is this work?" isHTML:NO];
        
        // u can choose any sytle
        [mailComposer setModalPresentationStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:mailComposer animated:YES];
 
    }
    
    else{

    }

}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error %@", [error description]] delegate:nil cancelButtonTitle:@"Canel" otherButtonTitles:nil,nil];
        [alert show];

        [self dismissModalViewControllerAnimated:YES];
    }
    
    else{
        [self dismissModalViewControllerAnimated:YES];
    }
    
}





@end
