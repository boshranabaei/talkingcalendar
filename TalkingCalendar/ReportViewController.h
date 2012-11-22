//
//  ReportViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/21/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController

- (IBAction)sendEmail:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (IBAction)dissmissKeyboard:(id)sender;
@end
