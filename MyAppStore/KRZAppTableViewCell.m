//
//  KRZAppTableViewCell.m
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZAppTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface KRZAppTableViewCell() {
    KRZAppEntry * _app;
    BOOL _roundLogo;
}
@end

@implementation KRZAppTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = @"";
    self.categoryLabel.text = @"";
    self.rankLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setApp:(KRZAppEntry *)app {
    _app = app;
    self.nameLabel.text = app.name;
    self.categoryLabel.text = app.categoryName;
    self.rankLabel.text = app.rank > 0? [NSString stringWithFormat:@"%ld", app.rank]: @"";
    self.ratingBar.rating = app.averageUserRatingForCurrentVersion / 5.f;
    self.ratingCountLabel.text = [NSString stringWithFormat:@"(%ld)", app.userRatingCountForCurrentVersion];
    
    NSURL * url = app.logoUrl? [NSURL URLWithString:app.logoUrl]: NULL;
    [self.logoView sd_setImageWithURL:url];
}

- (void) setRoundLogo:(BOOL)roundLogo {
    _roundLogo = roundLogo;
    CGFloat size = self.logoView.bounds.size.width;
    self.logoView.layer.cornerRadius = roundLogo ? size / 2.f : size / 5.f;
}

@end
