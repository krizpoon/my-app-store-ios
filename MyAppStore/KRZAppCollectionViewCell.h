//
//  KRZAppCollectionViewCell.h
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRZAppEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRZAppCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readwrite) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic, readwrite) IBOutlet UILabel * categoryLabel;
@property (strong, nonatomic, readwrite) IBOutlet UIImageView * logoView;

@property (strong, nonatomic, readwrite) KRZAppEntry * app;

@end

NS_ASSUME_NONNULL_END
