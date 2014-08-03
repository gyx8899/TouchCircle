//
//  OAPageView.m
//  01.基本绘图
//
//  Created by admin on 14-8-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "OAPageView.h"

@implementation OAPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    if (self.touched)
        [self drawTouchCircle:self.locationOfTouch];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    self.touched = YES;
    UITouch *touch = [touches anyObject];
    self.locationOfTouch = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    self.touched = YES;
    UITouch *touch = [touches anyObject];
    self.locationOfTouch = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    self.touched = NO;
    UITouch *touch = [touches anyObject];
    self.locationOfTouch = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)drawTouchCircle:(CGPoint)locationOfTouch
{
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx,1);
    CGContextSetRGBStrokeColor(ctx,0.1,0.1,0.1,1.0);
    CGContextAddArc(ctx,locationOfTouch.x,locationOfTouch.y,30,0.0,M_PI*2,YES);
    CGContextStrokePath(ctx);
}


@end
