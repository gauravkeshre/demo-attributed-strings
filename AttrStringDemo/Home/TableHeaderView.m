//
//  TableHeaderView.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "TableHeaderView.h"

@interface TableHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self setupConstraints];
        [self setDefaultContent];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
        [self setupConstraints];
        [self updateTitle:title description:description];
    }
    return self;
}

- (void)setupViews {
    // Title label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.titleLabel.textColor = [UIColor labelColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
    
    // Description label
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:16];
    self.descriptionLabel.textColor = [UIColor secondaryLabelColor];
    self.descriptionLabel.numberOfLines = 0; // Allow unlimited lines
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.descriptionLabel];
}

- (void)setDefaultContent {
    [self updateTitle:@"Pick your function" 
          description:@"Explore various NSAttributedString formatting options\nand text styling techniques in iOS development"];
}

- (void)updateTitle:(NSString *)title description:(NSString *)description {
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // Title label constraints
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:12],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
        
        // Description label constraints
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8],
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
        [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12]
    ]];
}

@end
