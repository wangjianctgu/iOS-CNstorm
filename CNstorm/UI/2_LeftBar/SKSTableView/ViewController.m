//
//  ViewController.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "ViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "TabBarViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *contents;
@property(nonatomic, assign) NSInteger previousRow;
@property(nonatomic, assign) NSInteger previousSection;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)contents
{
    if (!_contents) {
//        _contents = @[@[@[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
//                      @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
//                      @[@"Section0_Row2"]],
//                      @[@[@"Section1_Row0", @"Row0_Subrow1", @"Row0_Subrow2", @"Row0_Subrow3"],
//                        @[@"Section1_Row1"],
//                        @[@"Section1_Row2", @"Row2_Subrow1", @"Row2_Subrow2", @"Row2_Subrow3", @"Row2_Subrow4", @"Row2_Subrow5"]]];
        
        //衣服:衬衫、裙子、裤子、内衣
        //鞋子:高跟鞋、运动鞋、袜子
        //包包:单肩、双肩、手提包、斜挎
        //饰品:项链、耳环、手链、戒指
        
        _contents = @[
                      @[
                          @[@"服装", @"全部服装",@"衬衫",@"裙子",@"裤子",@"内衣"],
                          @[@"鞋子", @"全部鞋子",@"高跟鞋", @"运动鞋", @"鞋袜"],
                          @[@"包包", @"全部包包",@"单肩包", @"双肩包", @"手提包", @"斜挎包"],
                          @[@"饰品", @"全部饰品",@"项链", @"耳环", @"手链", @"戒指"]
                       ],
                      
                      @[
                        @[@"品牌", @"全部品牌",@"七匹狼",@"耐克",@"阿迪达斯",@"匹克"]
                       ]
                     ];
    }
    
    return _contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.SKSTableViewDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //遮挡无数据部分tableView的分割线
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    tableView.separatorColor = [UIColor colorWithRed:(229.0f)/255.0f green:(229.0f)/255.0f blue:(229.0f)/255.0f alpha:(1.0f)];
    
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
    
    //[tableView setSeparatorColor:[UIColor clearColor]];
    
    if ((indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2|| indexPath.row == 3)) ||
        (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2|| indexPath.row == 3))
       )
        cell.isExpandable = YES;
    else
        cell.isExpandable = NO;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor purpleColor];
    
    tableView.separatorColor = [UIColor purpleColor];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == self.previousSection)
//    {
//        if (indexPath.row == self.previousRow) {
//            // Close the drawer without no further actions on the center view controller
//            [self.drawer close];
//        }
//        else {
//            // Reload the current center view controller and update its background color
//            //        typeof(self) __weak weakSelf = self;
//            //        [self.drawer reloadCenterViewControllerUsingBlock:^(){
//            //            NSParameterAssert(weakSelf.colors);
//            //            weakSelf.drawer.centerViewController.view.backgroundColor = weakSelf.colors[indexPath.row];
//            //        }];
//            
//            //        // Replace the current center view controller with a new one
//            //        ICSPlainColorViewController *center = [[ICSPlainColorViewController alloc] init];
//            //        center.view.backgroundColor = [UIColor colorWithRed:(251.0f/255.0f) green:(110.0f/255.0f) blue:(83.0f/255.0f) alpha:(1.0f)];
//            //        [self.drawer replaceCenterViewControllerWithViewController:center];
//        }
//    }
//    self.previousSection = indexPath.section;
//    self.previousRow = indexPath.row;
    
    __block SKSTableViewCell *cell = (SKSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!([cell isKindOfClass:[SKSTableViewCell class]] && cell.isExpandable))
    {
        [self.drawer close];
        NSLog(@"indexPath.row = %ld",(long)indexPath.row);
        NSLog(@"indexPath.section = %ld",(long)indexPath.section);
        
        [self pushGoodsList];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

#pragma mark - ICSDrawerControllerPresenting
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)pushGoodsList
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedPushGoodsList:)])
    {
        [self.delegate didFinishedPushGoodsList:self];
        
        ((TabBarViewController *)self.drawer.centerViewController).selectedIndex = 0;
    }
}

#pragma mark 控制状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
