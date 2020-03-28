//
//  KRZAppTableViewCell.h
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRZAppEntry.h"
#import "KRZRatingBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRZAppTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite) IBOutlet UILabel * rankLabel;
@property (strong, nonatomic, readwrite) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic, readwrite) IBOutlet UILabel * categoryLabel;
@property (strong, nonatomic, readwrite) IBOutlet UIImageView * logoView;
@property (strong, nonatomic, readwrite) IBOutlet KRZRatingBar * ratingBar;
@property (strong, nonatomic, readwrite) IBOutlet UILabel * ratingCountLabel;

@property (strong, nonatomic, readwrite) KRZAppEntry * app;
@property (assign, nonatomic, readwrite) BOOL roundLogo;

@end

NS_ASSUME_NONNULL_END
