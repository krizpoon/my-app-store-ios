//
//  KRZAppEntry.h
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRZAppEntry : NSObject

@property (strong, nonatomic, readwrite) NSString * appId;
@property (strong, nonatomic, readwrite) NSString * name;
@property (strong, nonatomic, readwrite) NSString * title;
@property (strong, nonatomic, readwrite) NSString * link;
@property (strong, nonatomic, readwrite) NSString * summary;
@property (strong, nonatomic, readwrite) NSString * author;
@property (strong, nonatomic, readwrite) NSString * categoryName;
@property (strong, nonatomic, readwrite) NSString * logoUrl;
@property (assign, nonatomic, readwrite) NSInteger rank;
@property (assign, nonatomic, readwrite) float averageUserRatingForCurrentVersion;
@property (assign, nonatomic, readwrite) NSInteger userRatingCountForCurrentVersion;

- (void) assignFromFeedEntry:(NSDictionary *)feed;
- (BOOL) matches:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END
