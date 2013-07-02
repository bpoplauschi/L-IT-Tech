//
//  LITInputTableViewCell.m
//  LITTech
//
//  Created by Bogdan Poplauschi on 7/2/13.
//  Copyright (c) 2013 Bogdan Poplauschi. All rights reserved.
//

#import "LITInputTableViewCell.h"

@implementation LITInputTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.hidden = YES;
		self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self.textField setAutocorrectionType:UITextAutocorrectionTypeNo];
		[self.textField setReturnKeyType:UIReturnKeyDone];
        [self.textField setTextColor:self.detailTextLabel.textColor];
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
		self.textField.textAlignment = NSTextAlignmentRight;
		self.textField.adjustsFontSizeToFitWidth = YES;
		
		[self.contentView addSubview:self.textField];
		
		[self.detailTextLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc {
	[self.detailTextLabel removeObserver:self forKeyPath:@"text" context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([(NSObject *)object isKindOfClass:[UILabel class]] && [@"text" isEqualToString:keyPath]) {
		self.textField.text = self.detailTextLabel.text;
        self.textField.font = [UIFont systemFontOfSize:18];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
    CGRect frame = self.textLabel.frame;
	frame.size.width = self.contentView.frame.size.width - self.textLabel.frame.size.width - 2 * frame.origin.x - 10;
    frame.origin.x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width + 10;
	self.textField.frame = frame;
}

@end
