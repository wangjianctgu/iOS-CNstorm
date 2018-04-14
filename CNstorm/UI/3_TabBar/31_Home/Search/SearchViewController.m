//
//  SearchViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-8.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.seachHistoryArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, NavigationBarHeight)];
    navigationView.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:1.0f];
    [self.view addSubview:navigationView];
    
    self.mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 20.0f, MainScreenWidth, NavigationItemHeight)];
    self.mySearchBar.placeholder = @"搜寻商品";
    self.mySearchBar.delegate = self;
    self.mySearchBar.tintColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    [self.mySearchBar becomeFirstResponder];
    
    float version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if ([self.mySearchBar respondsToSelector:@selector(barTintColor)])
    {
        float  iosversion7_1 = 7.1;
        if (version >= iosversion7_1)
        {
            //iOS7.1
            [[[[self.mySearchBar.subviews objectAtIndex:0]subviews]objectAtIndex:0] removeFromSuperview ];
            [self.mySearchBar setBackgroundColor:[UIColor clearColor]];
        }
        else
        {
            //iOS7.0
            [self.mySearchBar setBarTintColor:[UIColor clearColor]];
            [self.mySearchBar setBackgroundColor:[UIColor clearColor]];
        }
    }
    else
    {
        //iOS7.0 以下
        [[self.mySearchBar.subviews objectAtIndex:0] removeFromSuperview];
        [self.mySearchBar setBackgroundColor:[ UIColor clearColor]];
    }
    [navigationView addSubview:self.mySearchBar];
    
    //初始化serch.plist文件
    [self readSearchListFromPlist];
    
    //保存搜索记录
//    self.seachHistoryArray = [@[@"百度",@"六六",@"谷歌",@"苹果",@"and",@"table",@"view",@"and",@"and",@"苹果IOS",@"谷歌android",@"微软",@"微软WP",@"table",@"table",@"table",@"六六",@"六六",@"六六",@"table",@"table",@"table"]mutableCopy];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mySearchBar becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)initTableView
{
    self.searchResultsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, NavigationBarHeight,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TabBarHeight)];
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.searchResultsTableView];

    self.searchHistoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, NavigationBarHeight,MainScreenWidth,MainScreenHeight-NavigationBarHeight-TabBarHeight)];
    self.searchHistoryTableView.delegate = self;
    self.searchHistoryTableView.dataSource = self;
    self.searchHistoryTableView.backgroundColor = [UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0f];
    [self.view addSubview:self.searchHistoryTableView];
    
    [self reloadTableView];
}

- (void)reloadTableView
{
    [self.searchResultsTableView reloadData];
    
    [self.searchHistoryTableView reloadData];
}

- (void)popToRootView
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

