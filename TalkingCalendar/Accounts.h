//
//  Accounts.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/8/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface Accounts : NSObject
    @property sqlite3 * contactDB;
    
-(BOOL *)validateUsername:(NSString*) username password: (NSString*)password;
-(BOOL *)insertusername:(NSString*)username password: (NSString*)password;
@end
