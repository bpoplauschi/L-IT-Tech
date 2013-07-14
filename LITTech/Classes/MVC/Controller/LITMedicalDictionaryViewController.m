//
//  LITMedicalDictionaryViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/1/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITMedicalDictionaryViewController.h"

@interface LITMedicalDictionaryViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *words;
@property (nonatomic, strong) NSArray *wordsArray;
@property (nonatomic, strong) NSArray *filteredWordsArray;

- (void)firstAidAction:(id)sender;

@end


@implementation LITMedicalDictionaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Med Dex", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"dict.png"];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"First Aid", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(firstAidAction:)];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MedDex" ofType:@"plist"];
        _words = [NSDictionary dictionaryWithContentsOfFile:path];
        _wordsArray = [[_words allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [(NSString *)obj1 compare:(NSString *)obj2];
        }];
        _filteredWordsArray = [NSArray arrayWithArray:_wordsArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredWordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.filteredWordsArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.words valueForKey:[self.filteredWordsArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text message:cell.detailTextLabel.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)inSearchBar {
    [inSearchBar resignFirstResponder];
    [self filter];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)inSearchBar {
    [inSearchBar resignFirstResponder];
    [self filter];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filter];
}

- (void)filter {
    NSString *filter = self.searchBar.text;
    
    if (filter.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", filter];
        self.filteredWordsArray = [self.wordsArray filteredArrayUsingPredicate:predicate];
    } else {
        self.filteredWordsArray = self.wordsArray;
    }
    
    [self.tableView reloadData];
}

- (void)firstAidAction:(id)sender {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"final" ofType:@"pdf"];
    
    
    UIDocumentInteractionController *docIC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
    docIC.delegate = self;
    [docIC presentPreviewAnimated:YES];
    
    return;
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

@end
