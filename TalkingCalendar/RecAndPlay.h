//
//  RecAndPlay.h
//  TalkingCalendar
//
//  Created by Yuan Huang on 11/16/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface RecAndPlay : NSObject
<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    NSString *dirPaths;
    NSString *docsDir;
}
-(IBAction) recordAudio;
-(IBAction) playAudio;
@property NSDate *date;

@end
