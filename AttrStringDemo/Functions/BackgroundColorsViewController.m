//
//  BackgroundColorsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "BackgroundColorsViewController.h"

@implementation BackgroundColorsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text demonstrates various background colors. "]];
    
    // Yellow highlight
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Yellow highlighted text"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemYellowColor],
                                                                                       NSForegroundColorAttributeName: [UIColor blackColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
    
    // Blue background with white text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"blue background"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemBlueColor],
                                                                                       NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" for contrast.\n\n"]];
    
    // Green highlight with dark text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Green highlighting"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemGreenColor],
                                                                                       NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" with bold text.\n\n"]];
    
    // Red background for errors or warnings
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Error or warning text"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemRedColor],
                                                                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:15]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" stands out with red background.\n\n"]];
    
    // Multiple highlighted words in a sentence
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"You can highlight "]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"multiple"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemOrangeColor],
                                                                                       NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" different "]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"words"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemPurpleColor],
                                                                                       NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" in the same "]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"sentence"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemTealColor],
                                                                                       NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@".\n\n"]];
    
    // Subtle background colors
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Subtle background colors"
                                                                           attributes:@{NSBackgroundColorAttributeName: [UIColor systemGray6Color],
                                                                                       NSForegroundColorAttributeName: [UIColor labelColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" work well for code snippets or references."]];
    
    self.attributedText = attributedText;
}

@end