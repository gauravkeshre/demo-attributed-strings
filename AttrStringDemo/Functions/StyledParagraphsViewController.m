//
//  StyledParagraphsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "StyledParagraphsViewController.h"

@implementation StyledParagraphsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Left aligned paragraph
    NSString *leftText = @"This paragraph is left-aligned with standard spacing.\n\n";
    NSMutableParagraphStyle *leftStyle = [[NSMutableParagraphStyle alloc] init];
    leftStyle.alignment = NSTextAlignmentLeft;
    leftStyle.lineSpacing = 4;
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:leftText
                                                                          attributes:@{NSParagraphStyleAttributeName: leftStyle}]];
    
    // Center aligned paragraph
    NSString *centerText = @"This paragraph is center-aligned with increased line spacing for better readability.\n\n";
    NSMutableParagraphStyle *centerStyle = [[NSMutableParagraphStyle alloc] init];
    centerStyle.alignment = NSTextAlignmentCenter;
    centerStyle.lineSpacing = 8;
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:centerText
                                                                           attributes:@{NSParagraphStyleAttributeName: centerStyle,
                                                                                       NSForegroundColorAttributeName: [UIColor systemBlueColor]}]];
    
    // Right aligned paragraph
    NSString *rightText = @"This paragraph is right-aligned with custom indentation.\n\n";
    NSMutableParagraphStyle *rightStyle = [[NSMutableParagraphStyle alloc] init];
    rightStyle.alignment = NSTextAlignmentRight;
    rightStyle.firstLineHeadIndent = 20;
    rightStyle.lineSpacing = 6;
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:rightText
                                                                           attributes:@{NSParagraphStyleAttributeName: rightStyle,
                                                                                       NSForegroundColorAttributeName: [UIColor systemGreenColor]}]];
    
    // Justified paragraph with spacing
    NSString *justifiedText = @"This paragraph is justified with paragraph spacing before and after. It demonstrates how text can be aligned and spaced for professional document formatting.";
    NSMutableParagraphStyle *justifiedStyle = [[NSMutableParagraphStyle alloc] init];
    justifiedStyle.alignment = NSTextAlignmentJustified;
    justifiedStyle.paragraphSpacing = 12;
    justifiedStyle.paragraphSpacingBefore = 8;
    justifiedStyle.lineSpacing = 5;
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:justifiedText
                                                                           attributes:@{NSParagraphStyleAttributeName: justifiedStyle,
                                                                                       NSForegroundColorAttributeName: [UIColor systemPurpleColor]}]];
    
    self.attributedText = attributedText;
}

@end