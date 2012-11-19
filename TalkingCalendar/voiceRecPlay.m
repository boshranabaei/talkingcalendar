//
//  voiceRecPlay.m
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/17/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "voiceRecPlay.h"
#import "/usr/include/sqlite3.h"

@implementation voiceRecPlay

@synthesize soundFilePath;
@synthesize voice1;

-(id)init{
    self = [super init];
    if (self) {
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        soundFilePath = [docsDir stringByAppendingPathComponent:@"sound1.caf"];
        
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary
                                        dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                        AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16],
                                        AVEncoderBitRateKey,
                                        [NSNumber numberWithInt: 2],
                                        AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0],
                                        AVSampleRateKey,
                                        nil];
        
        NSError *error = nil;
        audioRecorder = [[AVAudioRecorder alloc]
                         initWithURL:soundFileURL
                         settings:recordSettings
                         error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
            
        } else {
            [audioRecorder prepareToRecord];
        }

    
    }
    else{}
return self;
}

-(void)recordAudio{
    if (!audioRecorder.recording)
    {
        NSLog(@"recording started");
    [audioRecorder record];
    }
}
-(void)stop
{
     //***********************stop************************
    if (audioRecorder.recording)
    {
                NSLog(@"recording stopped");
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
    
    //**********Database Connection ******************
    sqlite3 * contactDB;
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetPath = [libraryPath stringByAppendingPathComponent:@"talkingcalendar.db"];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];
    NSError *error = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
        // database doesn't exist in library path... so must copy it from the bundle
        // [[NSFileManager defaultManager] removeItemAtPath:targetPath error:NULL];
        
       
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
    
    /*NSString *check=[[NSString alloc]initWithFormat:@"select * from accounts where "];
    
    const char *c_stmt = [check UTF8String];
    sqlite3_stmt *s;
    
    
    if (sqlite3_prepare_v2(contactDB, c_stmt, -1, &s, NULL)==SQLITE_OK){
        if(sqlite3_step(s)==SQLITE_ROW){
            sqlite3_finalize(s);
            sqlite3_close(contactDB);
            
        }
    }*/
    
    
    
    const char * query_stmt = "insert into events values(\"en sha allah\",\"4/2\",?); ";
    NSData * v= [[NSData alloc]initWithContentsOfFile:soundFilePath];
    
    //const char *query_stmt =[querySQL UTF8String];
    sqlite3_stmt *statement;
    

    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
           sqlite3_bind_blob(statement, 3,&(v), [v length], nil);
    }

         
    if(SQLITE_DONE == sqlite3_step(statement)){
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        
    }
    else{
        NSLog(@"Save Error: %s", sqlite3_errmsg(contactDB) );
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }

    
    
   
}











-(void) playAudio
{
    //**********Database Connection ******************
    sqlite3 * contactDB;
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetPath = [libraryPath stringByAppendingPathComponent:@"talkingcalendar.db"];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"talkingcalendar" ofType:@"db"];
    NSError *error = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
        // database doesn't exist in library path... so must copy it from the bundle
        // [[NSFileManager defaultManager] removeItemAtPath:targetPath error:NULL];
        
        
        
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
    
    NSString *querySQL=[[NSString alloc]initWithFormat:@"select voice from events where username=\"test\";"];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt *statement;
    NSData *voice;
    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){
        if(sqlite3_step(statement)==SQLITE_ROW){
       
            voice = [[NSData alloc] initWithData:(__bridge NSData *)(sqlite3_column_blob(statement, 0))];
            if(voice == nil) NSLog(@"No image found.");
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(contactDB);
    
//***********************Play************************
    voice1= [[NSData alloc]initWithContentsOfFile:soundFilePath];
    
    if (!audioRecorder.recording)
    {
                NSLog(@"play");
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithData:voice
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}


@end
