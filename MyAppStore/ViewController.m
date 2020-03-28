//
//  ViewController.m
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import "ViewController.h"
#import "KRZAppsService.h"
#import "KRZAppTableViewCell.h"
#import "KRZAppCollectionViewCell.h"
#import "KRZAppEntry.h"

@interface ViewController ()
{
    BOOL _topAppsLoading;
    BOOL _recommendedAppsLoading;
}
@property (strong, nonatomic, readwrite) NSArray * topApps;
@property (strong, nonatomic, readwrite) NSArray * topAppsFiltered;
@property (strong, nonatomic, readwrite) NSArray * recommendedApps;
@property (strong, nonatomic, readwrite) NSArray * recommendedAppsFiltered;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"搜尋";
    self.navigationItem.searchController = self.searchController;
    self.definesPresentationContext = YES;
    
    _topAppsLoading = YES;
    [KRZAppsService fetchAppsOfType:@"topfreeapplications" limit:100 withRating:YES completionHandler:^(NSArray * apps) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_topAppsLoading = NO;
            self.topApps = apps;
            [self updateSearchResultsForSearchController:self.searchController];
            [self updateTopAppsViews];
        });
    }];
    [self updateTopAppsViews];

    _recommendedAppsLoading = YES;
    [KRZAppsService fetchAppsOfType:@"topgrossingapplications" limit:10 withRating:NO completionHandler:^(NSArray * apps) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_recommendedAppsLoading = NO;
            self.recommendedApps = apps;
            [self updateSearchResultsForSearchController:self.searchController];
            [self updateRecommendedAppsViews];
        });
    }];
    [self updateRecommendedAppsViews];
}


#pragma mark - Table view

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    BOOL isEmpty = !self.topAppsFiltered.count;
    return isEmpty || _topAppsLoading ? 1 : self.topAppsFiltered.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BOOL isEmpty = !self.topAppsFiltered.count;
    if (_topAppsLoading) {
        return [tableView dequeueReusableCellWithIdentifier:@"loading" forIndexPath:indexPath];
    }
    else if (isEmpty) {
        return [tableView dequeueReusableCellWithIdentifier:@"empty" forIndexPath:indexPath];
    }
    else {
        KRZAppEntry * app = [self.topAppsFiltered objectAtIndex:indexPath.row];
        KRZAppTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"app" forIndexPath:indexPath];
        cell.app = app;
        cell.roundLogo = indexPath.row % 2 == 1;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isEmpty = !self.topAppsFiltered.count;
    if (isEmpty || _topAppsLoading) return;

    KRZAppEntry * app = [self.topAppsFiltered objectAtIndex:indexPath.row];
    [self didPressApp:app];
}


#pragma mark - Collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    BOOL isEmpty = !self.recommendedAppsFiltered.count;
    return isEmpty || _recommendedAppsLoading ? 1 : self.recommendedAppsFiltered.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BOOL isEmpty = !self.recommendedAppsFiltered.count;
    if (_recommendedAppsLoading) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"loading" forIndexPath:indexPath];
    }
    else if (isEmpty) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"empty" forIndexPath:indexPath];
    }
    else {
        KRZAppEntry * app = [self.recommendedAppsFiltered objectAtIndex:indexPath.row];
        KRZAppCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"app" forIndexPath:indexPath];
        cell.app = app;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    BOOL isEmpty = !self.recommendedAppsFiltered.count;
    if (isEmpty || _recommendedAppsLoading) return;
    
    KRZAppEntry * app = [self.recommendedAppsFiltered objectAtIndex:indexPath.row];
    [self didPressApp:app];
}

#pragma mark - Search

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController;
{
    NSString * keyword = searchController.searchBar.text;
    
    if (keyword.length) {
        // filter top apps
        NSMutableArray * topAppsFiltered = [NSMutableArray array];
        for (KRZAppEntry * app in self.topApps) {
            if ([app matches:keyword]) {
                [topAppsFiltered addObject:app];
            }
        }
        self.topAppsFiltered = topAppsFiltered;
        
        // filter recommended apps
        NSMutableArray * recommendedAppsFiltered = [NSMutableArray array];
        for (KRZAppEntry * app in self.recommendedApps) {
            if ([app matches:keyword]) {
                [recommendedAppsFiltered addObject:app];
            }
        }
        self.recommendedAppsFiltered = recommendedAppsFiltered;
    }
    else {
        self.topAppsFiltered = self.topApps;
        self.recommendedAppsFiltered = self.recommendedApps;
    }
    
    [self updateTopAppsViews];
    [self updateRecommendedAppsViews];
}


#pragma mark - Helpers

- (void) updateTopAppsViews;
{
    [self.tableView reloadData];
}

- (void) updateRecommendedAppsViews;
{
    [self.recommendedAppsCollectionView reloadData];
}

- (void) didPressApp:(KRZAppEntry *)app;
{
    if (app.link) {
        NSURL * url = [NSURL URLWithString:app.link];
        NSDictionary * options = @{};
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
            // done
        }];
    }
}
@end
