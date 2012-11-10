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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];

        //const char *dbpath = [@"/Users/lamalexl/Desktop/talkingcalendar/TalkingCalendar/talkingcalendar.db" UTF8String];
        
        if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
            //Connection Successful
        }
        
        else{
            //Handle Error
        }
    }
    return self;
}


-(BOOL *)validateUsername:(NSString*)username password: (NSString*)password{
       
    NSString *querySQL=[[NSString alloc]initWithFormat:@"select * from accounts where username=\"%@\" and password=\"%@\";",username,password];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
        if(sqlite3_step(statement)==SQLITE_ROW){
            return YES;
        }
    }
    return NO;
}

-(BOOL *)insertusername:(NSString*)username password: (NSString*)password{
    NSLog(@"sds");
    NSString *querySQL=[[NSString alloc]initWithFormat:@"insert into accounts values (\"%@\" ,\"%@\");",username,password];
    NSLog(querySQL);
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
            NSLog(@"shod");
    }
    if(SQLITE_DONE == sqlite3_step(statement))
        return YES;
    else{
        
    }

    return NO;
}
@end
