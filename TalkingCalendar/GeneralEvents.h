//
//  GeneralEvents.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface GeneralEvents : NSObject
    @property sqlite3 * contactDB;
-(NSString *)searchGEfor:(NSString *)date;

@end
