//
//  ProvinceViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-21.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "ProvinceViewController.h"

@interface ProvinceViewController ()

@end

@implementation ProvinceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.provinceIndexList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择省/洲";
    
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
    //json 不能写注释和空格，否则读不到
    NSString *provinceJson = [[NSBundle mainBundle]pathForResource:@"province" ofType:@"json"];
    
    NSMutableArray *provinceArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:provinceJson] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *indexArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    for (int i = 0; i<26; i++)
    {
        ProvinceIndex *provinceIndex = [[ProvinceIndex alloc]init];
        provinceIndex.indexTitle = indexArray[i];
        [self.provinceIndexList addObject:provinceIndex];
    }
    
    for (NSMutableDictionary *provinceDictionary in provinceArray)
    {
        Province *province = [[Province alloc]init];
        province.zone_id = [[provinceDictionary objectForKey:@"zone_id"]intValue];
        province.country_id = [[provinceDictionary objectForKey:@"country_id"]intValue];
        province.name = [provinceDictionary objectForKey:@"name"];
        province.code = [provinceDictionary objectForKey:@"code"];
        province.status = [[provinceDictionary objectForKey:@"status"]intValue];
        
        if (province.country_id == self.selectedCountryId)
        {
            for (ProvinceIndex *provinceIndexTemp in self.provinceIndexList)
            {
                if([provinceIndexTemp.indexTitle isEqualToString:[province.name substringToIndex:1]])
                {
                    [provinceIndexTemp.provinceList addObject:province];
                }
            }
        }
    }
    
    //去掉无省份的字母索引
    for(int i=0; i<self.provinceIndexList.count; i++)
    {
        ProvinceIndex *provinceIndexTemp = [self.provinceIndexList objectAtIndex:i];
        
        if(provinceIndexTemp.provinceList.count == 0)
        {
            [self.provinceIndexList removeObjectAtIndex:i];
            i--;
        }
    }
}

// 创建tableView
- (void) createTableView
{
    self.baTableView = [[BATableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenWidth, MainScreenHeight-NavigationBarHeight)];
    self.baTableView.delegate = self;
    self.baTableView.tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    self.baTableView.tableView.separatorInset = UIEdgeInsetsZero;
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
    headerView.titleIndexLabel.text = ((ProvinceIndex *)self.provinceIndexList[section]).indexTitle;
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView
{
    NSMutableArray *indexTitles = [NSMutableArray array];
    
    for (ProvinceIndex *provinceIndex in self.provinceIndexList)
    {
        [indexTitles addObject:provinceIndex.indexTitle];
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
    
    return self.provinceIndexList.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((ProvinceIndex *)self.provinceIndexList[section]).provinceList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *BATableViewCellIdentifier = @"BATableViewCellIdentifier";
    
    BATableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BATableViewCellIdentifier];
    if (!cell) {
        cell = [[BATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BATableViewCellIdentifier];
    }
    
    ProvinceIndex *provinceIndex = (ProvinceIndex *)self.provinceIndexList[indexPath.section];
    
    Province *province = (Province *)provinceIndex.provinceList[indexPath.row];
    
    cell.title = province.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Province *selectedProvince = ((ProvinceIndex *)self.provinceIndexList[indexPath.section]).provinceList[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedReturnProvince:)])
    {
        [self.delegate didFinishedReturnProvince:selectedProvince];
    }
}

@end
