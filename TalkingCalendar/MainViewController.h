//
//  MainViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-21.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralEvents.h"
#import "ESpeakEngine.h"

@interface MainViewController : UIViewController {
    ESpeakEngine * engine;

}
@property (weak, nonatomic) IBOutlet UILabel *reminder;
@property (weak, nonatomic) IBOutlet UILabel *reminderTomorrow;
@property GeneralEvents * ge;

@end
