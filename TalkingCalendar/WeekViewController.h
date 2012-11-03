//
//  WeekViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WeekViewController : UIViewController
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
@property Boolean swipe;

@end
