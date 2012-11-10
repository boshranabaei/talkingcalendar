//
/**  ViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-19.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
/*/

#import <UIKit/UIKit.h>
#import "ESpeakEngine.h"

@interface DayViewController : UIViewController {

    ESpeakEngine * engine;
    IBOutlet UITextView *textView;
    __weak IBOutlet UILabel *cDate;

}

@property (weak, nonatomic) IBOutlet UILabel *prev;

@property (weak, nonatomic) IBOutlet UILabel *curr;
@property (weak, nonatomic) IBOutlet UILabel *next;

@property  NSDate *rightUpdateDate;
@property  NSDate *screenUpdateDate;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Left;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *Right;
@property  NSDate *leftUpdateDate;
@property  NSDate *dateR;
@property  NSDate *currentDate;
@end
