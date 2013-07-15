//
//  LITAddMealViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/9/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITAddMealViewController.h"
#import "LITPersonManager.h"
#import "LITPerson.h"

@interface LITAddMealViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSArray               *sectionTitleArray;
@property (nonatomic, strong) NSMutableDictionary   *sectionContentDict;
@property (nonatomic, strong) NSMutableArray        *arrayForBool;
@property (nonatomic, strong) NSMutableArray        *currentMealItems;
@property (nonatomic, strong) NSIndexPath           *selectedIndexPath;

- (void)saveAction:(id)sender;

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
        
        _currentMealItems = [NSMutableArray array];
        _selectedIndexPath = nil;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)saveAction:(id)sender {
    int calories = 0;
    for (NSDictionary *dict in self.currentMealItems) {
        calories += [[dict valueForKey:@"calories"] intValue];
    }
    [[LITPersonManager sharedInstance].currentPerson addMealEventWithInfo:[NSString stringWithFormat:@"Consumed %d calories", calories]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionTitleArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.arrayForBool.count) {
        // meal list
        return [_currentMealItems count] + 1;
    }
    
    if ([[self.arrayForBool objectAtIndex:section] boolValue]) {
        return [[self.sectionContentDict valueForKey:[self.sectionTitleArray objectAtIndex:section]] count];
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == self.arrayForBool.count) {
        UIView *aHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
        aHeaderView.tag = section;
        aHeaderView.backgroundColor = [UIColor whiteColor];
        UILabel *headerString = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 34)];
        headerString.font = [UIFont boldSystemFontOfSize:18];
        headerString.text = @"Current meal";
        headerString.textAlignment = NSTextAlignmentLeft;
        headerString.textColor = [UIColor blackColor];
        [aHeaderView addSubview:headerString];
        
        return aHeaderView;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
    headerView.tag = section;
    headerView.backgroundColor = [UIColor whiteColor];
    
    NSString *imageName = nil;
    switch (section) {
        case 0:
            imageName = @"meat_fish";
            break;
        case 1:
            imageName = @"fruits";
            break;
        case 2:
            imageName = @"butter";
            break;
        case 3:
            imageName = @"milk";
            break;
        case 4:
            imageName = @"eggs";
            break;
        case 5:
            imageName = @"cereal";
            break;
        case 6:
            imageName = @"sweet";
            break;
        default:
            break;
    }
    UIImageView *imageView = nil;
    if (imageName.length) {
        imageName = [imageName stringByAppendingPathExtension:@"png"];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView = [[UIImageView alloc] initWithImage:image];
        CGRect frame = imageView.frame;
        frame.origin.x = 8.0;
        frame.origin.y = round((headerView.frame.size.height - frame.size.height) / 2);
        imageView.frame = frame;
        [headerView addSubview:imageView];
    }
    
    CGFloat offsetX = imageView.frame.origin.x + imageView.frame.size.width + 8;
    UILabel *headerString = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, self.view.frame.size.width - offsetX - 50, 34)];
    BOOL manyCells = [[self.arrayForBool objectAtIndex:section] boolValue];
    headerString.font = [UIFont boldSystemFontOfSize:18];
    headerString.text = [_sectionTitleArray objectAtIndex:section];
    headerString.textAlignment = NSTextAlignmentLeft;
    headerString.textColor = [UIColor darkGrayColor];
    [headerView addSubview:headerString];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, manyCells ? 2 : 0, 30, 30);
    [headerView addSubview:upDownArrow];
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.arrayForBool.count) {
        return 34;
    }
    return 34;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.arrayForBool.count) {
        return 40;
    }
    
    if ([[self.arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 30;
    }
    return 1;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == self.arrayForBool.count) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"total_meal"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"total_meal"];
            }
            int calories = 0;
            for (NSDictionary *dict in self.currentMealItems) {
                calories += [[dict valueForKey:@"calories"] intValue];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"TOTAL: %d calories", calories];
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.textColor = [UIColor blackColor];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"current_meal"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"current_meal"];
            }
            NSDictionary *itemDict = [self.currentMealItems objectAtIndex:indexPath.row - 1];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d g/ml)", [itemDict valueForKey:@"item"], [[itemDict valueForKey:@"quantity"] intValue]];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d calories", [[itemDict valueForKey:@"calories"] intValue]];
            cell.indentationWidth = 30;
            cell.indentationLevel = 1;
        }
    } else  {
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        BOOL manyCells  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
        if (manyCells) {
            NSArray *content = [self.sectionContentDict valueForKey:[self.sectionTitleArray objectAtIndex:indexPath.section]];
            cell.textLabel.text = [[[content objectAtIndex:indexPath.row] allKeys] lastObject];
            cell.indentationWidth = 20;
            cell.indentationLevel = 1;
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section != self.arrayForBool.count) {
        self.selectedIndexPath = indexPath;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text
                                                            message:@"Add quantity (g / ml):"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Continue", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
    }
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        int quantity = [[alertView textFieldAtIndex:0].text intValue];
        
        NSDictionary *itemDict = [[self.sectionContentDict objectForKey:self.sectionTitleArray[self.selectedIndexPath.section]] objectAtIndex:self.selectedIndexPath.row];
        NSString *name = [[itemDict allKeys] lastObject];
        NSNumber *value = [itemDict objectForKey:name];
        
        double calories = (double)quantity / 100 * [value doubleValue];
        
        [self.currentMealItems addObject:@{@"quantity": [NSNumber numberWithInt:quantity], @"item": name, @"value": value, @"calories": [NSNumber numberWithDouble:calories] }];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.arrayForBool.count] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDecimalPad;
}

@end
