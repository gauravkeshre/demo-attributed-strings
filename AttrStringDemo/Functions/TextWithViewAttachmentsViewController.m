//
//  TextWithViewAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithViewAttachmentsViewController.h"

@interface TextWithViewAttachmentsViewController ()

@property (nonatomic, strong) NSMutableArray<UIView *> *embeddedViews;

@end

@implementation TextWithViewAttachmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.embeddedViews = [[NSMutableArray alloc] init];
}

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

- (UIButton *)createButtonWithTitle:(NSString *)title 
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
    
    // Store button reference
    [self.embeddedViews addObject:button];
    
    return button;
}

- (UISlider *)createSliderWithValue:(float)value size:(CGSize)size {
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.value = value;
    slider.minimumTrackTintColor = [UIColor systemBlueColor];
    slider.maximumTrackTintColor = [UIColor systemGray4Color];
    
    // Add target for value changes
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.embeddedViews addObject:slider];
    return slider;
}

- (UISwitch *)createSwitchWithValue:(BOOL)isOn {
    UISwitch *switchControl = [[UISwitch alloc] init];
    switchControl.on = isOn;
    
    // Add target for value changes
    [switchControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.embeddedViews addObject:switchControl];
    return switchControl;
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
    UIButton *saveButton = [self createButtonWithTitle:@"Save" buttonType:@"save" size:CGSizeMake(50, 24) backgroundColor:[UIColor systemBlueColor]];
    NSTextAttachment *saveAttachment = [[NSTextAttachment alloc] init];
    saveAttachment.image = [self imageFromView:saveButton];
    saveAttachment.bounds = CGRectMake(0, -4, 50, 24);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:saveAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to save, "]];
    
    // Share button
    UIButton *shareButton = [self createButtonWithTitle:@"Share" buttonType:@"share" size:CGSizeMake(55, 24) backgroundColor:[UIColor systemGreenColor]];
    NSTextAttachment *shareAttachment = [[NSTextAttachment alloc] init];
    shareAttachment.image = [self imageFromView:shareButton];
    shareAttachment.bounds = CGRectMake(0, -4, 55, 24);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:shareAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to share, or "]];
    
    // Info button
    UIButton *infoButton = [self createButtonWithTitle:@"Info" buttonType:@"info" size:CGSizeMake(45, 24) backgroundColor:[UIColor systemOrangeColor]];
    NSTextAttachment *infoAttachment = [[NSTextAttachment alloc] init];
    infoAttachment.image = [self imageFromView:infoButton];
    infoAttachment.bounds = CGRectMake(0, -4, 45, 24);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:infoAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" for more details.\n\n"]];
    
    // Controls section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Interactive Controls: Adjust the slider "]];
    
    // Slider
    UISlider *slider = [self createSliderWithValue:0.6 size:CGSizeMake(80, 20)];
    NSTextAttachment *sliderAttachment = [[NSTextAttachment alloc] init];
    sliderAttachment.image = [self imageFromView:slider];
    sliderAttachment.bounds = CGRectMake(0, -2, 80, 20);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:sliderAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" or toggle the switch "]];
    
    // Switch
    UISwitch *switchControl = [self createSwitchWithValue:YES];
    NSTextAttachment *switchAttachment = [[NSTextAttachment alloc] init];
    switchAttachment.image = [self imageFromView:switchControl];
    switchAttachment.bounds = CGRectMake(0, -6, switchControl.frame.size.width, switchControl.frame.size.height);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:switchAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" to see them in action.\n\n"]];
    
    // Views section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Custom Views: Here are colored rectangles "]];
    
    // Red view
    UIView *redView = [self createColoredView:[UIColor systemRedColor] size:CGSizeMake(30, 18)];
    NSTextAttachment *redViewAttachment = [[NSTextAttachment alloc] init];
    redViewAttachment.image = [self imageFromView:redView];
    redViewAttachment.bounds = CGRectMake(0, -2, 30, 18);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:redViewAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
    
    // Green view
    UIView *greenView = [self createColoredView:[UIColor systemGreenColor] size:CGSizeMake(25, 15)];
    NSTextAttachment *greenViewAttachment = [[NSTextAttachment alloc] init];
    greenViewAttachment.image = [self imageFromView:greenView];
    greenViewAttachment.bounds = CGRectMake(0, -1, 25, 15);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:greenViewAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" embedded in text.\n\n"]];
    
    // Progress and activity section
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Progress Indicators: Loading progress "]];
    
    // Progress view
    UIView *progressView = [self createProgressView];
    NSTextAttachment *progressAttachment = [[NSTextAttachment alloc] init];
    progressAttachment.image = [self imageFromView:progressView];
    progressAttachment.bounds = CGRectMake(0, -2, 80, 4);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:progressAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" and activity indicator "]];
    
    // Activity indicator
    UIView *activityView = [self createActivityIndicator];
    NSTextAttachment *activityAttachment = [[NSTextAttachment alloc] init];
    activityAttachment.image = [self imageFromView:activityView];
    activityAttachment.bounds = CGRectMake(0, -2, 20, 20);
    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:activityAttachment]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" show different states.\n\nAll these components are fully functional and seamlessly integrated into the attributed text flow!"]];
    
    self.attributedText = attributedText;
}

- (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setupDemoViews {
    [super setupDemoViews];
    
    // Add interactive views to the text view as subviews to make them functional
    if (self.demoTextView) {
        for (UIView *view in self.embeddedViews) {
            [self.demoTextView addSubview:view];
        }
        
        // Position views manually since NSTextAttachment images are static
        [self positionEmbeddedViews];
    }
}

- (void)positionEmbeddedViews {
    // This is a simplified positioning approach
    // In production, you'd need sophisticated text layout calculations
    
    if (self.embeddedViews.count >= 6) {
        CGFloat baseY = 40;  // Starting Y position
        CGFloat lineHeight = 25;  // Approximate line height
        
        // Position buttons (first 3 views)
        if ([self.embeddedViews[0] isKindOfClass:[UIButton class]]) {
            UIButton *saveButton = (UIButton *)self.embeddedViews[0];
            saveButton.frame = CGRectMake(100, baseY, 50, 24);
            
            UIButton *shareButton = (UIButton *)self.embeddedViews[1];
            shareButton.frame = CGRectMake(180, baseY, 55, 24);
            
            UIButton *infoButton = (UIButton *)self.embeddedViews[2];
            infoButton.frame = CGRectMake(270, baseY, 45, 24);
        }
        
        // Position slider and switch
        if (self.embeddedViews.count > 3) {
            if ([self.embeddedViews[3] isKindOfClass:[UISlider class]]) {
                UISlider *slider = (UISlider *)self.embeddedViews[3];
                slider.frame = CGRectMake(160, baseY + lineHeight * 2, 80, 20);
            }
            
            if ([self.embeddedViews[4] isKindOfClass:[UISwitch class]]) {
                UISwitch *switchControl = (UISwitch *)self.embeddedViews[4];
                CGRect switchFrame = switchControl.frame;
                switchControl.frame = CGRectMake(280, baseY + lineHeight * 2 - 6, switchFrame.size.width, switchFrame.size.height);
            }
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self positionEmbeddedViews];
}

@end