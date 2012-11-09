//
//  AuthenticationViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/5/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController
@synthesize accounts;
@synthesize userName;
@synthesize password;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    accounts=[[Accounts alloc]init];

}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)login:(id)sender{

   if([accounts validateUsername:[userName text] password:[password text]]){
        NSLog(@"Congrates!");
    }
        
     
  }

@end
