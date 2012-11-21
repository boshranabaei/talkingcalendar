//
//  SettingsViewController.h
//  TalkingCalendar
//
//  Created by Pamela Lee on 11/20/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESpeakEngine.h"

@interface SettingsViewController : UIViewController {
    ESpeakEngine * engine;
    ESpeakEngine * engine2;
    IBOutlet UITextView *textView;

}

//@property BOOL tutorialMode;

@end
