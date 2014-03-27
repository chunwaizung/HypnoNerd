//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Drew Horn on 3/24/14.
//  Copyright (c) 2014 Drew Horn. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>
@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self) {
        
        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        
        // Create a UI Image and put it on the tab bar item
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
    }
    
    return self;
}

- (void)loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    // Create a text field and add it to the background view
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    [backgroundView addSubview:textField];
    
    // Set the delete for textField to this view controller
    textField.delegate = self;
    
    // Set backgroundView as the view for this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    // Draw the current text all over the view controller
    [self drawHypnoticMessage:textField.text];
    
    // Clear the text in the text field
    textField.text = @"";
    
    // Dismiss the keyboard
    [textField resignFirstResponder];
    
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        
        // Create a label and configure color, text
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // Resize the label relative to the text that it's displaying
        [messageLabel sizeToFit];
        
        // Get random cooridnates that fit within the bounds of the view
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // Add the label to the heirarchy
        [self.view addSubview:messageLabel];
        
        // Add the "parallax" effect for the message label
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
    }
}

@end
