//
//  KRZRatingBar.h
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRZStarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRZRatingBar : UIView

@property (strong, nonatomic, readwrite) IBOutletCollection(KRZStarView) NSArray * starViews;
@property (assign, nonatomic, readwrite) float rating; // range [0-1]

@end

NS_ASSUME_NONNULL_END
