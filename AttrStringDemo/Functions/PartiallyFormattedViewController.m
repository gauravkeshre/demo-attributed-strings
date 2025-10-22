//
//  PartiallyFormattedViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "PartiallyFormattedViewController.h"

@implementation PartiallyFormattedViewController

- (void)setupAttributedText {
    NSString *fullText = @"This text demonstrates various formatting options. "
                        @"Some words are bold, others are italic, and some have different colors. "
                        @"You can also combine multiple attributes for enhanced styling.";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    // Apply bold formatting to "bold"
    NSRange boldRange = [fullText rangeOfString:@"bold"];
    if (boldRange.location != NSNotFound) {
        [attributedText addAttribute:NSFontAttributeName
                               value:[UIFont boldSystemFontOfSize:17]
                               range:boldRange];
    }
    
    // Apply italic formatting to "italic"
    NSRange italicRange = [fullText rangeOfString:@"italic"];
    if (italicRange.location != NSNotFound) {
        UIFontDescriptor *descriptor = [[UIFont systemFontOfSize:17] fontDescriptor];
        UIFontDescriptor *italicDescriptor = [descriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
        UIFont *italicFont = [UIFont fontWithDescriptor:italicDescriptor size:17];
        [attributedText addAttribute:NSFontAttributeName
                               value:italicFont ?: [UIFont italicSystemFontOfSize:17]
                               range:italicRange];
    }
    
    // Apply red color to "different colors"
    NSRange colorRange = [fullText rangeOfString:@"different colors"];
    if (colorRange.location != NSNotFound) {
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemRedColor]
                               range:colorRange];
    }
    
    // Apply blue color and bold to "multiple attributes"
    NSRange multipleRange = [fullText rangeOfString:@"multiple attributes"];
    if (multipleRange.location != NSNotFound) {
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemBlueColor]
                               range:multipleRange];
        [attributedText addAttribute:NSFontAttributeName
                               value:[UIFont boldSystemFontOfSize:17]
                               range:multipleRange];
    }
    
    // Apply green color to "enhanced styling"
    NSRange enhancedRange = [fullText rangeOfString:@"enhanced styling"];
    if (enhancedRange.location != NSNotFound) {
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemGreenColor]
                               range:enhancedRange];
    }
    
    self.attributedText = attributedText;
}

@end