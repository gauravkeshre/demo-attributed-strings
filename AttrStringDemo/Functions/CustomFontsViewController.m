//
//  CustomFontsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "CustomFontsViewController.h"

@implementation CustomFontsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // System font variations
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"System Font Regular (17pt)\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"System Font Bold (18pt)\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                                                                       NSForegroundColorAttributeName: [UIColor systemRedColor]}]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"System Font Light (16pt)\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                                                                       NSForegroundColorAttributeName: [UIColor systemBlueColor]}]];
    
    // Monospace font
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Monospace Font for Code (15pt)\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont monospacedSystemFontOfSize:15 weight:UIFontWeightRegular],
                                                                                       NSForegroundColorAttributeName: [UIColor systemGreenColor],
                                                                                       NSBackgroundColorAttributeName: [UIColor systemGray6Color]}]];
    
    // Different font families
    UIFont *georgiaFont = [UIFont fontWithName:@"Georgia" size:16];
    if (georgiaFont) {
        [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Georgia Serif Font (16pt)\n"
                                                                               attributes:@{NSFontAttributeName: georgiaFont,
                                                                                           NSForegroundColorAttributeName: [UIColor systemPurpleColor]}]];
    }
    
    UIFont *helveticaFont = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
    if (helveticaFont) {
        [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Helvetica Oblique (15pt)\n"
                                                                               attributes:@{NSFontAttributeName: helveticaFont,
                                                                                           NSForegroundColorAttributeName: [UIColor systemOrangeColor]}]];
    }
    
    // Large title style
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Large Title Style (24pt)\n"
                                                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy],
                                                                                       NSForegroundColorAttributeName: [UIColor labelColor]}]];
    
    // Small caption
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Small Caption Text (12pt)"
                                                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12 weight:UIFontWeightRegular],
                                                                                       NSForegroundColorAttributeName: [UIColor secondaryLabelColor]}]];
    
    self.attributedText = attributedText;
}

@end