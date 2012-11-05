//
//  AuthenticationViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/5/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@interface AuthenticationViewController : UIViewController

    @property sqlite3 * contactDB;


-(IBAction)login:(id)sender;

@end
