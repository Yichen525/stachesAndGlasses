//
//  DoodleView.m
//  StachesAndGlasses
//
//  Created by Yu Yichen on 5/12/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView
@synthesize firstTouch,lastTouch;
@synthesize path;
@synthesize lines;
@synthesize fillColor;


/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (id)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = NO;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    }
    self.fillColor=[UIColor blueColor];
    lines=[[NSMutableArray alloc]init];
   
    return self;
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
   
    
    
    path= [UIBezierPath bezierPath];
	path.lineWidth = 15.0f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    
	UITouch *touch = [touches anyObject];
	[path moveToPoint:[touch locationInView:self]];
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
	UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
	[self setNeedsDisplay];
}

/*******************************************************************************
 * @method       method
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
    [lines addObject:path];
	[self setNeedsDisplay];
    
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    
    [self touchesEnded:touches withEvent:event];
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) clear
{
    NSLog(@"Clear");
    [path removeAllPoints];
    lines=[[NSMutableArray alloc]init];
    [self setNeedsDisplay];
    self.fillColor=[UIColor blueColor];
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) drawRect:(CGRect)rect
{
    
    
    [self.fillColor set];
    
    [path stroke];
    
    for(int i=0;i<lines.count;i++)
    {// [(UIBezierPath*)[lines objectAtIndex:i] fill];
        [(UIBezierPath*)[lines objectAtIndex:i] stroke];}
	
}

@end
