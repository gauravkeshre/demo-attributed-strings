#import "TextWithViewAttachmentsViewController.h"
#import "GKSubviewTextAttachment.h"

@implementation TextWithViewAttachmentsViewController

- (UIView *)createColoredViewWithColor:(UIColor *)color size:(CGSize)size {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    view.layer.cornerRadius = 4.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor systemGrayColor].CGColor;
    return view;
}

- (UIProgressView *)createProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, 0, 80, 4);
    progressView.progress = 0.7;
    progressView.progressTintColor = [UIColor systemBlueColor];
    progressView.trackTintColor = [UIColor systemGray4Color];
    return progressView;
}

- (UIActivityIndicatorView *)createActivityIndicator {
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
    
    return slider;
}

- (UISwitch *)createSwitchWithValue:(BOOL)isOn {
    UISwitch *switchControl = [[UISwitch alloc] init];
    switchControl.on = isOn;
    
    // Add target for value changes
    [switchControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    return switchControl;
}

- (void)buttonTapped:(UIButton *)sender {
    NSString *title;
    NSString *message;
    
    if ([sender.accessibilityIdentifier isEqualToString:@"save"]) {
        title = @"Save Button Tapped";
        message = @"The embedded save button was tapped!";
    } else if ([sender.accessibilityIdentifier isEqualToString:@"edit"]) {
        title = @"Edit Button Tapped";
        message = @"The embedded edit button was tapped!";
    } else if ([sender.accessibilityIdentifier isEqualToString:@"delete"]) {
        title = @"Delete Button Tapped";
        message = @"The embedded delete button was tapped!";
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
    
    // Title
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Interactive UI Elements in Text\n\n" 
                                                                attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:20]
    }];
    [attributedText appendAttributedString:title];
    
    // Colored views section
    NSAttributedString *coloredViewsText = [[NSAttributedString alloc] initWithString:@"Colored Views: " 
                                                                          attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:coloredViewsText];
    
    // Red view attachment
    UIView *redView = [self createColoredViewWithColor:[UIColor systemRedColor] size:CGSizeMake(20, 16)];
    GKSubviewTextAttachment *redViewAttachment = [[GKSubviewTextAttachment alloc] initWithView:redView];
    NSAttributedString *redViewAttrStr = [NSAttributedString attributedStringWithAttachment:redViewAttachment];
    [attributedText appendAttributedString:redViewAttrStr];
    
    NSAttributedString *spacer = [[NSAttributedString alloc] initWithString:@" "];
    [attributedText appendAttributedString:spacer];
    
    // Green view attachment
    UIView *greenView = [self createColoredViewWithColor:[UIColor systemGreenColor] size:CGSizeMake(20, 16)];
    GKSubviewTextAttachment *greenViewAttachment = [[GKSubviewTextAttachment alloc] initWithView:greenView];
    NSAttributedString *greenViewAttrStr = [NSAttributedString attributedStringWithAttachment:greenViewAttachment];
    [attributedText appendAttributedString:greenViewAttrStr];
    
    [attributedText appendAttributedString:spacer];
    
    // Blue view attachment
    UIView *blueView = [self createColoredViewWithColor:[UIColor systemBlueColor] size:CGSizeMake(20, 16)];
    GKSubviewTextAttachment *blueViewAttachment = [[GKSubviewTextAttachment alloc] initWithView:blueView];
    NSAttributedString *blueViewAttrStr = [NSAttributedString attributedStringWithAttachment:blueViewAttachment];
    [attributedText appendAttributedString:blueViewAttrStr];
    
    NSAttributedString *newline = [[NSAttributedString alloc] initWithString:@"\n\n"];
    [attributedText appendAttributedString:newline];
    
    // Progress view section
    NSAttributedString *progressText = [[NSAttributedString alloc] initWithString:@"Progress: " 
                                                                      attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:progressText];
    
    UIProgressView *progressView = [self createProgressView];
    GKSubviewTextAttachment *progressAttachment = [[GKSubviewTextAttachment alloc] initWithView:progressView];
    NSAttributedString *progressAttrStr = [NSAttributedString attributedStringWithAttachment:progressAttachment];
    [attributedText appendAttributedString:progressAttrStr];
    
    NSAttributedString *progressLabel = [[NSAttributedString alloc] initWithString:@" 70%" 
                                                                       attributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }];
    [attributedText appendAttributedString:progressLabel];
    [attributedText appendAttributedString:newline];
    
    // Activity indicator section
    NSAttributedString *activityText = [[NSAttributedString alloc] initWithString:@"Loading: " 
                                                                      attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:activityText];
    
    UIActivityIndicatorView *activityView = [self createActivityIndicator];
    GKSubviewTextAttachment *activityAttachment = [[GKSubviewTextAttachment alloc] initWithView:activityView];
    NSAttributedString *activityAttrStr = [NSAttributedString attributedStringWithAttachment:activityAttachment];
    [attributedText appendAttributedString:activityAttrStr];
    
    NSAttributedString *activityLabel = [[NSAttributedString alloc] initWithString:@" Processing..." 
                                                                       attributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }];
    [attributedText appendAttributedString:activityLabel];
    [attributedText appendAttributedString:newline];
    
    // Button section
    NSAttributedString *buttonText = [[NSAttributedString alloc] initWithString:@"Actions: " 
                                                                    attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:buttonText];
    
    // Save button
    UIButton *saveButton = [self createButtonWithTitle:@"Save" 
                                            buttonType:@"save" 
                                                  size:CGSizeMake(50, 28) 
                                       backgroundColor:[UIColor systemBlueColor]];
    GKSubviewTextAttachment *saveButtonAttachment = [[GKSubviewTextAttachment alloc] initWithView:saveButton];
    NSAttributedString *saveButtonAttrStr = [NSAttributedString attributedStringWithAttachment:saveButtonAttachment];
    [attributedText appendAttributedString:saveButtonAttrStr];
    
    [attributedText appendAttributedString:spacer];
    
    // Edit button
    UIButton *editButton = [self createButtonWithTitle:@"Edit" 
                                            buttonType:@"edit" 
                                                  size:CGSizeMake(50, 28) 
                                       backgroundColor:[UIColor systemOrangeColor]];
    GKSubviewTextAttachment *editButtonAttachment = [[GKSubviewTextAttachment alloc] initWithView:editButton];
    NSAttributedString *editButtonAttrStr = [NSAttributedString attributedStringWithAttachment:editButtonAttachment];
    [attributedText appendAttributedString:editButtonAttrStr];
    
    [attributedText appendAttributedString:spacer];
    
    // Delete button
    UIButton *deleteButton = [self createButtonWithTitle:@"Delete" 
                                              buttonType:@"delete" 
                                                    size:CGSizeMake(60, 28) 
                                         backgroundColor:[UIColor systemRedColor]];
    GKSubviewTextAttachment *deleteButtonAttachment = [[GKSubviewTextAttachment alloc] initWithView:deleteButton];
    NSAttributedString *deleteButtonAttrStr = [NSAttributedString attributedStringWithAttachment:deleteButtonAttachment];
    [attributedText appendAttributedString:deleteButtonAttrStr];
    
    [attributedText appendAttributedString:newline];
    
    // Slider section
    NSAttributedString *sliderText = [[NSAttributedString alloc] initWithString:@"Volume: " 
                                                                    attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:sliderText];
    
    UISlider *slider = [self createSliderWithValue:0.6 size:CGSizeMake(100, 20)];
    GKSubviewTextAttachment *sliderAttachment = [[GKSubviewTextAttachment alloc] initWithView:slider];
    NSAttributedString *sliderAttrStr = [NSAttributedString attributedStringWithAttachment:sliderAttachment];
    [attributedText appendAttributedString:sliderAttrStr];
    
    NSAttributedString *sliderLabel = [[NSAttributedString alloc] initWithString:@" 60%" 
                                                                     attributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }];
    [attributedText appendAttributedString:sliderLabel];
    [attributedText appendAttributedString:newline];
    
    // Switch section
    NSAttributedString *switchText = [[NSAttributedString alloc] initWithString:@"Notifications: " 
                                                                    attributes:@{
        NSForegroundColorAttributeName: [UIColor labelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightMedium]
    }];
    [attributedText appendAttributedString:switchText];
    
    UISwitch *switchControl = [self createSwitchWithValue:YES];
    GKSubviewTextAttachment *switchAttachment = [[GKSubviewTextAttachment alloc] initWithView:switchControl];
    NSAttributedString *switchAttrStr = [NSAttributedString attributedStringWithAttachment:switchAttachment];
    [attributedText appendAttributedString:switchAttrStr];
    
    NSAttributedString *switchLabel = [[NSAttributedString alloc] initWithString:@" Enabled" 
                                                                     attributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }];
    [attributedText appendAttributedString:switchLabel];
    [attributedText appendAttributedString:newline];
    
    // Footer text
    NSAttributedString *footerText = [[NSAttributedString alloc] initWithString:@"\nAll of these UI elements are embedded directly in the text and are fully interactive. You can tap buttons, adjust sliders, and toggle switches." 
                                                                    attributes:@{
        NSForegroundColorAttributeName: [UIColor secondaryLabelColor],
        NSFontAttributeName: [UIFont italicSystemFontOfSize:14]
    }];
    [attributedText appendAttributedString:footerText];
    
    self.attributedText = attributedText;
}

@end