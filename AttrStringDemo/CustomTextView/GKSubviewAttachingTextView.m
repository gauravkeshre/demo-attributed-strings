//
//  GKSubviewAttachingTextView.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "GKSubviewAttachingTextView.h"
#import "GKSubviewAttachingTextViewBehavior.h"

@interface GKSubviewAttachingTextView ()
@property (nonatomic, strong) GKSubviewAttachingTextViewBehavior *attachmentBehavior;
@end

@implementation GKSubviewAttachingTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // Connect the attachment behavior
    self.attachmentBehavior = [[GKSubviewAttachingTextViewBehavior alloc] init];
    self.attachmentBehavior.textView = self;
    self.layoutManager.delegate = self.attachmentBehavior;
    self.textStorage.delegate = self.attachmentBehavior;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    
    // Text container insets are used to convert coordinates between the text container and text view,
    // so a change to these insets must trigger a layout update
    [self.attachmentBehavior layoutAttachedSubviews];
}

@end