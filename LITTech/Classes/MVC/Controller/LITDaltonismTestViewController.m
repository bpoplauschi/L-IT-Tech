//
//  LITDaltonismTestViewController.m
//  LITTech
//
//  Created by John McLane on 7/12/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITDaltonismTestViewController.h"

@interface LITDaltonismTestViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageViews;

@end

@implementation LITDaltonismTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = NSLocalizedString(@"Daltonism Test", @"");
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *imageViewsArray = [NSMutableArray array];
    
    for (int index = 1; index < 7; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"daltonism_%d.png", index]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect frame = imageView.frame;
        frame.origin.x = self.view.frame.size.width * (index - 1);
        imageView.frame = frame;
        [self.scrollView addSubview:imageView];
        [imageViewsArray addObject:imageView];
    }
    self.imageViews = [imageViewsArray copy];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.scrollView.contentSize.width == 0.0) {
        self.scrollView.contentSize = CGSizeMake(6 * self.view.frame.size.width, self.scrollView.frame.size.height);
    }
    
    for (int index = 0; index < self.imageViews.count; index++) {
        UIImageView *imageView = [self.imageViews objectAtIndex:index];
        CGRect frame = imageView.frame;
        frame.origin.x = round((self.view.frame.size.width - frame.size.width) / 2) + self.view.frame.size.width * index;
        frame.origin.y = round((self.view.frame.size.height - frame.size.height) / 2);
        imageView.frame = frame;
    }
}

@end
