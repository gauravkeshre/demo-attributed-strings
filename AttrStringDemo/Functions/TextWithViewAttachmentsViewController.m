//
//  TextWithViewAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithViewAttachmentsViewController.h"
#import "GKViewTextAttachment.h"

@interface TextWithViewAttachmentsViewController ()

@property (nonatomic, strong) NSMutableArray<GKViewTextAttachment *> *embeddedAttachments;

@end

@implementation TextWithViewAttachmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.embeddedAttachments = [[NSMutableArray alloc] init];
}

- (GKViewTextAttachment *)createColoredViewAttachment:(UIColor *)color size:(CGSize)size {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    view.layer.cornerRadius = 4.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor systemGrayColor].CGColor;
    
    // Create attachment with the view
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = view;
    attachment.bounds = CGRectMake(0, -2, size.width, size.height);
    
    [self.embeddedAttachments addObject:attachment];
    return attachment;
}

- (GKViewTextAttachment *)createProgressViewAttachment {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, 0, 80, 4);
    progressView.progress = 0.7;
    progressView.progressTintColor = [UIColor systemBlueColor];
    progressView.trackTintColor = [UIColor systemGray4Color];
    
    // Create attachment with the progress view
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = progressView;
    attachment.bounds = CGRectMake(0, -2, 80, 4);
    
    [self.embeddedAttachments addObject:attachment];
    return attachment;
}

- (GKViewTextAttachment *)createActivityIndicatorAttachment {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    activityView.frame = CGRectMake(0, 0, 20, 20);
    activityView.color = [UIColor systemBlueColor];
    [activityView startAnimating];
    
    // Create attachment with the activity indicator
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = activityView;
    attachment.bounds = CGRectMake(0, -2, 20, 20);
    
    [self.embeddedAttachments addObject:attachment];
    return attachment;
}

- (GKViewTextAttachment *)createButtonAttachmentWithTitle:(NSString *)title 
                                              buttonType:(NSString *)buttonType
                                                    size:(CGSize)size 
                                         backgroundColor:(UIColor *)backgroundColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    button.layer.cornerRadius = 4.0;
    
    // Set accessibility identifier to distinguish buttons
    button.accessibilityIdentifier = buttonType;
    
    // Add target for button tap
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Create attachment with the button
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = button;
    attachment.bounds = CGRectMake(0, -4, size.width, size.height);
    
    // Store attachment reference
    [self.embeddedAttachments addObject:attachment];
    
    return attachment;
}

- (GKViewTextAttachment *)createSliderAttachmentWithValue:(float)value size:(CGSize)size {
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.value = value;
    slider.minimumTrackTintColor = [UIColor systemBlueColor];
    slider.maximumTrackTintColor = [UIColor systemGray4Color];
    
    // Add target for value changes
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Create attachment with the slider
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = slider;
    attachment.bounds = CGRectMake(0, -2, size.width, size.height);
    
    [self.embeddedAttachments addObject:attachment];
    return attachment;
}

