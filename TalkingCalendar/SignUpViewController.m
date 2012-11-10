//
//  SignUpViewController.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/9/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize userName;
@synthesize password;
@synthesize passConfirm;
@synthesize accounts;

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
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setPassConfirm:nil];
    [super viewDidUnload];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)create:(id)sender {
    accounts=[[Accounts alloc]init];
    if([accounts insertusername:[userName text] password:[password text]]){
    }
    else{
        UIAlertView *exists=[[UIAlertView alloc]initWithTitle:@"Authentication"
                                                        message:@"The username already exists"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [exists show];
    }

}
@end
