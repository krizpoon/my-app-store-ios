//
//  ViewController.h
//  MyAppStorre
//
//  Created by POON KWOK CHEUNG on 28/3/2020.
//  Copyright © 2020 POON KWOK CHEUNG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating>

@property (strong, nonatomic, readwrite) UISearchController * searchController;
@property (strong, nonatomic, readwrite) IBOutlet UICollectionView * recommendedAppsCollectionView;

@end
