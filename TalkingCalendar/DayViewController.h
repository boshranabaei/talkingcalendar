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

@interface DayViewController : UIViewController {

    ESpeakEngine * engine;
    ESpeakEngine * engine2;
    IBOutlet UITextView *textView;
   // IBOutlet UILabel *cDate;

}



@property  NSDate *rightUpdateDate;
@property  NSDate *screenUpdateDate;
@property  NSDate *leftUpdateDate;
@property  NSDate *dateR;
@property  NSDate *currentDate;
@property NSString *currentdayInMonth1;
@property NSString * userNAme;

@property (weak, nonatomic) IBOutlet UILabel *prev;
@property (weak, nonatomic) IBOutlet UILabel *curr;
@property (weak, nonatomic) IBOutlet UILabel *next;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Left;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Right;
@property (weak, nonatomic) IBOutlet UILabel *generalEvent;

@property voiceRecPlay * longPress;

- (IBAction)addEvent:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *stopRec;
@property (weak, nonatomic) IBOutlet UIButton *playRec;

@end
