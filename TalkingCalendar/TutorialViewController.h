//
//  TutorialViewController.h
//  TalkingCalendar
//
//  Created by Pamela Lee on 11/16/12.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap;

- (IBAction)doubleTap:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *test;

//@property BOOL tutorialMode;


@end
