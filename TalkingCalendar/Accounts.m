//
//  Accounts.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/8/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "Accounts.h"

@implementation Accounts
    @synthesize contactDB;
- (id)init
{
    self = [super init];
    if (self) {
        
        const char *dbpath = [@"/Users/bnabaei/Desktop/talkingcalendar/TalkingCalendar/talkingcalendar.db" UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            //Connection Successful
        }
        
        else{
            //Handle Error
        }
    }
    return self;
}


-(BOOL *)validateUsername:(NSString*)username password: (NSString*)password{
    NSString *querySQL = @"select * from accounts where username=\"username\" and password=\"password\";";
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
        if(sqlite3_step(statement)==SQLITE_ROW){
          //  NSString *sName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            NSLog(@"Hastesh");
            //return sName;
        }
    }
    return true;
}
@end
