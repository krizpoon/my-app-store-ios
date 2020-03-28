//
//  KRZStarView.h
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface KRZStarView : UIView

@property (strong, nonatomic, readwrite) IBInspectable UIColor * tintColor;
@property (assign, nonatomic, readwrite) IBInspectable BOOL fill;
@property (assign, nonatomic, readwrite) IBInspectable BOOL outline;

@end

NS_ASSUME_NONNULL_END
