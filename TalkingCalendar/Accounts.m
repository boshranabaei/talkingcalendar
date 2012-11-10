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
        
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *targetPath = [libraryPath stringByAppendingPathComponent:@"talkingcalendar.db"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
            // database doesn't exist in your library path... copy it from the bundle
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];
            NSError *error = nil;
            
            if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:targetPath error:&error]) {
                NSLog(@"Error: %@", error);
            }
        }
        
        
        //NSString *dbpath = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];
        //NSLog(dbpath);
        //const char *dbpath = [@"/TalkingCalendar/talkingcalendar.db" UTF8String];
        
        if (sqlite3_open([targetPath UTF8String], &contactDB) == SQLITE_OK){
            //Connection Successful
        }
        
        else{
            //Handle Error
        }
    }
    return self;
}


-(BOOL)validateUsername:(NSString*)username password: (NSString*)password{
       
    NSString *querySQL=[[NSString alloc]initWithFormat:@"select * from accounts where username=\"%@\" and password=\"%@\";",username,password];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
        if(sqlite3_step(statement)==SQLITE_ROW){
            sqlite3_finalize(statement);
            sqlite3_close(contactDB);
            return YES;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(contactDB);
    return NO;
}

-(BOOL)insertusername:(NSString*)username password: (NSString*)password{

    NSString *querySQL=[[NSString alloc]initWithFormat:@"insert into accounts values (\"%@\" ,\"%@\");",username,password];

    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
            
    }
     
    if(SQLITE_DONE == sqlite3_step(statement)){
        NSLog(@"shod");
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return YES;
    }
    else{
         NSLog(@"Save Error: %s", sqlite3_errmsg(contactDB) );
    }
    sqlite3_finalize(statement);
    sqlite3_close(contactDB);
   
    return NO;
}
/*
-(void)dealloc{
    sqlite3_close(contactDB);
}*/
@end
