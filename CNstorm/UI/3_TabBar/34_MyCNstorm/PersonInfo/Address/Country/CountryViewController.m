//
//  CountryViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.countryIndexList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择国家";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self initTableViewData];
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)popToRootView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//选项卡导航
- (void)showMenu:(id)sender
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"首页"
                     image:[UIImage imageNamed:@"home"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"搜索"
                     image:[UIImage imageNamed:@"searchGoods"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"购物车"
                     image:[UIImage imageNamed:@"cart"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"我的"
                     image:[UIImage imageNamed:@"myCNstorm"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    //    KxMenuItem *first = menuItems[0];
    //    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu setTintColor: [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5]];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(282.0f,-22.0f,22.0f,22.0f)
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    KxMenuItem *kxMenuItem = (KxMenuItem *)sender;
    NSUInteger selectedIndex = 0;
    if([kxMenuItem.title isEqualToString:@"首页"])
    {
        selectedIndex = 0;
    }
    else if([kxMenuItem.title isEqualToString:@"搜索"])
    {
        selectedIndex = 1;
    }
    else if([kxMenuItem.title isEqualToString:@"购物车"])
    {
        selectedIndex = 2;
    }
    else
    {
        selectedIndex = 3;
    }
    
    self.tabBarController.selectedIndex = selectedIndex;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)initTableViewData
{
    NSString *countryJson = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"json"];
    
    NSMutableArray *countryArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:countryJson] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *hotCountryArray = @[@"Australia",@"Austria",@"Belgium",@"Brazil",@"China",@"Canada",@"France",@"Metropolitan",@"Germany",@"India",@"Ireland",@"Japan",@"New Zealand",@"Spain",@"United Kingdom",@"United States"];
    
    NSArray *indexArray = @[@"Hot",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"Y",@"Z"];
    
    for (int i = 0; i<26; i++)
    {
        CountryIndex *countryIndex = [[CountryIndex alloc]init];
        countryIndex.indexTitle = indexArray[i];
        [self.countryIndexList addObject:countryIndex];
    }
    
    for (NSMutableDictionary *countryDictionary in countryArray)
    {
        Country *country = [[Country alloc]init];
        country.country_id = [[countryDictionary objectForKey:@"country_id"]intValue];
        country.name = [countryDictionary objectForKey:@"name"];
        country.iso_code_2 = [countryDictionary objectForKey:@"iso_code_2"];
        country.iso_code_3 = [countryDictionary objectForKey:@"iso_code_3"];
        country.address_format = [countryDictionary objectForKey:@"address_format"];
        country.postcode_required = [[countryDictionary objectForKey:@"postcode_required"]intValue];
        country.status = [[countryDictionary objectForKey:@"status"]intValue];
        
        
        for (CountryIndex *countryIndexTemp in self.countryIndexList)
        {
            if([countryIndexTemp.indexTitle isEqualToString:[country.name substringToIndex:1]])
            {
                [countryIndexTemp.countryList addObject:country];
            }
            
            //插入热门国家
            if ([countryIndexTemp.indexTitle isEqualToString:@"Hot"]&&[hotCountryArray containsObject:country.name])
            {
                [countryIndexTemp.countryList addObject:country];
            }
        }
    }
}

// 创建tableView
- (void) createTableView
{
    self.baTableView = [[BATableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.baTableView.delegate = self;
    [self.view addSubview:self.baTableView];
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BATableViewHeaderView *headerView = [[BATableViewHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];//创建一个视图
    headerView.titleIndexLabel.text = ((CountryIndex *)self.countryIndexList[section]).indexTitle;
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView
{
    NSMutableArray *indexTitles = [NSMutableArray array];
    
    for (CountryIndex *countryIndex in self.countryIndexList)
    {
        [indexTitles addObject:countryIndex.indexTitle];
    }
    return indexTitles;
}

//缩进10px
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    tableView.separatorInset = UIEdgeInsetsZero;
    return self.countryIndexList.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((CountryIndex *)self.countryIndexList[section]).countryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *BATableViewCellIdentifier = @"BATableViewCellIdentifier";
    
    BATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BATableViewCellIdentifier];
    if (!cell) {
        cell = [[BATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BATableViewCellIdentifier];
    }
    
    CountryIndex *countryIndex = (CountryIndex *)self.countryIndexList[indexPath.section];
    
    Country *country = (Country *)countryIndex.countryList[indexPath.row];
    
    cell.title = country.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Country *selectedCountry = ((CountryIndex *)self.countryIndexList[indexPath.section]).countryList[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturnCountry:)])
    {
        [self.delegate didFinishedReturnCountry:selectedCountry];
    }
}

@end
