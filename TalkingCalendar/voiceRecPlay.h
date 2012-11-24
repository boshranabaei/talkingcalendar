//
//  voiceRecPlay.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/17/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface voiceRecPlay : UIViewController
<AVAudioRecorderDelegate, AVAudioPlayerDelegate>{
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    NSTimer *reapter;
    int seconds;
}
@property NSString *soundFilePath;
@property BOOL isRecording;

-(BOOL)recordAudio;
-(void)stop;
-(void)prepareForRecord:(NSString*)userName date:(NSString*)date;
-(BOOL)playAudio:(NSString*)userName date:(NSString*)date;
-(void)deleteVoice:(NSString*)userName date:(NSString*)date;
-(BOOL) hasEvent :(NSString *)userName date:(NSString*)date;
-(void)addOne;
@end
