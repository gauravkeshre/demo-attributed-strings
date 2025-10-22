//
//  TextWithViewAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithViewAttachmentsViewController.h"

@implementation TextWithViewAttachmentsViewController

- (UIView *)createColoredView:(UIColor *)color size:(CGSize)size {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    view.layer.cornerRadius = 4.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor systemGrayColor].CGColor;
    return view;
}

- (UIView *)createProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, 0, 80, 4);
    progressView.progress = 0.7;
    progressView.progressTintColor = [UIColor systemBlueColor];
    progressView.trackTintColor = [UIColor systemGray4Color];
    return progressView;
}

- (UIView *)createActivityIndicator {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    activityView.frame = CGRectMake(0, 0, 20, 20);
    activityView.color = [UIColor systemBlueColor];
    [activityView startAnimating];
    return activityView;
}

- (void)setupAttributedText {
    NSString *firstPart = @"This demonstrates custom UIView components embedded within text. ";
    NSString *secondPart = @" Here's a colored view ";
    NSString *thirdPart = @" and a progress indicator ";
    NSString *fourthPart = @" with an activity spinner ";
    NSString *finalPart = @" seamlessly integrated into the text flow.";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:firstPart];
    
    // Create first view attachment (colored rectangle)
    NSTextAttachment *colorViewAttachment = [[NSTextAttachment alloc] init];
    UIView *redView = [self createColoredView:[UIColor systemRedColor] size:CGSizeMake(30, 18)];
    
    // Create image from view
    UIGraphicsBeginImageContextWithOptions(redView.bounds.size, NO, 0.0);
    [redView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    colorViewAttachment.image = viewImage;
    colorViewAttachment.bounds = CGRectMake(0, -2, 30, 18);
    
    // Append the colored view
    NSAttributedString *colorViewString = [NSAttributedString attributedStringWithAttachment:colorViewAttachment];
    [attributedText appendAttributedString:colorViewString];
    
    // Add second part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:secondPart]];
    
    // Create second view attachment (another colored view)
    NSTextAttachment *greenViewAttachment = [[NSTextAttachment alloc] init];
    UIView *greenView = [self createColoredView:[UIColor systemGreenColor] size:CGSizeMake(25, 15)];
    
    // Create image from view
    UIGraphicsBeginImageContextWithOptions(greenView.bounds.size, NO, 0.0);
    [greenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *greenViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    greenViewAttachment.image = greenViewImage;
    greenViewAttachment.bounds = CGRectMake(0, -1, 25, 15);
    
    // Append the green view
    NSAttributedString *greenViewString = [NSAttributedString attributedStringWithAttachment:greenViewAttachment];
    [attributedText appendAttributedString:greenViewString];
    
    // Add third part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:thirdPart]];
    
    // Create progress view attachment
    NSTextAttachment *progressAttachment = [[NSTextAttachment alloc] init];
    UIView *progressView = [self createProgressView];
    
    // Create image from progress view
    UIGraphicsBeginImageContextWithOptions(progressView.bounds.size, NO, 0.0);
    [progressView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *progressImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    progressAttachment.image = progressImage;
    progressAttachment.bounds = CGRectMake(0, -2, 80, 4);
    
    // Append the progress view
    NSAttributedString *progressString = [NSAttributedString attributedStringWithAttachment:progressAttachment];
    [attributedText appendAttributedString:progressString];
    
    // Add fourth part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:fourthPart]];
    
    // Create activity indicator attachment
    NSTextAttachment *activityAttachment = [[NSTextAttachment alloc] init];
    UIView *activityView = [self createActivityIndicator];
    
    // Create image from activity indicator
    UIGraphicsBeginImageContextWithOptions(activityView.bounds.size, NO, 0.0);
    [activityView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *activityImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    activityAttachment.image = activityImage;
    activityAttachment.bounds = CGRectMake(0, -2, 20, 20);
    
    // Append the activity view
    NSAttributedString *activityString = [NSAttributedString attributedStringWithAttachment:activityAttachment];
    [attributedText appendAttributedString:activityString];
    
    // Add final text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:finalPart]];
    
    self.attributedText = attributedText;
}

@end