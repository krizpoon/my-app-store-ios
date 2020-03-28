//
//  KRZAppCollectionViewCell.m
//  MyAppStore
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZAppCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface KRZAppCollectionViewCell() {
    KRZAppEntry * _app;
}
@end


@implementation KRZAppCollectionViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
    CGFloat size = self.logoView.bounds.size.width;
    self.logoView.layer.cornerRadius = size / 5;

    self.nameLabel.text = @"";
    self.categoryLabel.text = @"";
}

- (void) setApp:(KRZAppEntry *)app {
    _app = app;
    self.nameLabel.text = app.name;
    self.categoryLabel.text = app.categoryName;
    
    NSURL * url = app.logoUrl? [NSURL URLWithString:app.logoUrl]: NULL;
    [self.logoView sd_setImageWithURL:url];
}

@end
