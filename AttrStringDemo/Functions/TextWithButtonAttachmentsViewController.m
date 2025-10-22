//
//  TextWithButtonAttachmentsViewController.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "TextWithButtonAttachmentsViewController.h"

@interface TextWithButtonAttachmentsViewController ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *embeddedButtons;

@end

@implementation TextWithButtonAttachmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.embeddedButtons = [[NSMutableArray alloc] init];
}

- (UIButton *)createButtonWithTitle:(NSString *)title 
                        buttonType:(NSString *)buttonType
                              size:(CGSize)size {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor systemBlueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    button.layer.cornerRadius = 4.0;
    
    // Set accessibility identifier to distinguish buttons
    button.accessibilityIdentifier = buttonType;
    
    // Add target for button tap
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Store button reference
    [self.embeddedButtons addObject:button];
    
    return button;
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

- (void)setupAttributedText {
    NSString *firstPart = @"This demonstrates interactive UIButton components embedded within text. ";
    NSString *secondPart = @" Click the Save button to save your work, ";
    NSString *thirdPart = @" use Share to share content, ";
    NSString *fourthPart = @" or tap Info for more details ";
    NSString *finalPart = @" All buttons are fully functional within the attributed text!";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:firstPart];
    
    // Create first button attachment (Save)
    NSTextAttachment *saveButtonAttachment = [[NSTextAttachment alloc] init];
    UIButton *saveButton = [self createButtonWithTitle:@"Save" buttonType:@"save" size:CGSizeMake(50, 24)];
    
    // Create image from button
    UIGraphicsBeginImageContextWithOptions(saveButton.bounds.size, NO, 0.0);
    [saveButton.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *saveButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    saveButtonAttachment.image = saveButtonImage;
    saveButtonAttachment.bounds = CGRectMake(0, -4, 50, 24);
    
    // Append the save button
    NSAttributedString *saveButtonString = [NSAttributedString attributedStringWithAttachment:saveButtonAttachment];
    [attributedText appendAttributedString:saveButtonString];
    
    // Add second part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:secondPart]];
    
    // Create second button attachment (Share)
    NSTextAttachment *shareButtonAttachment = [[NSTextAttachment alloc] init];
    UIButton *shareButton = [self createButtonWithTitle:@"Share" buttonType:@"share" size:CGSizeMake(55, 24)];
    shareButton.backgroundColor = [UIColor systemGreenColor];
    
    // Create image from share button
    UIGraphicsBeginImageContextWithOptions(shareButton.bounds.size, NO, 0.0);
    [shareButton.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shareButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    shareButtonAttachment.image = shareButtonImage;
    shareButtonAttachment.bounds = CGRectMake(0, -4, 55, 24);
    
    // Append the share button
    NSAttributedString *shareButtonString = [NSAttributedString attributedStringWithAttachment:shareButtonAttachment];
    [attributedText appendAttributedString:shareButtonString];
    
    // Add third part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:thirdPart]];
    
    // Create third button attachment (Info)
    NSTextAttachment *infoButtonAttachment = [[NSTextAttachment alloc] init];
    UIButton *infoButton = [self createButtonWithTitle:@"Info" buttonType:@"info" size:CGSizeMake(45, 24)];
    infoButton.backgroundColor = [UIColor systemOrangeColor];
    
    // Create image from info button
    UIGraphicsBeginImageContextWithOptions(infoButton.bounds.size, NO, 0.0);
    [infoButton.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *infoButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    infoButtonAttachment.image = infoButtonImage;
    infoButtonAttachment.bounds = CGRectMake(0, -4, 45, 24);
    
    // Append the info button
    NSAttributedString *infoButtonString = [NSAttributedString attributedStringWithAttachment:infoButtonAttachment];
    [attributedText appendAttributedString:infoButtonString];
    
    // Add fourth part text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:fourthPart]];
    
    // Add final text
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:finalPart]];
    
    self.attributedText = attributedText;
}

- (void)setupDemoViews {
    [super setupDemoViews];
    
    // Add buttons to the text view as subviews to make them interactive
    if (self.demoTextView) {
        for (UIButton *button in self.embeddedButtons) {
            [self.demoTextView addSubview:button];
        }
        
        // Position buttons manually since NSTextAttachment images are static
        [self positionEmbeddedButtons];
    }
}

- (void)positionEmbeddedButtons {
    // This is a simplified positioning - in a real implementation you'd need
    // to calculate the exact positions based on text layout
    if (self.embeddedButtons.count >= 3) {
        // Position the buttons approximately where they appear in the text
        // This is a basic implementation - more sophisticated text layout would be needed for perfect positioning
        
        CGRect textViewBounds = self.demoTextView.bounds;
        CGFloat buttonY = 20; // Approximate first line position
        
        // Save button
        UIButton *saveButton = self.embeddedButtons[0];
        saveButton.frame = CGRectMake(320, buttonY, 50, 24);
        
        // Share button  
        UIButton *shareButton = self.embeddedButtons[1];
        shareButton.frame = CGRectMake(80, buttonY + 40, 55, 24);
        
        // Info button
        UIButton *infoButton = self.embeddedButtons[2];
        infoButton.frame = CGRectMake(220, buttonY + 80, 45, 24);
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self positionEmbeddedButtons];
}

@end