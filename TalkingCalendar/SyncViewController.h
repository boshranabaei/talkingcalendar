//
//  SyncViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/14/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESpeakEngine.h"

@interface SyncViewController : UIViewController {
    ESpeakEngine * engine;
    ESpeakEngine * engine2;
    IBOutlet UITextView *textView;
}
//@property BOOL tutorialMode;

@end
