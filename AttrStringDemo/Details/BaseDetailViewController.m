//
//  BaseDetailViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "BaseDetailViewController.h"
#import "HomeViewModel.h"
#import "TableHeaderView.h"

typedef NS_ENUM(NSInteger, DetailSection) {
    DetailSectionUILabel = 0,
    DetailSectionUITextView,
    DetailSectionCount
};

@interface BaseDetailViewController ()

@property (nonatomic, strong, readwrite) UILabel *demoLabel;
@property (nonatomic, strong, readwrite) UITextView *demoTextView;

@end

@implementation BaseDetailViewController

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _viewModel = viewModel;
        self.title = viewModel.title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure table view
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
    // Set up navigation bar
    [self setupNavigationBar];
    
    // Setup attributed text (to be overridden by subclasses)
    [self setupAttributedText];
    
    // Create demo views
    [self setupDemoViews];
    
    // Setup table header view
    [self setupTableHeaderView];
}

- (void)setupNavigationBar {
    // Add edit button
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(editButtonTapped:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)setupAttributedText {
    // Default attributed text - to be overridden by subclasses
    NSString *defaultText = @"This is the base detail view controller. Subclasses should override setupAttributedText method.";
    self.attributedText = [[NSAttributedString alloc] initWithString:defaultText];
}

- (void)setupDemoViews {
    // Create UILabel
    self.demoLabel = [[UILabel alloc] init];
    self.demoLabel.numberOfLines = 0;
    self.demoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.demoLabel.attributedText = self.attributedText;
    
    // Create UITextView
    self.demoTextView = [[UITextView alloc] init];
    self.demoTextView.editable = NO;
    self.demoTextView.scrollEnabled = NO;
    self.demoTextView.attributedText = self.attributedText;
    self.demoTextView.backgroundColor = [UIColor clearColor];
    self.demoTextView.textContainerInset = UIEdgeInsetsZero;
    self.demoTextView.textContainer.lineFragmentPadding = 0;
}

- (void)editButtonTapped:(UIBarButtonItem *)sender {
    // To be implemented later
    NSLog(@"Edit button tapped - functionality to be added later");
}

- (void)setupTableHeaderView {
    // Create header view with class name as title and description from view model
    NSString *className = NSStringFromClass([self class]);
    NSString *description = self.viewModel.descriptionText ?: @"No description available";
    
    TableHeaderView *headerView = [[TableHeaderView alloc] initWithTitle:className description:description];
    
    // Create a container view to ensure proper height
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 120)];
    containerView.backgroundColor = [UIColor systemBackgroundColor];
    
    // Add header view to container
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:headerView];
    
    // Set up constraints to fill the container
    [NSLayoutConstraint activateConstraints:@[
        [headerView.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [headerView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [headerView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [headerView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]
    ]];
    
    // Set as table header view
    self.tableView.tableHeaderView = containerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return DetailSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; // Each section has one cell
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case DetailSectionUILabel:
            return @"UILabel";
        case DetailSectionUITextView:
            return @"UITextView";
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Remove any existing subviews
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIView *demoView = nil;
    
    switch (indexPath.section) {
        case DetailSectionUILabel:
            demoView = self.demoLabel;
            break;
        case DetailSectionUITextView:
            demoView = self.demoTextView;
            break;
    }
    
    if (demoView) {
        demoView.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:demoView];
        
        // Set up constraints
        [NSLayoutConstraint activateConstraints:@[
            [demoView.topAnchor constraintEqualToAnchor:cell.contentView.topAnchor constant:16],
            [demoView.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:16],
            [demoView.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-16],
            [demoView.bottomAnchor constraintEqualToAnchor:cell.contentView.bottomAnchor constant:-16]
        ]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

#pragma mark - Public methods

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    
    // Update demo views if they exist
    if (self.demoLabel) {
        self.demoLabel.attributedText = attributedText;
    }
    if (self.demoTextView) {
        self.demoTextView.attributedText = attributedText;
    }
    
    // Reload table view if it's loaded
    if (self.isViewLoaded) {
        [self.tableView reloadData];
    }
}

@end