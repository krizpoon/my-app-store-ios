//
//  KRZRatingBar.m
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZRatingBar.h"

@interface KRZRatingBar() {
    float _rating;
}
@end


@implementation KRZRatingBar

- (void) setRating:(float)rating {
    _rating = rating;
    NSInteger max = self.starViews.count;
    NSInteger numFilled = roundf(rating * (float)max);
    for (NSInteger i = 0; i < max; i++) {
        KRZStarView * star = [self.starViews objectAtIndex:i];
        star.fill = (i < numFilled);
        star.outline = YES;
    }
}

@end
