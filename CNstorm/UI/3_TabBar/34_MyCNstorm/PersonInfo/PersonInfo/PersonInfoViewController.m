//
//  PersonInfoViewController.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-6-12.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "PersonInfoViewController.h"

#import "UIdefine.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sectionArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToRootView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabBarCopy"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    //初始化数据
    [self initTableViewData];
    [self initMyView];
}

- (void)initMyView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,0.0f, MainScreenWidth,MainScreenHeight-NavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = RGBCOLOR(229.0f, 229.0f, 229.0f);
    [self.view addSubview:self.tableView];
}

- (void)initTableViewData
{
    NSString *personInfoJson = [[NSBundle mainBundle]pathForResource:@"personInfo" ofType:@"json"];
    
    NSMutableArray *sectionMutableArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:personInfoJson] options:NSJSONReadingMutableContainers error:nil];
    
    
    for (NSMutableArray *mySetionMutableArray in sectionMutableArray)
    {
        MySection *mySection = [[MySection alloc]init];
        
        for (NSMutableDictionary *myRowMutableDictionary in mySetionMutableArray)
        {
            MyRow *myRow = [[MyRow alloc]init];
            myRow.rowImageName = [myRowMutableDictionary objectForKey:@"rowImageName"];
            myRow.rowSelectedImageName = [myRowMutableDictionary objectForKey:@"rowSelectedImageName"];
            myRow.rowName = [myRowMutableDictionary objectForKey:@"rowName"];
            myRow.rowDetail = [myRowMutableDictionary objectForKey:@"rowDetail"];
            [mySection.myRowMutableArray addObject:myRow];
        }
        [self.sectionArray addObject:mySection];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return self.sectionArray.count;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MySection *mySection =  self.sectionArray[section];
    
    return mySection.myRowMutableArray.count;
}

//缩进15px
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 15.0f;
}

//设置每行调用的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"MyCNstormTableViewCell";
    
    MyCNstormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                    CellWithIdentifier];
    if (cell == nil)
    {
        cell = [[MyCNstormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellWithIdentifier];
    }
    
    MySection *mySection =  self.sectionArray[indexPath.section];
    cell.myRow = mySection.myRowMutableArray[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 16.0f, 18.0f, 13.0f);
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 14.0f, 16.0f);
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 11.0f, 16.0f);
        cell.rowDetailLabel.textColor = RGBCOLOR(233.0f,64.0f,86.0f);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults boolForKey:@"isLogin"])
        {
            Customer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"customer"]];
            
            if (!customer.tname || [customer.tname isEqualToString:@""])
            {
                cell.myRow.rowName = [NSString stringWithFormat:@"填写真实姓名"];
                cell.rowDetailLabel.hidden = YES;
            }
            else
            {
                cell.myRow.rowName = customer.tname;
                cell.rowDetailLabel.hidden = NO;
            }
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 10.0f, 16.0f);
    }
    else
    {
        cell.rowImageViewFram = CGRectMake(20.0f, 14.0f, 13.0f, 16.0f);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        RMBAccountViewController *rmbAccountViewController = [[RMBAccountViewController alloc]initWithNibName:@"RMBAccountViewController" bundle:nil];
        [self.navigationController pushViewController:rmbAccountViewController animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        PayRecordViewController *payRecordViewController = [[PayRecordViewController alloc]initWithNibName:@"PayRecordViewController" bundle:nil];
        [self.navigationController pushViewController:payRecordViewController animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        NickNameViewController *nickNameViewController = [[NickNameViewController alloc]initWithNibName:@"NickNameViewController" bundle:nil];
        
        [self.navigationController pushViewController:nickNameViewController animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        UpdatePswViewController *updatePswViewController = [[UpdatePswViewController alloc]initWithNibName:@"UpdatePswViewController" bundle:nil];
        [self.navigationController pushViewController:updatePswViewController animated:YES];
    }
    else
    {
        AddressManageViewController *addressManageViewController = [[AddressManageViewController alloc]initWithNibName:@"AddressManageViewController" bundle:nil];
        [self.navigationController pushViewController:addressManageViewController animated:YES];
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 1.0f)];
    return view;
}

@end
