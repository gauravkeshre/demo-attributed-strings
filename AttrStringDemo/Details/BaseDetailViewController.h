//
//  BaseDetailViewController.h
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import <UIKit/UIKit.h>

@class HomeViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface BaseDetailViewController : UITableViewController

@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, strong) HomeViewModel *viewModel;
@property (nonatomic, strong, readonly) UILabel *demoLabel;
@property (nonatomic, strong, readonly) UITextView *demoTextView;

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel;
- (void)setupAttributedText;
- (void)setupDemoViews;
- (void)editButtonTapped:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END