/**********************************搜索部分**************************************/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.searchResultsTableView)
    {
        if (self.searchResultArray.count == 0)
        {
            return 70.0f;
        }
        else
        {
            return 0.0f;
        }
    }
    else
    {
        if (self.seachHistoryArray.count == 0)
        {
            return 70.0f;
        }
        else
        {
            return 70.0f;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == self.searchResultsTableView)
    {
        if (self.searchResultArray.count == 0)
        {
            SearchTableViewFooterView *footerView = [[SearchTableViewFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth, 70.0f)];
            [footerView.btn setTitle:@"暂无匹配记录" forState:UIControlStateNormal];
            footerView.btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            [footerView.btn setTitleColor:[UIColor colorWithRed:(153.0f)/255.0f green:(153.0f)/255.0f blue:(153.0f)/255.0f alpha:1] forState:UIControlStateNormal];
            footerView.btn.backgroundColor = [UIColor colorWithRed:(250.0f)/255.0f green:(250.0f)/255.0f blue:(250.0f)/255.0f alpha:1];
            return footerView;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        if (self.seachHistoryArray.count == 0)
        {
            SearchTableViewFooterView *footerView = [[SearchTableViewFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth, 70.0f)];
            [footerView.btn setTitle:@"暂无搜索记录" forState:UIControlStateNormal];
            footerView.btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            [footerView.btn setTitleColor:[UIColor colorWithRed:(153.0f)/255.0f green:(153.0f)/255.0f blue:(153.0f)/255.0f alpha:1] forState:UIControlStateNormal];
            footerView.btn.backgroundColor = [UIColor colorWithRed:(250.0f)/255.0f green:(250.0f)/255.0f blue:(250.0f)/255.0f alpha:1];
            return footerView;
        }
        else
        {
            SearchTableViewFooterView *footerView = [[SearchTableViewFooterView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,MainScreenWidth, 70.0f)];
            [footerView.btn setTitle:@"清空搜索记录" forState:UIControlStateNormal];
            footerView.btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [footerView.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            footerView.btn.backgroundColor = [UIColor colorWithRed:(251.0f)/255.0f green:(110.0f)/255.0f blue:(83.0f)/255.0f alpha:1];
            [footerView.btn.layer setCornerRadius:3.0f];
            footerView.btn.layer.borderWidth = 0.5f;
            footerView.btn.layer.borderColor = [UIColor colorWithRed:(224.0f)/255.0f green:(77.0f)/255.0f blue:(47.0f)/255.0f alpha:1].CGColor;
            [footerView.btn addTarget:self action:@selector(deleteAllSearchList:) forControlEvents:UIControlEventTouchUpInside];

            return footerView;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    
    if (tableView == self.searchResultsTableView)
    {
        self.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return self.searchResultArray.count;
    }
    else
    {
        self.searchHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return self.seachHistoryArray.count;
    }
    
    return rows;
}

#pragma mark - 方法:cell的加载和复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchTableViewCell";
    
    SearchTableViewCell *cell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchResultsTableView)
    {
        self.searchResultsTableView.contentSize = CGSizeMake(MainScreenWidth,self.self.searchResultArray.count*44.0f+256.0f);
        cell.title = self.searchResultArray[indexPath.row];
    }
    else
    {
        self.searchHistoryTableView.contentSize = CGSizeMake(MainScreenWidth,self.self.seachHistoryArray.count*44.0f+256.0f);
        cell.title = self.seachHistoryArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - cell的被选择后触发监听事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *searchText =@"";
    
    if (tableView == self.searchResultsTableView)
    {
        searchText = self.searchResultArray[indexPath.row];
    }
    else
    {
        searchText = self.seachHistoryArray[indexPath.row];
    }
    
    SearchGoodsListViewController *searchGoodsListViewController = [[SearchGoodsListViewController alloc] initWithNibName:@"SearchGoodsListViewController" bundle:nil];
    searchGoodsListViewController.hidesBottomBarWhenPushed = YES;
    searchGoodsListViewController.keyWord = searchText;
    [self.navigationController pushViewController:searchGoodsListViewController animated:YES];
}

#pragma mark - UISearchBarDelegate 协议
// UISearchBar得到焦点并开始编辑时，执行该方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.mySearchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
    
    [self.mySearchBar setShowsCancelButton:NO animated:YES];
    
    [self popToRootView];
}

// 键盘中，搜索按钮被按下，执行的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.mySearchBar.text isEqualToString:@""])
    {
        [self popToRootView];
    }
    else
    {
        [self.mySearchBar resignFirstResponder];// 放弃第一响应者
        [self.mySearchBar setShowsCancelButton:NO animated:YES];
        
        NSString *searchBarText = [NSString stringWithFormat:@"%@",searchBar.text];
        if(![self.seachHistoryArray containsObject:searchBarText])
        {
            [self.seachHistoryArray insertObject:searchBarText atIndex:0];
            [self.searchHistoryTableView reloadData];
            [self writeSearchListToPlist];
        }
        
        SearchGoodsListViewController *searchGoodsListViewController = [[SearchGoodsListViewController alloc] initWithNibName:@"SearchGoodsListViewController" bundle:nil];
        searchGoodsListViewController.hidesBottomBarWhenPushed = YES;
        searchGoodsListViewController.keyWord = searchBarText;
        [self.navigationController pushViewController:searchGoodsListViewController animated:YES];
    }

}

// 当搜索内容变化时，执行该方法，很有用，可以实现时实搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.mySearchBar.text.length == 0)
    {
        [self.view insertSubview:self.searchHistoryTableView aboveSubview:self.searchResultsTableView];
    }
    else
    {
        [self.view insertSubview:self.searchResultsTableView aboveSubview:self.searchHistoryTableView];
    }
    
    self.searchResultArray = [NSMutableArray arrayWithCapacity:0];
    
    if (self.mySearchBar.text.length > 0 && ![ChineseInclude isIncludeChineseInString:self.mySearchBar.text])
    {
        for (int i=0; i<self.seachHistoryArray.count; i++)
        {
            if ([ChineseInclude isIncludeChineseInString:self.seachHistoryArray[i]])
            {
                //全拼音匹配
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:self.seachHistoryArray[i]];
                
                NSRange titleResult=[tempPinYinStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0)
                {
                    [self.searchResultArray addObject:self.seachHistoryArray[i]];
                }
            }
            else
            {
                NSRange titleResult = [self.seachHistoryArray[i] rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0)
                {
                    [self.searchResultArray addObject:self.seachHistoryArray[i]];
                }
            }
        }
    }
    else if (self.mySearchBar.text.length>0 && [ChineseInclude isIncludeChineseInString:self.mySearchBar.text])
    {
        for (NSString *tempStr in self.seachHistoryArray)
        {
            NSRange titleResult=[tempStr rangeOfString:self.mySearchBar.text options:NSCaseInsensitiveSearch];
            
            if (titleResult.length>0)
            {
                [self.searchResultArray addObject:tempStr];
            }
        }
    }
    
    [self reloadTableView];
}

/****************************读写.plist文件********************************/
- (void)readSearchListFromPlist
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filename=[path stringByAppendingPathComponent:@"searchList.plist"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filename])
    {
        NSLog(@"searchList.plist");
        //不存在则创建,创建成功
        if([[NSFileManager defaultManager] createFileAtPath:filename contents:nil attributes:nil])
        {
            NSLog(@"create file success");
        }
        else
        {
            NSLog(@"create file error");
        }
	}
    else
    {
        self.seachHistoryArray = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    }
}

- (void)writeSearchListToPlist
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filename=[path stringByAppendingPathComponent:@"searchList.plist"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filename])
    {
        
        NSLog(@"searchList.plist");
        //不存在则创建,创建成功
        if([[NSFileManager defaultManager] createFileAtPath:filename contents:nil attributes:nil])
        {
            [self.seachHistoryArray writeToFile:filename atomically:YES];
        }
        else
        {
            NSLog(@"create file error");
        }
	}
    else
    {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:filename error:&error];
        [self.seachHistoryArray writeToFile:filename atomically:YES];
    }
}

- (void)deleteAllSearchList:(id)sender
{
    [self.seachHistoryArray removeAllObjects];
    [self.searchHistoryTableView reloadData];
    [self writeSearchListToPlist];
}

@end
