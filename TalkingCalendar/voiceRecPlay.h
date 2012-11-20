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
    UIButton *playButton;
    UIButton *recordButton;
    UIButton *stopButton;
}
@property NSString *soundFilePath;


-(void)recordAudio;
-(void)stop;
-(void)playAudio;
@end
