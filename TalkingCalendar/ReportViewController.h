//
//  ReportViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/21/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "EspeakEngine.h"

@interface ReportViewController : UIViewController <MFMailComposeViewControllerDelegate>{
     ESpeakEngine * engine;
}

- (IBAction)openEmail:(id)sender;
-(IBAction)showPicker:(id)sender;
@property NSString * userName;
-(NSMutableString *)getReport;
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
@end
