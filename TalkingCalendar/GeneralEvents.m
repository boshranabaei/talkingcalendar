//
//  GeneralEvents.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "GeneralEvents.h"

@implementation GeneralEvents

@synthesize contactDB;
- (id)init
{
    self = [super init];
    if (self) {
        
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *targetPath = [libraryPath stringByAppendingPathComponent:@"talkingcalendar.db"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
            // database doesn't exist in library path... so must copy it from the bundle
            [[NSFileManager defaultManager] removeItemAtPath:targetPath error:NULL];
            
            
           if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:targetPath error:&error]) {
               NSLog(@"Error: %@", error);
            }
        }
        else{
            
            if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:targetPath error:&error]) {
                NSLog(@"Error: %@", error);
            }
        }
        
        //NSString *dbpath = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];
        //NSLog(dbpath);
       // const char *dbpath = [@"Users/bnabaei/Desktop/talkingcalendar/TalkingCalendar/talkingcalendar.db" UTF8String];
        //NSLog(targetPath);
        if (sqlite3_open([targetPath UTF8String] , &contactDB) == SQLITE_OK){
            
        }
        
        else{
            //Handle Error
        }
    }
    return self;
}


-(NSString *)searchGEfor:(NSString *)date{
    
    NSString *querySQL=[[NSString alloc]initWithFormat:@"select description from generalevents where date=\"10/31\";"];
    
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
        if(sqlite3_step(statement)==SQLITE_ROW){
            NSString *description=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            sqlite3_finalize(statement);
            sqlite3_close(contactDB);
            return description;
        }
        return @"yes";
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(contactDB);
    return @"no";
}


@end
