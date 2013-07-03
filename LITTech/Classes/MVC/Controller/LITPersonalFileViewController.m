//
//  LITPersonalFileViewController.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 6/25/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITPersonalFileViewController.h"
#import "LITPerson.h"
#import "LITConstants.h"
#import "LITDataManager.h"


@interface LITPersonalFileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (void)personUpdated:(NSNotification *)inNotification;

@end


@implementation LITPersonalFileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Personal File", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"personal_file.png"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personUpdated:) name:kLITPersonUpdatedNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
}

- (void)personUpdated:(NSNotification *)inNotification {
    NSArray *persons = [[LITDataManager sharedInstance] loadPersons];
    if (persons.count) {
        self.person = [persons objectAtIndex:0];
    }
    
    [self.tableView reloadData];
}

- (void)setPerson:(LITPerson *)person {
    if (person != _person) {
        _person = person;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return NSLocalizedString(@"Personal info", @"");
            break;
        case 2:
            return NSLocalizedString(@"Computed values", @"");
            break;
        case 3:
            return NSLocalizedString(@"History", @"");
            break;
        default:
            break;
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 8;
            break;
        case 3:
            return 30;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nameCell"];
        }
        
        cell.textLabel.text = NSLocalizedString(@"Name", @"");
        cell.detailTextLabel.text = self.person.name;
    } else if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"personalInfoCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personalInfoCell"];
        }
        
        if (0 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Sex", @"");
            cell.detailTextLabel.text = self.person.isMale ? NSLocalizedString(@"Male", @"") : NSLocalizedString(@"Female", @"");
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Height", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d cm", self.person.height];
        } else if (2 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Weight", @"");
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kg", self.person.weight];
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Age", @"");
            if (self.person.birthDate) {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.person.birthDate toDate:[NSDate date] options:0];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d years", components.year];
            }
        }
    } else if (2 == indexPath.section) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"IMCCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IMCCell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"computedInfoCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"computedInfoCell"];
            }
        }
        
        if (0 == indexPath.row) {
            double imc = 0.0;
            if (self.person) {
                if (self.person.height) {
                    imc = self.person.weight * 100 * 100 / (self.person.height * self.person.height);
                }
            }
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Body mass index: %.2f kg / m^2", @""), imc];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            
            NSString *detail = @"";
            if (imc > 40) {
                detail = @"Esti diagnosticat cu super obezitate. La acest IMC organismul tau este supus riscului aparitiei multor boli, printre care diabet, hipertensiune sau boli de inima. Se recomanda urmarea sfaturilor unui medic pentru a ajunge la o greutate optima si schimbarea obiceiurilor alimentare si sportive.";
            } else if (imc > 35) {
                detail = @"Esti diagnosticat cu obezitate morbida. Obezitatea este o afecțiune medicală în care grăsimea corporală s-a acumulat în exces, astfel încât poate avea un efect advers asupra sănătății, ducând la o speranță de viață redusă și/sau probleme de sănătate.";
            } else if (imc > 30) {
                detail = @"Esti diagnosticat cu obezitate severa.  Obezitatea este o afecțiune medicală în care grăsimea corporală s-a acumulat în exces, astfel încât poate avea un efect advers asupra sănătății, ducând la o speranță de viață redusă și/sau probleme de sănătate.";
            } else if (imc > 25) {
                detail = @"Esti considerat supraponderal. Doctorii de obicei definesc supraponderalitatea ca o conditie in care greutatea unei persoane este cu 10%-20% mai mare decat normal.";
            } else if (imc > 18.5) {
                detail = @"Ai IMC-ul ideal, cu cantitatea de grasime corporala suficienta pentru asigurarea unei sanatati optime.";
            } else if (imc > 0) {
                detail = @"Cantitatea de grasime corporala este foarte scazuta. Daca esti un atlet de performanta, atingerea unui IMC mic poate constitui un obiectiv pe termen scurt. Daca nu esti atlet, un IMC scazut poate indica faptul ca esti subponderal, ceea ce poate duce la o imunitate scazuta a organismului. Daca atat greutatea cat si IMC-ul au valori mici, e recomandat sa iei in greutate folosind o dieta sanatoasa si exercitii fizice menite sa-ti creasca masa musculara.";
            }
            cell.detailTextLabel.text = detail;
        } else if (1 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Ruffier index", @"");
        } else if (2 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Basal metabolism", @"");
        } else if (3 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Daltonism test", @"");
        } else if (4 == indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Heart rate", @"");
        } else if (5 == indexPath.row) {
            NSInteger years = 0;
            if (self.person.birthDate) {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.person.birthDate toDate:[NSDate date] options:0];
                years = components.year;
            }
            double idealWeight = (self.person.height - 100 + (years / 10)) * 0.9;
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Ideal weight for a normal constitution: %.2f kg", @""), idealWeight];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        } else if (6 == indexPath.row) {
            NSInteger years = 0;
            if (self.person.birthDate) {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.person.birthDate toDate:[NSDate date] options:0];
                years = components.year;
            }
            double idealWeight = (self.person.height - 100 + (years / 10)) * 0.9 * 0.9;
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Ideal weight for a slender constitution: %.2f kg", @""), idealWeight];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        } else if (7 == indexPath.row) {
            NSInteger years = 0;
            if (self.person.birthDate) {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.person.birthDate toDate:[NSDate date] options:0];
                years = components.year;
            }
            double idealWeight = (self.person.height - 100 + (years / 10)) * 0.9 * 1.1;
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Ideal weight for a robust constitution: %.2f kg", @""), idealWeight];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        }
    } else if (3 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historyCell"];
            cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        }
        
        UIImage *alcoholImage = [UIImage imageNamed:@"alcohol.png"];
        UIImage *mealImage = [UIImage imageNamed:@"meal.png"];
        UIImage *workoutImage = [UIImage imageNamed:@"workout.png"];
        
        if (0 == indexPath.row % 3) {
            cell.textLabel.text = [NSString stringWithFormat:@"Meal - 6/%d/2013", indexPath.row];
            cell.detailTextLabel.text = @"Total of 948 calories";
            cell.imageView.image = mealImage;
        } else if (1 == indexPath.row % 3) {
            cell.textLabel.text = [NSString stringWithFormat:@"Alcohol entry - 6/%d/2013", indexPath.row];
            cell.detailTextLabel.text = @"You had 0.4 mg of alcohol in your blood.";
            cell.imageView.image = alcoholImage;
        } else if (2 == indexPath.row % 3) {
            cell.textLabel.text = [NSString stringWithFormat:@"Workout - 6/%d/2013", indexPath.row];
            cell.detailTextLabel.text = @"600 calories burnt.";
            cell.imageView.image = workoutImage;
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (2 == indexPath.section) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ( (2 == indexPath.section) && (0 == indexPath.row) ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text message:cell.detailTextLabel.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
