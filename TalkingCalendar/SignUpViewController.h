//
//  SignUpViewController.h
//  TalkingCalendar
//
//  Created by Boshra Nabaei on 11/9/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accounts.h"
#import "ESpeakEngine.h"
@interface SignUpViewController : UIViewController {
    
    ESpeakEngine * engine;
    ESpeakEngine * engine2;
    IBOutlet UITextView *textView;
}
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passConfirm;
@property Accounts * accounts;

- (IBAction)create:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
@end
