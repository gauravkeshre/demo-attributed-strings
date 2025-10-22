//
//  TextWithImageAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithImageAttachmentsViewController.h"

@implementation TextWithImageAttachmentsViewController

- (void)setupAttributedText {
    NSString *firstPart = @"This demonstrates PNG images embedded within text. ";
    NSString *middlePart = @" Here's an iOS app icon image ";
    NSString *lastPart = @" and another system image ";
    NSString *finalPart = @" embedded seamlessly within the attributed text flow.";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:firstPart];
    
    // Create first image attachment (shutter image from assets)
    NSTextAttachment *heartAttachment = [[NSTextAttachment alloc] init];
    UIImage *heartImage = [UIImage imageNamed:@"shutter"];
    if (heartImage) {
        // Use the image as-is (no tinting needed for asset images)
        heartAttachment.image = heartImage;
        
        // Set bounds to match text size
        CGFloat fontSize = 17.0;
        heartAttachment.bounds = CGRectMake(0, -2, fontSize, fontSize);
    }
    
    // Append the heart image
    NSAttributedString *heartString = [NSAttributedString attributedStringWithAttachment:heartAttachment];
    [attributedText appendAttributedString:heartString];
    
    // Add middle text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:middlePart]];
    
    // Create second image attachment (iOS app icon style)
    NSTextAttachment *appIconAttachment = [[NSTextAttachment alloc] init];
    UIImage *appIcon = [UIImage imageNamed:@"helmet"];
    if (appIcon) {
        // Tint the image blue and resize
        UIImage *tintedAppIcon = [appIcon imageWithTintColor:[UIColor systemBlueColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
        appIconAttachment.image = tintedAppIcon;
        
        // Make it slightly larger for emphasis
        CGFloat iconSize = 20.0;
        appIconAttachment.bounds = CGRectMake(0, -3, iconSize, iconSize);
    }
    
    // Append the app icon image
    NSAttributedString *appIconString = [NSAttributedString attributedStringWithAttachment:appIconAttachment];
    [attributedText appendAttributedString:appIconString];
    
    // Add more text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:lastPart]];
    
    // Create third image attachment (star)
    NSTextAttachment *starAttachment = [[NSTextAttachment alloc] init];
    UIImage *starImage = [UIImage imageNamed:@"ice-skating"];
    if (starImage) {
        starAttachment.image = starImage;
        CGFloat starSize = 36.0;
        starAttachment.bounds = CGRectMake(0, -2, starSize, starSize);
    }
    
    // Append the star image
    NSAttributedString *starString = [NSAttributedString attributedStringWithAttachment:starAttachment];
    [attributedText appendAttributedString:starString];
    
    // Add final text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:finalPart]];
    
    self.attributedText = attributedText;
}

@end
