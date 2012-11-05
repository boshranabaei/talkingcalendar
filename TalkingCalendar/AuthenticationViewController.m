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

@synthesize contactDB;

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
	const char *dbpath = [@"/Users/bnabaei/Desktop/talkingcalendar/TalkingCalendar/talkingcalendar.db" UTF8String];
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSLog(@":))");
    }
    
    else{
        NSLog(@":(");
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


-(IBAction)login:(id)sender{
    
}

@end
