//
//  KRZStarView.m
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZStarView.h"

@implementation KRZStarView

- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // map to draw box (-10 0 522 512)
    CGFloat a = w / 522;
    CGFloat b = 0;
    CGFloat c = 0;
    CGFloat d = h / 512;
    CGFloat tx = -10 / 522;
    CGFloat ty = 0;
    CGContextConcatCTM(context, CGAffineTransformMake(a, b, c, d, tx, ty));

    // apply matrix
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, 448));
    
    CGFloat x, y;
    CGContextMoveToPoint(context, x = 256, y = 80); // M256 80
    CGContextAddLineToPoint(context, x += 132, y += -80); // l132 -80
    CGContextAddLineToPoint(context, x += -35, y += 150); // l-35 150
    CGContextAddLineToPoint(context, x += 116, y += 101); // l116 101
    CGContextAddLineToPoint(context, x += -153, y += 13); // l-153 13
    
    CGContextAddLineToPoint(context, x += -60, y += 141); // l-60 141
    CGContextAddLineToPoint(context, x += -60, y += -141); // l-60 -141
    CGContextAddLineToPoint(context, x += -153, y += -13); // l-153 -13
    CGContextAddLineToPoint(context, x += 116, y += -101); // l116 -101
    CGContextAddLineToPoint(context, x += -35, y += -150); // l-35 -150
    CGContextClosePath(context); // z
    
    CGColorRef color = self.tintColor? self.tintColor.CGColor: [UIColor orangeColor].CGColor;
    CGContextSetFillColorWithColor(context, color);
    CGContextSetLineWidth(context, 24.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, color);

    if (self.fill && self.outline) {
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    else if (self.outline) {
        CGContextDrawPath(context, kCGPathStroke);
    }
    else if (self.fill) {
        CGContextDrawPath(context, kCGPathFill);
    }
}

@end
