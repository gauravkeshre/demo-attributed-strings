//
//  AdvancedFormattingViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "AdvancedFormattingViewController.h"

@implementation AdvancedFormattingViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Title with multiple effects
    NSShadow *titleShadow = [[NSShadow alloc] init];
    titleShadow.shadowOffset = CGSizeMake(2, 2);
    titleShadow.shadowBlurRadius = 4;
    titleShadow.shadowColor = [UIColor systemGrayColor];
    
    NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc] init];
    titleStyle.alignment = NSTextAlignmentCenter;
    titleStyle.paragraphSpacing = 16;
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Advanced Formatting Demo\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:22],
                                                                                       NSForegroundColorAttributeName: [UIColor systemBlueColor],
                                                                                       NSShadowAttributeName: titleShadow,
                                                                                       NSParagraphStyleAttributeName: titleStyle,
                                                                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemRedColor]}]];
    
    // Complex paragraph with mixed formatting
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This paragraph combines "]];
    
    // Bold red text with background
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"bold red text"
                                                                           attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                                                                       NSForegroundColorAttributeName: [UIColor systemRedColor],
                                                                                       NSBackgroundColorAttributeName: [UIColor systemYellowColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
    
    // Italic underlined text
    UIFontDescriptor *descriptor = [[UIFont systemFontOfSize:17] fontDescriptor];
    UIFontDescriptor *italicDescriptor = [descriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
    UIFont *italicFont = [UIFont fontWithDescriptor:italicDescriptor size:17];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"italic underlined"
                                                                           attributes:@{NSFontAttributeName: italicFont ?: [UIFont italicSystemFontOfSize:17],
                                                                                       NSForegroundColorAttributeName: [UIColor systemGreenColor],
                                                                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemBlueColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@", and "]];
    
    // Shadow effect with strikethrough
    NSShadow *textShadow = [[NSShadow alloc] init];
    textShadow.shadowOffset = CGSizeMake(1, 1);
    textShadow.shadowBlurRadius = 2;
    textShadow.shadowColor = [UIColor systemPurpleColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"shadowed strikethrough"
                                                                           attributes:@{NSForegroundColorAttributeName: [UIColor systemOrangeColor],
                                                                                       NSShadowAttributeName: textShadow,
                                                                                       NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSStrikethroughColorAttributeName: [UIColor systemTealColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" effects.\n\n"]];
    
    // Code block simulation
    NSMutableParagraphStyle *codeStyle = [[NSMutableParagraphStyle alloc] init];
    codeStyle.firstLineHeadIndent = 16;
    codeStyle.headIndent = 16;
    codeStyle.tailIndent = -16;
    codeStyle.paragraphSpacing = 12;
    
    UIFont *codeFont;
    if (@available(iOS 13.0, *)) {
        codeFont = [UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightRegular];
    } else {
        codeFont = [UIFont fontWithName:@"Courier" size:14] ?: [UIFont systemFontOfSize:14];
    }
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"// Code block with syntax highlighting\nlet message = \"Hello, World!\"\nprint(message)"
                                                                           attributes:@{NSFontAttributeName: codeFont,
                                                                                       NSForegroundColorAttributeName: [UIColor systemGreenColor],
                                                                                       NSBackgroundColorAttributeName: [UIColor systemGray6Color],
                                                                                       NSParagraphStyleAttributeName: codeStyle}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    
    // Link with custom formatting
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Custom formatted link: "]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"https://developer.apple.com"
                                                                           attributes:@{NSLinkAttributeName: [NSURL URLWithString:@"https://developer.apple.com"],
                                                                                       NSForegroundColorAttributeName: [UIColor systemBlueColor],
                                                                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemRedColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    
    self.attributedText = attributedText;
}

@end