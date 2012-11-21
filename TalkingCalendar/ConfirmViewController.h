//
//  ConfirmViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/20/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESpeakEngine.h"

@interface ConfirmViewController : UIViewController{
        ESpeakEngine * engine;
}
@property NSString * userName;
@property int decision;
- (IBAction)longPress:(id)sender;
- (IBAction)swipeRight:(id)sender;
- (IBAction)doubleTab:(id)sender;
- (IBAction)swipeLeft:(id)sender;

@end
