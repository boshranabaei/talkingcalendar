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

-(id)init{
    self = [super init];
    if (self) {
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
        
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
    
    if (audioRecorder.recording)
    {
                NSLog(@"recording stopped");
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
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
    //sqlite3_finalize(statement);
    sqlite3_close(contactDB);
    
//***********************Play************************
    if (!audioRecorder.recording)
    {
                NSLog(@"play");
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:audioRecorder.url
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