- (GKViewTextAttachment *)createSwitchAttachmentWithValue:(BOOL)isOn {
    UISwitch *switchControl = [[UISwitch alloc] init];
    switchControl.on = isOn;
    
    // Add target for value changes
    [switchControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Create attachment with the switch
    GKViewTextAttachment *attachment = [[GKViewTextAttachment alloc] init];
    attachment.customView = switchControl;
    attachment.bounds = CGRectMake(0, -6, switchControl.frame.size.width, switchControl.frame.size.height);
    
    [self.embeddedAttachments addObject:attachment];
    return attachment;
}

- (void)buttonTapped:(UIButton *)sender {
    NSString *buttonType = sender.accessibilityIdentifier;
    NSString *title;
    NSString *message;
    
    if ([buttonType isEqualToString:@"save"]) {
        title = @"Save Action";
        message = @"Save button was tapped! This could save your current progress or document.";
    } else if ([buttonType isEqualToString:@"share"]) {
        title = @"Share Action";
        message = @"Share button was tapped! This could open sharing options for your content.";
    } else if ([buttonType isEqualToString:@"info"]) {
        title = @"Info Action";
        message = @"Info button was tapped! This could show additional information or help.";
    } else {
        title = @"Button Tapped";
        message = @"An embedded button was tapped!";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" 
                                                       style:UIAlertActionStyleDefault 
                                                     handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sliderValueChanged:(UISlider *)sender {
    NSString *message = [NSString stringWithFormat:@"Slider value changed to: %.2f", sender.value];
    NSLog(@"%@", message);
}

- (void)switchValueChanged:(UISwitch *)sender {
    NSString *message = [NSString stringWithFormat:@"Switch is now: %@", sender.isOn ? @"ON" : @"OFF"];
    NSLog(@"%@", message);
}

- (void)setupAttributedText {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // Introduction
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"This demonstrates various interactive UI components embedded within attributed text.\n\n"]];
    
    // Buttons section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Interactive Buttons: Tap "]];
    
    // Save button
    GKViewTextAttachment *saveAttachment = [self createButtonAttachmentWithTitle:@"Save" 
                                                                      buttonType:@"save" 
                                                                            size:CGSizeMake(50, 24) 
                                                                 backgroundColor:[UIColor systemBlueColor]];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:saveAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to save, "]];
    
    // Share button
    GKViewTextAttachment *shareAttachment = [self createButtonAttachmentWithTitle:@"Share" 
                                                                       buttonType:@"share" 
                                                                             size:CGSizeMake(55, 24) 
                                                                  backgroundColor:[UIColor systemGreenColor]];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:shareAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to share, or "]];
    
    // Info button
    GKViewTextAttachment *infoAttachment = [self createButtonAttachmentWithTitle:@"Info" 
                                                                      buttonType:@"info" 
                                                                            size:CGSizeMake(45, 24) 
                                                                 backgroundColor:[UIColor systemOrangeColor]];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:infoAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" for more details.\n\n"]];
    
    // Controls section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Interactive Controls: Adjust the slider "]];
    
    // Slider
    GKViewTextAttachment *sliderAttachment = [self createSliderAttachmentWithValue:0.6 size:CGSizeMake(80, 20)];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:sliderAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" or toggle the switch "]];
    
    // Switch
    GKViewTextAttachment *switchAttachment = [self createSwitchAttachmentWithValue:YES];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:switchAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to see them in action.\n\n"]];
    
    // Views section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Custom Views: Here are colored rectangles "]];
    
    // Red view
    GKViewTextAttachment *redViewAttachment = [self createColoredViewAttachment:[UIColor systemRedColor] size:CGSizeMake(30, 18)];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:redViewAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
    
    // Green view
    GKViewTextAttachment *greenViewAttachment = [self createColoredViewAttachment:[UIColor systemGreenColor] size:CGSizeMake(25, 15)];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:greenViewAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" embedded in text.\n\n"]];
    
    // Progress and activity section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Progress Indicators: Loading progress "]];
    
    // Progress view
    GKViewTextAttachment *progressAttachment = [self createProgressViewAttachment];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:progressAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" and activity indicator "]];
    
    // Activity indicator
    GKViewTextAttachment *activityAttachment = [self createActivityIndicatorAttachment];
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:activityAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" show different states.\n\nAll these components are fully functional and seamlessly integrated into the attributed text flow!"]];
    
    self.attributedText = attributedText;
}

- (void)setupDemoViews {
    [super setupDemoViews];
    
    // Add interactive views to the text view as subviews to make them functional
    if (self.demoTextView) {
        for (GKViewTextAttachment *attachment in self.embeddedAttachments) {
            if (attachment.customView) {
                [self.demoTextView addSubview:attachment.customView];
            }
        }
        
        // Ensure layout is complete before positioning
        [self.demoTextView setNeedsLayout];
        [self.demoTextView layoutIfNeeded];
        
        // Position views after layout is complete
        dispatch_async(dispatch_get_main_queue(), ^{
            [self positionEmbeddedViews];
        });
    }
}

- (void)positionEmbeddedViews {
    if (!self.demoTextView || !self.demoTextView.textStorage || self.embeddedAttachments.count == 0) {
        NSLog(@"Cannot position views - missing components");
        return;
    }
    
    // Get the layout manager and text container for precise positioning
    NSLayoutManager *layoutManager = self.demoTextView.layoutManager;
    NSTextContainer *textContainer = self.demoTextView.textContainer;
    
    // Find positions of attachments in the text
    NSAttributedString *attributedString = self.demoTextView.attributedText;
    
    NSLog(@"Positioning %lu attachments in text of length %lu", (unsigned long)self.embeddedAttachments.count, (unsigned long)attributedString.length);
    
    // Find and position each attachment
    [attributedString enumerateAttribute:NSAttachmentAttributeName 
                                 inRange:NSMakeRange(0, attributedString.length) 
                                 options:0 
                              usingBlock:^(id value, NSRange range, BOOL *stop) {
        if ([value isKindOfClass:[GKViewTextAttachment class]]) {
            GKViewTextAttachment *attachment = (GKViewTextAttachment *)value;
            
            // Get the glyph range and bounding rect for this attachment
            NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:range actualCharacterRange:nil];
            
            if (glyphRange.location != NSNotFound) {
                CGRect boundingRect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
                
                // Adjust for text view insets and content offset
                CGFloat x = boundingRect.origin.x + self.demoTextView.textContainerInset.left;
                CGFloat y = boundingRect.origin.y + self.demoTextView.textContainerInset.top;
                
                NSLog(@"Positioning attachment at (%.1f, %.1f) with bounds: %@", x, y, NSStringFromCGRect(boundingRect));
                
                // Position the actual interactive view over the rendered image
                if (attachment.customView) {
                    CGRect currentFrame = attachment.customView.frame;
                    attachment.customView.frame = CGRectMake(x, y, currentFrame.size.width, currentFrame.size.height);
                    NSLog(@"Set view frame to: %@", NSStringFromCGRect(attachment.customView.frame));
                }
            }
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self positionEmbeddedViews];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    // Position views after the attributed text is set and layout is updated
    if (self.isViewLoaded && self.demoTextView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self positionEmbeddedViews];
        });
    }
}

@end
