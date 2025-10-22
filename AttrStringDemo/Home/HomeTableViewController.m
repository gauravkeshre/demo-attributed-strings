//
//  HomeTableViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "HomeTableViewController.h"
#import "HomeViewModel.h"
#import "TableHeaderView.h"
#import "BaseDetailViewController.h"
#import "PlainTextViewController.h"
#import "PartiallyFormattedViewController.h"
#import "TextWithLinksViewController.h"
#import "InteractiveLinksViewController.h"
#import "TextWithAttachmentsViewController.h"
#import "TextWithImageAttachmentsViewController.h"
#import "TextWithViewAttachmentsViewController.h"
#import "TextWithButtonAttachmentsViewController.h"
#import "StyledParagraphsViewController.h"
#import "CustomFontsViewController.h"
#import "TextDecorationsViewController.h"
#import "ShadowEffectsViewController.h"
#import "BackgroundColorsViewController.h"
#import "AdvancedFormattingViewController.h"

@interface HomeTableViewController ()

@property (nonatomic, strong) NSArray<HomeViewModel *> *viewModels;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up the view models
    self.viewModels = [HomeViewModel defaultModels];
    
    // Set up the navigation bar
    self.title = @"Home";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    // Configure table view
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 68.0;
    
    // Set up table header view
    [self setupTableHeaderView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Get the view model for this row
    HomeViewModel *viewModel = self.viewModels[indexPath.row];
    
    // Configure the cell
    cell.textLabel.text = viewModel.title;
    cell.detailTextLabel.text = viewModel.descriptionText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Set the icon if available
    if (viewModel.iconName) {
        UIImageConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:20 weight:UIImageSymbolWeightMedium];
        UIImage *icon = [UIImage systemImageNamed:viewModel.iconName withConfiguration:config];
        cell.imageView.image = icon;
        cell.imageView.tintColor = [UIColor systemBlueColor];
    }
    
    // Configure subtitle appearance
    if (cell.detailTextLabel) {
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.textColor = [UIColor secondaryLabelColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68.0; // Estimated height for subtitle style cells
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HomeViewModel *viewModel = self.viewModels[indexPath.row];
    
    // Try to instantiate the view controller from the class name
    Class viewControllerClass = NSClassFromString(viewModel.className);
    
    if (viewControllerClass && [viewControllerClass isSubclassOfClass:[BaseDetailViewController class]]) {
        // Use the new initializer to pass the view model
        BaseDetailViewController *detailViewController = [[viewControllerClass alloc] initWithViewModel:viewModel];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else if (viewControllerClass && [viewControllerClass isSubclassOfClass:[UIViewController class]]) {
        // Fallback for non-BaseDetailViewController subclasses
        UIViewController *detailViewController = [[viewControllerClass alloc] init];
        detailViewController.title = viewModel.title;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else {
        // Show an alert if the view controller class doesn't exist yet
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Coming Soon"
                                                                       message:[NSString stringWithFormat:@"The %@ example will be implemented soon.", viewModel.title]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Utility

- (void)setupTableHeaderView {
    TableHeaderView *headerView = [[TableHeaderView alloc] init];
    
    // Create a container view to ensure proper height
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 104)];
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
    
    // Set the container as table header view
    self.tableView.tableHeaderView = containerView;
}
@end
