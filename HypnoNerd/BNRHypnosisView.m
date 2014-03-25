//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Drew Horn on 3/23/14.
//  Copyright (c) 2014 Drew Horn. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // FIgure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Create circles inside circles until the radius is 0
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        // Move to the next point to start drawing
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        // Draw the next circle
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    // Configure the line width
    path.lineWidth = 10;
    
    // Configure the drawing color to light gray
    [self.circleColor setStroke];
    
    // Draw the circle
    [path stroke];
    
    // Load the logo.png file into a UIImage object and composite it onto the view
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    CGRect imageRect = CGRectMake(bounds.size.width / 4, bounds.size.height / 4, bounds.size.width / 2, bounds.size.height / 2);
    [logoImage drawInRect:imageRect];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched.", self);
    
    // Get three random numbers between 0 and 1
    float red = (arc4random() % 100 / 100.0);
    float green = (arc4random() % 100 / 100.0);
    float blue = (arc4random() % 100 / 100.0);
    
    UIColor *randomColor =  [UIColor colorWithRed:red
                                            green:green
                                             blue:blue
                                            alpha:1.0];
    
    // Set the random color
    self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
