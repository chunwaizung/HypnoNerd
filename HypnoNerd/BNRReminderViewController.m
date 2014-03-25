//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Drew Horn on 3/24/14.
//  Copyright (c) 2014 Drew Horn. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@.", date);
}

@end
