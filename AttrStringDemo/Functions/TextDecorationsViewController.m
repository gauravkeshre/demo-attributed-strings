//
//  TextDecorationsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextDecorationsViewController.h"

@implementation TextDecorationsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Single underline
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has a single underline.\n"
                                                                           attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemBlueColor]}]];
    
    // Double underline
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has a double underline.\n"
                                                                           attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleDouble),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemRedColor]}]];
    
    // Thick underline
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has a thick underline.\n"
                                                                           attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleThick),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemGreenColor]}]];
    
    // Strikethrough
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has strikethrough effect.\n"
                                                                           attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSStrikethroughColorAttributeName: [UIColor systemOrangeColor]}]];
    
    // Double strikethrough
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has double strikethrough.\n"
                                                                           attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleDouble),
                                                                                       NSStrikethroughColorAttributeName: [UIColor systemPurpleColor]}]];
    
    // Combined effects
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has both underline and strikethrough.\n"
                                                                           attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemBlueColor],
                                                                                       NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSStrikethroughColorAttributeName: [UIColor systemRedColor]}]];
    
    // Patterned underline
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This text has a patterned underline.\n"
                                                                           attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemTealColor]}]];
    
    // Different color text with decorations
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Colored text with decorations."
                                                                           attributes:@{NSForegroundColorAttributeName: [UIColor systemIndigoColor],
                                                                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemYellowColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    
    self.attributedText = attributedText;
}

@end