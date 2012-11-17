//
//  RecAndPlay.m
//  TalkingCalendar
//
//  Created by Yuan Huang on 11/16/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import "RecAndPlay.h"
#import <AVFoundation/AVFoundation.h>
@implementation RecAndPlay
@synthesize date;

/*- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:date stringByAppendingString:@".caf"];
}*/

-(void) playAudio
{

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

-(void) recordAudio
{
    /*dirPaths =[self dateString];
    dirPaths =[@"/Users/yha99/Desktop/" stringByAppendingString:dirPaths ];*/
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:@"/Users/yha99/Desktop/test.caf"];
    
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
        [audioRecorder record];
    }
}
@end
