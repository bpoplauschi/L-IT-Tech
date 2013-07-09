//
//  LITAddMealViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAddMealViewController.h"

@interface LITAddMealViewController ()

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSArray               *sectionTitleArray;
@property (nonatomic, strong) NSMutableDictionary   *sectionContentDict;
@property (nonatomic, strong) NSMutableArray        *arrayForBool;


@end

@implementation LITAddMealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Meal", @"");

        _sectionTitleArray = @[@"Meat & Fish", @"Fruits", @"Fats", @"Milk and cheese", @"Eggs", @"Cereals", @"Sweets"];
        _arrayForBool = [NSMutableArray arrayWithArray:@[@NO, @NO, @NO, @NO, @NO, @NO, @NO]];
        
        _sectionContentDict = [NSMutableDictionary dictionary];
        [_sectionContentDict setValue:@[
         @{@"Chicken": @142},
         @{@"Veal": @277},
         @{@"Lamb": @260},
         @{@"Pork": @340},
         @{@"Carp": @104},
         @{@"Herring": @167},
         @{@"Salami": @517}]
                               forKey:_sectionTitleArray[0]];
        
        [_sectionContentDict setValue:@[
         @{@"Cherries": @21},
         @{@"Grapefruit": @30},
         @{@"Lemons": @36},
         @{@"Tangerines": @40},
         @{@"Apples": @67},
         @{@"Pears": @79},
         @{@"Oranges": @47},
         @{@"Plums": @89},
         @{@"Grapes": @93}
         ]
                               forKey:_sectionTitleArray[1]];
        
        [_sectionContentDict setValue:@[
         @{@"Butterine": @764},
         @{@"Cream": @297},
         @{@"Sunflower oil": @930},
         @{@"Butter": @721},
         @{@"Lard": @927},
         ]
                               forKey:_sectionTitleArray[2]];
        
        [_sectionContentDict setValue:@[
         @{@"Cow cheese": @155},
         @{@"Bellows cheese": @369},
         @{@"Pressed cheese": @233},
         @{@"Yogurt": @50},
         @{@"Milk": @65},
         @{@"Telemea": @273},
         ]
                               forKey:_sectionTitleArray[3]];
        
        [_sectionContentDict setValue:@[
         @{@"Chicken eggs": @171},
         ]
                               forKey:_sectionTitleArray[4]];
        
        [_sectionContentDict setValue:@[
         @{@"Crackers": @425},
         @{@"Wheat flour": @349},
         @{@"Corn flour": @351},
         @{@"Rice": @354},
         @{@"White bread": @247},
         @{@"Dark bread": @242},
         @{@"Pasta": @386}
         ]
                               forKey:_sectionTitleArray[5]];
        
        [_sectionContentDict setValue:@[
         @{@"Milk chocolate": @605},
         @{@"Cherry sweets": @282},
         @{@"Apricots jam": @240},
         @{@"Cherry jam": @250},
         @{@"Honey": @304},
         @{@"Sugar": @410},
         ]
                               forKey:_sectionTitleArray[6]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionTitleArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self.arrayForBool objectAtIndex:section] boolValue]) {
        return [[self.sectionContentDict valueForKey:[self.sectionTitleArray objectAtIndex:section]] count];
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor whiteColor];
    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
    BOOL manyCells                  = [[self.arrayForBool objectAtIndex:section] boolValue];
    headerString.font = [UIFont boldSystemFontOfSize:20];
    headerString.text = [_sectionTitleArray objectAtIndex:section];
    headerString.textAlignment      = NSTextAlignmentLeft;
    headerString.textColor          = [UIColor blackColor];
    [headerView addSubview:headerString];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 10, 30, 30);
    [headerView addSubview:upDownArrow];
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 50;
    }
    return 1;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    BOOL manyCells  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
    if (manyCells) {
        NSArray *content = [self.sectionContentDict valueForKey:[self.sectionTitleArray objectAtIndex:indexPath.section]];
        cell.textLabel.text = [[[content objectAtIndex:indexPath.row] allKeys] lastObject];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DetailViewController *dvc;
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
//        dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone"  bundle:[NSBundle mainBundle]];
//    }else{
//        dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad"  bundle:[NSBundle mainBundle]];
//    }
//    dvc.title        = [sectionTitleArray objectAtIndex:indexPath.section];
//    dvc.detailItem   = [[sectionContentDict valueForKey:[sectionTitleArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:dvc animated:YES];
//    
}


#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [self.arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
