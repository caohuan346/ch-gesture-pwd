//
//  SPLockOverlay.m
//  SuQian
//
//  Created by Suraj on 25/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPLockOverlay.h"

#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


//#define kLineColor			[UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:78.0/255.0 alpha:0.9]
#define kLineGridColor  [UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:233.0/255.0 alpha:1.0]
#define kLineColor         [UIColorFromRGB(0xffea7f)   colorWithAlphaComponent:.2f]
@implementation SPLockOverlay

@synthesize pointsToDraw;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
			self.backgroundColor = [UIColor clearColor];
			self.pointsToDraw = [[NSMutableArray alloc]init];
        ;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat lineWidth = 15.0;
    
	
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetStrokeColorWithColor(context, kLineColor.CGColor);
    for(SPLine *line in self.pointsToDraw)
		{			
			CGContextMoveToPoint(context, line.fromPoint.x, line.fromPoint.y);
			CGContextAddLineToPoint(context, line.toPoint.x, line.toPoint.y);
			CGContextStrokePath(context);
			
//			CGFloat nodeRadius = 14.0;
			
//			CGRect fromBubbleFrame = CGRectMake(line.fromPoint.x- nodeRadius/2, line.fromPoint.y - nodeRadius/2, nodeRadius, nodeRadius);
            
            UIColor *color = kLineGridColor;
            [color  setFill];
            
			CGContextSetFillColorWithColor(context, color.CGColor);
//			CGContextFillEllipseInRect(context, fromBubbleFrame);
			
//			if(line.isFullLength){
//			CGRect toBubbleFrame = CGRectMake(line.toPoint.x - nodeRadius/2, line.toPoint.y - nodeRadius/2, nodeRadius, nodeRadius);
//			CGContextFillEllipseInRect(context, toBubbleFrame);
//			}
		}
}
@end
