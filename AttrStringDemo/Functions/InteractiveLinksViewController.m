//
//  InteractiveLinksViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "InteractiveLinksViewController.h"

@interface InteractiveLinksViewController () <UITextViewDelegate>

@end

@implementation InteractiveLinksViewController

- (void)setupAttributedText {
    NSString *fullText = @"This demonstrates interactive links handled within the app. "
                        @"Tap on profile to view user details, settings to open app preferences, "
                        @"help for assistance, or contact to reach support. "
                        @"Each link shows a custom alert instead of opening external URLs.";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    // Add custom link for "profile"
    NSRange profileRange = [fullText rangeOfString:@"profile"];
    if (profileRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:@"app://profile"
                               range:profileRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemBlueColor]
                               range:profileRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:profileRange];
    }
    
    // Add custom link for "settings"
    NSRange settingsRange = [fullText rangeOfString:@"settings"];
    if (settingsRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:@"app://settings"
                               range:settingsRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemGreenColor]
                               range:settingsRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:settingsRange];
    }
    
    // Add custom link for "help"
    NSRange helpRange = [fullText rangeOfString:@"help"];
    if (helpRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:@"app://help"
                               range:helpRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemOrangeColor]
                               range:helpRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:helpRange];
    }
    
    // Add custom link for "contact"
    NSRange contactRange = [fullText rangeOfString:@"contact"];
    if (contactRange.location != NSNotFound) {
        [attributedText addAttribute:NSLinkAttributeName
                               value:@"app://contact"
                               range:contactRange];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor systemPurpleColor]
                               range:contactRange];
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:contactRange];
    }
    
    self.attributedText = attributedText;
}

- (void)setupDemoViews {
    [super setupDemoViews];
    
    // Set delegate for the UITextView to handle link taps
    if (self.demoTextView) {
        self.demoTextView.delegate = self;
        self.demoTextView.editable = NO;
        self.demoTextView.scrollEnabled = NO;
        self.demoTextView.selectable = YES; // Enable selection to make links tappable
        self.demoTextView.dataDetectorTypes = UIDataDetectorTypeLink; // Disable automatic data detection
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if (interaction == UITextItemInteractionInvokeDefaultAction) {
        [self handleCustomURL:URL];
        return NO; // Prevent default URL handling
    }
    return YES;
}

- (void)handleCustomURL:(NSURL *)URL {
    NSString *urlString = URL.absoluteString;
    
    UIAlertController *alert;
    
    if ([urlString isEqualToString:@"app://profile"]) {
        alert = [UIAlertController alertControllerWithTitle:@"Profile"
                                                     message:@"This would navigate to the user's profile page in a real app."
                                              preferredStyle:UIAlertControllerStyleAlert];
    } else if ([urlString isEqualToString:@"app://settings"]) {
        alert = [UIAlertController alertControllerWithTitle:@"Settings"
                                                     message:@"This would open the app settings screen."
                                              preferredStyle:UIAlertControllerStyleAlert];
    } else if ([urlString isEqualToString:@"app://help"]) {
        alert = [UIAlertController alertControllerWithTitle:@"Help & Support"
                                                     message:@"This would display the help documentation or FAQ section."
                                              preferredStyle:UIAlertControllerStyleAlert];
    } else if ([urlString isEqualToString:@"app://contact"]) {
        alert = [UIAlertController alertControllerWithTitle:@"Contact Support"
                                                     message:@"This would open a contact form or support chat."
                                              preferredStyle:UIAlertControllerStyleAlert];
    } else {
        alert = [UIAlertController alertControllerWithTitle:@"Unknown Link"
                                                     message:[NSString stringWithFormat:@"Tapped link: %@", urlString]
                                              preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
