//
//  ShadowEffectsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "ShadowEffectsViewController.h"

@implementation ShadowEffectsViewController

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Simple drop shadow
    NSShadow *dropShadow = [[NSShadow alloc] init];
    dropShadow.shadowOffset = CGSizeMake(2, 2);
    dropShadow.shadowBlurRadius = 3;
    dropShadow.shadowColor = [UIColor systemGrayColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Text with simple drop shadow\n"
                                                                           attributes:@{NSShadowAttributeName: dropShadow,
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}]];
    
    // Blue shadow
    NSShadow *blueShadow = [[NSShadow alloc] init];
    blueShadow.shadowOffset = CGSizeMake(-1, 1);
    blueShadow.shadowBlurRadius = 2;
    blueShadow.shadowColor = [UIColor systemBlueColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Blue shadow with negative offset\n"
                                                                           attributes:@{NSShadowAttributeName: blueShadow,
                                                                                       NSForegroundColorAttributeName: [UIColor labelColor],
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:17]}]];
    
    // Large blur shadow
    NSShadow *blurShadow = [[NSShadow alloc] init];
    blurShadow.shadowOffset = CGSizeMake(0, 3);
    blurShadow.shadowBlurRadius = 8;
    blurShadow.shadowColor = [UIColor systemRedColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Large blur radius shadow effect\n"
                                                                           attributes:@{NSShadowAttributeName: blurShadow,
                                                                                       NSForegroundColorAttributeName: [UIColor systemYellowColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:19]}]];
    
    // No offset shadow (glow effect)
    NSShadow *glowShadow = [[NSShadow alloc] init];
    glowShadow.shadowOffset = CGSizeMake(0, 0);
    glowShadow.shadowBlurRadius = 5;
    glowShadow.shadowColor = [UIColor systemGreenColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Glow effect with zero offset\n"
                                                                           attributes:@{NSShadowAttributeName: glowShadow,
                                                                                       NSForegroundColorAttributeName: [UIColor labelColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    
    // Dark shadow for light text
    NSShadow *darkShadow = [[NSShadow alloc] init];
    darkShadow.shadowOffset = CGSizeMake(1, -1);
    darkShadow.shadowBlurRadius = 4;
    darkShadow.shadowColor = [UIColor blackColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Dark shadow behind light text\n"
                                                                           attributes:@{NSShadowAttributeName: darkShadow,
                                                                                       NSForegroundColorAttributeName: [UIColor systemOrangeColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:17]}]];
    
    // Multiple effects combined
    NSShadow *combinedShadow = [[NSShadow alloc] init];
    combinedShadow.shadowOffset = CGSizeMake(3, 3);
    combinedShadow.shadowBlurRadius = 6;
    combinedShadow.shadowColor = [UIColor systemPurpleColor];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Combined shadow with underline"
                                                                           attributes:@{NSShadowAttributeName: combinedShadow,
                                                                                       NSForegroundColorAttributeName: [UIColor systemIndigoColor],
                                                                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                                                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                       NSUnderlineColorAttributeName: [UIColor systemTealColor]}]];
    
    self.attributedText = attributedText;
}

@end