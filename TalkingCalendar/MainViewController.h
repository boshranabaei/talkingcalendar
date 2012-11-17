//
//  MainViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralEvents.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *reminder;
@property GeneralEvents * ge;

@end
