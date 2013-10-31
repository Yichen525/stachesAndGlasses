//
//  DoodleView.h
//  StachesAndGlasses
//
//  Created by Yu Yichen on 5/12/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoodleView : UIView

@property (assign) CGPoint firstTouch;
@property (assign) CGPoint lastTouch;
@property (strong, nonatomic) UIBezierPath *path;
@property NSMutableArray *lines;
@property UIColor *fillColor;


- (void) clear;

@end
