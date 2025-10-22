//
//  TextWithAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithAttachmentsViewController.h"

@implementation TextWithAttachmentsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Add initial text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This demonstrates NSTextAttachment for embedding images and icons in text. "]];
    
    // Create and add SF Symbol attachment
    NSTextAttachment *starAttachment = [[NSTextAttachment alloc] init];
    if (@available(iOS 13.0, *)) {
        UIImage *starImage = [UIImage systemImageNamed:@"star.fill"];
        starAttachment.image = [starImage imageWithTintColor:[UIColor systemYellowColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        // Fallback for earlier versions
        starAttachment.image = nil;
    }
    starAttachment.bounds = CGRectMake(0, -2, 16, 16);
    NSAttributedString *starString = [NSAttributedString attributedStringWithAttachment:starAttachment];
    [attributedText appendAttributedString:starString];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" Here's a star icon embedded in the text. "]];
    
    // Add heart icon
    NSTextAttachment *heartAttachment = [[NSTextAttachment alloc] init];
    if (@available(iOS 13.0, *)) {
        UIImage *heartImage = [UIImage systemImageNamed:@"heart.fill"];
        heartAttachment.image = [heartImage imageWithTintColor:[UIColor systemRedColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        heartAttachment.image = nil;
    }
    heartAttachment.bounds = CGRectMake(0, -2, 16, 16);
    NSAttributedString *heartString = [NSAttributedString attributedStringWithAttachment:heartAttachment];
    [attributedText appendAttributedString:heartString];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" And a heart icon. "]];
    
    // Add gear icon
    NSTextAttachment *gearAttachment = [[NSTextAttachment alloc] init];
    if (@available(iOS 13.0, *)) {
        UIImage *gearImage = [UIImage systemImageNamed:@"gear"];
        gearAttachment.image = [gearImage imageWithTintColor:[UIColor systemGrayColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        gearAttachment.image = nil;
    }
    gearAttachment.bounds = CGRectMake(0, -2, 16, 16);
    NSAttributedString *gearString = [NSAttributedString attributedStringWithAttachment:gearAttachment];
    [attributedText appendAttributedString:gearString];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" Settings gear icon can be inline with text as well."]];
    
    self.attributedText = attributedText;
}

@end