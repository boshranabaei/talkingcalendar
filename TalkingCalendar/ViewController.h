//
//  ViewController.h
//  TalkingCalendar
//
//  Created by Vito Wang on 2012-10-19.
//  Copyright (c) 2012 Vito Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(IBAction)dayView:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *prev;

@property (weak, nonatomic) IBOutlet UILabel *curr;
@property (weak, nonatomic) IBOutlet UILabel *next;

@end
