//
//  PlainTextViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "PlainTextViewController.h"

@implementation PlainTextViewController

- (void)setupAttributedText {
    NSString *plainText = @"This is a simple plain text demonstration using NSAttributedString. "
                         @"Even though we're using NSAttributedString, no special formatting attributes are applied here. "
                         @"This shows how NSAttributedString can be used as a drop-in replacement for NSString "
                         @"while maintaining the ability to add formatting later.";
    
    self.attributedText = [[NSAttributedString alloc] initWithString:plainText];
}

@end