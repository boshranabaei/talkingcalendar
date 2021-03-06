//
/**  ViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-19.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
/*/

#import <UIKit/UIKit.h>
#import "ESpeakEngine.h"
#import "voiceRecPlay.h"
#import "GeneralEvents.h"

@interface DayViewController : UIViewController {

    ESpeakEngine * engine;
    ESpeakEngine * engine2;
    int seconds;
    NSTimer* repeater;
}


@property (weak, nonatomic) IBOutlet UILabel *GELabel;

@property  NSDate *rightUpdateDate;
@property  NSDate *screenUpdateDate;
@property  NSDate *leftUpdateDate;
@property  NSDate *dateR;
@property  NSDate *currentDate;
@property NSString *currentdayInMonth1;
@property NSString * userName;
@property GeneralEvents *generalEvents;
@property NSString *dateInString;
@property BOOL hasEvent;
@property BOOL isRecording;
@property int whatConfrim;

@property (weak, nonatomic) IBOutlet UILabel *prev;
@property (weak, nonatomic) IBOutlet UILabel *curr;
@property (weak, nonatomic) IBOutlet UILabel *next;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Left;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Right;

@property voiceRecPlay * longPressForRecord;

@property (strong, nonatomic) IBOutlet UIView *stopRec;
@property (weak, nonatomic) IBOutlet UIButton *playRec;

- (void) stop;
- (IBAction)addEvent:(id)sender;
-(void)addOneForPlaying;
-(void)addOneForRecording;



-(void)prepareForRec;
//@property GeneralEvents * generalEvents;
@end
