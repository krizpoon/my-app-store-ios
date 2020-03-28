//
//  KRZAppsService.h
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRZAppsService : NSObject

+ (void) fetchAppsOfType:(NSString *)type limit:(NSInteger)limit withRating:(BOOL)withRating completionHandler:(void (^)(NSArray*))completionHandler;

@end

NS_ASSUME_NONNULL_END
