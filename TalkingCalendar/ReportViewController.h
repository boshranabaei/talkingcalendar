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

@interface ReportViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)openEmail:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction)showPicker:(id)sender;
@end
