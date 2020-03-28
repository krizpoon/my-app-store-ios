//
//  KRZAppsService.m
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZAppsService.h"
#import "KRZAppEntry.h"

@implementation KRZAppsService

+ (NSArray *) appsWithFeedData:(NSData *)data;
{
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:NULL];
    NSDictionary * feed = [json objectForKey:@"feed"];
    NSArray * entries = [feed objectForKey:@"entry"];
    NSMutableArray * apps = [NSMutableArray array];
    
    for (NSDictionary * entry in entries) {
        KRZAppEntry * app = [KRZAppEntry new];
        [app assignFromFeedEntry:entry];
        [apps addObject:app];
    }
    return apps;
}


+ (void) mergeApps:(NSArray *)apps withDetailFeedData:(NSData *)data;
{
    NSMutableDictionary * appsById = [NSMutableDictionary dictionary];
    for (KRZAppEntry * app in apps) {
        [appsById setObject:app forKey:app.appId];
    }
    
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:NULL];
    NSArray * results = [json objectForKey:@"results"];
    for (NSDictionary * result in results) {
        NSString * appId = [[result objectForKey:@"trackId"] stringValue];
        KRZAppEntry * app = [appsById objectForKey:appId];
        app.averageUserRatingForCurrentVersion = [[result objectForKey:@"averageUserRatingForCurrentVersion"] floatValue];
        app.userRatingCountForCurrentVersion = [[result objectForKey:@"userRatingCountForCurrentVersion"] integerValue];
    }
}


+ (void) fetchAppDetailsForApps:(NSArray *)apps completionHandler:(void (^)(void))completionHandler;
{
    NSURLSession * session = [NSURLSession sharedSession];

    NSMutableArray * ids =[NSMutableArray array];
    for (KRZAppEntry * app in apps) {
        [ids addObject:app.appId];
    }
    NSString * idsString = [ids componentsJoinedByString:@","];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/hk/lookup?id=%@", idsString]];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self mergeApps:apps withDetailFeedData:data];
        completionHandler();
    }];

    [task resume];
}


+ (void) fetchAppsOfType:(NSString *)type limit:(NSInteger)limit withRating:(BOOL)withRating completionHandler:(void (^)(NSArray*))completionHandler;
{
    // type: 'topfreeapplications' | 'topgrossingapplications'

    NSURLSession * session = [NSURLSession sharedSession];

    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/hk/rss/%@/limit=%ld/json", type, limit]];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray * apps = [self appsWithFeedData:data];
        for (NSInteger i = 0; i < apps.count; i++) {
            KRZAppEntry * app = [apps objectAtIndex:i];
            app.rank = i + 1;
        }
        
        if (withRating) {
            [self fetchAppDetailsForApps:apps completionHandler:^{
                completionHandler(apps);
            }];
        }
        else {
            completionHandler(apps);
        }
    }];

    [task resume];
}

@end
