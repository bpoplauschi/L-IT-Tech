//
//  LITMedicalDictionaryViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/1/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITMedicalDictionaryViewController.h"

@interface LITMedicalDictionaryViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *words;
@property (nonatomic, strong) NSArray *wordsArray;
@property (nonatomic, strong) NSArray *filteredWordsArray;

@end


@implementation LITMedicalDictionaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Med Dex", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"dict.png"];
        
        _words = @{@"abces" : @"Colectie purulenta constituita, plecand de la un focar local de infectie, pe seama tesuturilor normale. Prin extensie se mai numeste abces sau empiem, colectia purulenta constituita intr-o cavitate seroasa (peritoneu, pleura, meninge). Abcesele se pot dezvolta in oricare punct al organismului. abcesul superficial, accesibil vederii si palparii este amplasat cel mai des la degete (panaritiu) sau pe marginea anusului dar si in gat, pe sezut, subsuoara sau pe partea ventrala. abcesul profund poate fi localizat la nivelul ficatului, rinichiului, creierului, plamanului. Gravitatea sa depinde de localizare: abcesul creierului, fiind asemanator cu tumora, poate provoca hipertensiune intracraniana. Dupa modul lor de constituire si dupa viteza de evolutie, se pot distinge abcesele calde de abcesele reci.",
                   @"balonare" : @"Simptom caracterizat prin marirea volumului abdomenului provocata de acumularea de gaze in stomac sau in intestin.",
                   @"calcemie" : @"Nivelul calciului continut in sange. Calcemia este foarte stabila, in jur de 2,5 milimoli pe litru. Aceasta rezulta dintr-un echilibru permanent intre absorbtia intestinala a calciului, fixarea sa in oase sau, din contra, eliberarea sa si eliminarea sa prin urina - hipercalcemie.",
                   @"dalac" : @"Boala infectioasa contagioasa determinata de infectia cu un bacil gram negativ, Bacillus Anthracis. boala poate fi transmisa omului de catre animale, in principal ovine, cabaline si caprine, vii sau moarte. Contaminarea se face cel mai des in timpul manipularii produselor de ecarisaj, pe cale cutanata sau mucoasa, si uneori prin inhalarea sau ingerarea de spori ai bacteriei. incubatia dureaza doua sau trei zile. Aspectul cel mai caracteristic al bolii carbunelui este o pustula localizata adesea pe fata si care devine repede o tumefactie negricioasa. tratamentul cu antibiotice (penicilina in doza mare), instaurat de urgenta, a trecut aceasta boala in randul celor rare, cu exceptia tarilor in curs de dezvoltare.",
                   @"ectima" : @"Infectie cutanata caracterizata printr-o ulceratie care survine cel mai des pe membre. Ectima, provocata de o bacterie, streptococul, afecteaza in general subiectii debilitati. Ea se traduce printr-o ulceratie cu coji a pielii. antibioticele (peniciline), luate in urgenta si in doze mari, permit oprirea infectiei. Ingrijirile locale sunt cele ale unei ulceratii (curatire locala, pansamente antiseptice). ",
                   @"fanera" : @"Organ de protectie caracterizat printr-o keratinizare intensa. parul, dintii, unghiile si perii sunt fanere. keratina, proteina fibrosa si principalul constituent al paturii superficiale a epidermului, este o substanta dura, rezistenta si protectoare.",
                   @"gastrina" : @"Hormon peptidic secretat de catre celulele endocrine ale antrului gastric (partea inferioara a stomacului) si de catre peretii duodenului si ai jejunului care participa la digestia alimentelor.",
                   @"halou" : @"Hormon peptidic secretat de catre celulele endocrine ale antrului gastric (partea inferioara a stomacului) si de catre peretii duodenului si ai jejunului care participa la digestia alimentelor.",
                   @"ictus" : @"Denumire data starilor morbide instalate brusc apopletic, debut brusc al accidentelor vasculare cerebrale insotite de pierderea starii de cunostiinta.",
                   @"jacket" : @"Proteza de ceramica destinata acoperirii unui dinte deteriorat sau inestetic. Constitutia jachetei asigura unui dinte o mare soliditate si o perfecta asemanare cu dintii invecinati."};
        
        _wordsArray = [_words allKeys];
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

@end
