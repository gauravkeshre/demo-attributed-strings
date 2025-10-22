//
//  TextWithLinksViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithLinksViewController.h"

@implementation TextWithLinksViewController

- (void)setupAttributedText {
    NSString *fullText = @"This demonstrates clickable links in attributed text. "
                        @"Visit https://apple.com for more information about iOS development. "
                        @"You can also check out the Swift documentation at https://swift.org "
                        @"or explore open source projects on https://github.com for learning resources.";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    // Add link to apple.com
    NSRange appleRange = [fullText rangeOfString:@"https://apple.com"];
    if (appleRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:[NSURL URLWithString:@"https://apple.com"]
                               range:appleRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemBlueColor]
                               range:appleRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:appleRange];
    }
    
    // Add link to swift.org
    NSRange swiftRange = [fullText rangeOfString:@"https://swift.org"];
    if (swiftRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:[NSURL URLWithString:@"https://swift.org"]
                               range:swiftRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemBlueColor]
                               range:swiftRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:swiftRange];
    }
    
    // Add link to github.com
    NSRange githubRange = [fullText rangeOfString:@"https://github.com"];
    if (githubRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:[NSURL URLWithString:@"https://github.com"]
                               range:githubRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemBlueColor]
                               range:githubRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:githubRange];
    }
    
    self.attributedText = attributedText;
}

@end