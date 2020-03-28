//
//  KRZAppEntry.m
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "KRZAppEntry.h"

@implementation KRZAppEntry

- (void) assignFromFeedEntry:(NSDictionary *)feed;
{
    NSDictionary * idObj = [feed objectForKey:@"id"];
    NSString * link = [idObj objectForKey:@"label"];
    
    NSDictionary * idAttributesObj = [idObj objectForKey:@"attributes"];
    NSString * appId = [idAttributesObj objectForKey:@"im:id"];
    
    NSDictionary * nameObj = [feed objectForKey:@"im:name"];
    NSString * name = [nameObj objectForKey:@"label"];
    
    NSDictionary * titleObj = [feed objectForKey:@"title"];
    NSString * title = [titleObj objectForKey:@"label"];
    
    NSDictionary * artistObj = [feed objectForKey:@"im:artist"];
    NSString * author = [artistObj objectForKey:@"label"];
    
    NSDictionary * summaryObj = [feed objectForKey:@"summary"];
    NSString * summary = [summaryObj objectForKey:@"label"];
    
    NSDictionary * categoryObj = [feed objectForKey:@"category"];
    NSDictionary * categoryAttributesObj = [categoryObj objectForKey:@"attributes"];
    NSString * categoryName  = [categoryAttributesObj objectForKey:@"label"];
    
    NSString * logoUrl = NULL;
    NSInteger maxHeight = 0;
    NSArray * images = [feed objectForKey:@"im:image"];
    for (NSDictionary * image in images) {
        NSDictionary * imageAttributesObj = [image objectForKey:@"attributes"];
        NSInteger height = [[imageAttributesObj objectForKey:@"height"] intValue];
        if (height > maxHeight) {
            maxHeight = height;
            logoUrl = [image objectForKey:@"label"];
        }
    }

    self.appId = appId;
    self.name = name;
    self.title = title;
    self.link = link;
    self.author = author;
    self.summary = summary;
    self.categoryName = categoryName;
    self.logoUrl = logoUrl;
}

- (BOOL) matches:(NSString *)keyword;
{
    if (!keyword.length) return YES;
    if ([self.name rangeOfString:keyword options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    if ([self.title rangeOfString:keyword options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    if ([self.summary rangeOfString:keyword options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    if ([self.author rangeOfString:keyword options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    if ([self.categoryName rangeOfString:keyword options:NSCaseInsensitiveSearch].location != NSNotFound) return YES;
    return NO;
}

@end
