//
//  GKSubviewAttachingTextViewBehavior.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "GKSubviewAttachingTextViewBehavior.h"
#import "GKSubviewTextAttachment.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NSAttributedString (GKSubviewAttachments)
- (NSArray<NSDictionary *> *)gk_subviewAttachmentRanges;
@end

@interface UITextView (GKCoordinateConversion)
- (CGPoint)gk_convertPointToTextContainer:(CGPoint)point;
- (CGPoint)gk_convertPointFromTextContainer:(CGPoint)point;
- (CGRect)gk_convertRectToTextContainer:(CGRect)rect;
- (CGRect)gk_convertRectFromTextContainer:(CGRect)rect;
@end

// Utility function to convert CGPoint to integral coordinates
static CGPoint GKIntegralPointWithScaleFactor(CGPoint point, CGFloat scaleFactor) {
    if (scaleFactor <= 0.0) {
        return point;
    }
    
    return CGPointMake(round(point.x * scaleFactor) / scaleFactor,
                       round(point.y * scaleFactor) / scaleFactor);
}

@implementation GKSubviewAttachingTextViewBehavior {
    NSMapTable<id<GKTextAttachedViewProvider>, UIView *> *_attachedViews;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _attachedViews = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                               valueOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}

#pragma mark - Properties

- (void)setTextView:(UITextView *)textView {
    if (_textView == textView) {
        return;
    }
    
    // Remove all managed subviews from the text view being disconnected
    [self removeAttachedSubviews];
    
    _textView = textView;
    
    // Synchronize managed subviews to the new text view
    [self updateAttachedSubviews];
    [self layoutAttachedSubviews];
}

#pragma mark - Subview tracking

- (NSArray<id<GKTextAttachedViewProvider>> *)attachedProviders {
    NSMutableArray<id<GKTextAttachedViewProvider>> *providers = [NSMutableArray array];
    NSEnumerator *keyEnumerator = [_attachedViews keyEnumerator];
    id<GKTextAttachedViewProvider> provider;
    while ((provider = [keyEnumerator nextObject])) {
        [providers addObject:provider];
    }
    return [providers copy];
}

- (void)updateAttachedSubviews {
    if (!self.textView) {
        return;
    }
    
    // Collect all GKSubviewTextAttachment attachments
    NSArray<NSDictionary *> *attachmentRanges = [self.textView.textStorage gk_subviewAttachmentRanges];
    NSMutableArray<GKSubviewTextAttachment *> *subviewAttachments = [NSMutableArray array];
    
    for (NSDictionary *rangeDict in attachmentRanges) {
        GKSubviewTextAttachment *attachment = rangeDict[@"attachment"];
        [subviewAttachments addObject:attachment];
    }
    
    // Remove views whose providers are no longer attached
    NSArray<id<GKTextAttachedViewProvider>> *currentProviders = [self attachedProviders];
    for (id<GKTextAttachedViewProvider> provider in currentProviders) {
        BOOL found = NO;
        for (GKSubviewTextAttachment *attachment in subviewAttachments) {
            if (attachment.viewProvider == provider) {
                found = YES;
                break;
            }
        }
        if (!found) {
            UIView *view = [_attachedViews objectForKey:provider];
            [view removeFromSuperview];
            [_attachedViews removeObjectForKey:provider];
        }
    }
    
    // Insert views that became attached
    for (GKSubviewTextAttachment *attachment in subviewAttachments) {
        id<GKTextAttachedViewProvider> provider = attachment.viewProvider;
        if (![_attachedViews objectForKey:provider]) {
            UIView *view = [provider instantiateViewForAttachment:attachment inBehavior:self];
            view.translatesAutoresizingMaskIntoConstraints = YES;
            view.autoresizingMask = 0; // No autoresizing
            
            [self.textView addSubview:view];
            [_attachedViews setObject:view forKey:provider];
        }
    }
}

- (void)removeAttachedSubviews {
    NSArray<id<GKTextAttachedViewProvider>> *providers = [self attachedProviders];
    for (id<GKTextAttachedViewProvider> provider in providers) {
        UIView *view = [_attachedViews objectForKey:provider];
        [view removeFromSuperview];
    }
    [_attachedViews removeAllObjects];
}

#pragma mark - Layout

- (void)layoutAttachedSubviews {
    if (!self.textView) {
        return;
    }
    
    NSLayoutManager *layoutManager = self.textView.layoutManager;
    CGFloat scaleFactor = self.textView.window.screen.scale ?: [UIScreen mainScreen].scale;
    
    // For each attached subview, find its associated attachment and position it according to its text layout
    NSArray<NSDictionary *> *attachmentRanges = [self.textView.textStorage gk_subviewAttachmentRanges];
    
    for (NSDictionary *rangeDict in attachmentRanges) {
        GKSubviewTextAttachment *attachment = rangeDict[@"attachment"];
        NSRange range = [rangeDict[@"range"] rangeValue];
        
        UIView *view = [_attachedViews objectForKey:attachment.viewProvider];
        if (!view) {
            continue;
        }
        
        CGRect boundingRect = [self boundingRectForAttachmentCharacterAtIndex:range.location
                                                                layoutManager:layoutManager];
        if (CGRectEqualToRect(boundingRect, CGRectZero)) {
            view.hidden = YES;
        } else {
            view.hidden = NO;
            
            CGPoint textViewPoint = [self.textView gk_convertPointFromTextContainer:boundingRect.origin];
            CGPoint integralOrigin = GKIntegralPointWithScaleFactor(textViewPoint, scaleFactor);
            
            CGRect viewFrame = view.frame;
            viewFrame.origin = integralOrigin;
            view.frame = viewFrame;
        }
    }
}

- (CGRect)boundingRectForAttachmentCharacterAtIndex:(NSUInteger)characterIndex
                                      layoutManager:(NSLayoutManager *)layoutManager {
    NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:NSMakeRange(characterIndex, 1)
                                                actualCharacterRange:nil];
    NSUInteger glyphIndex = glyphRange.location;
    
    if (glyphIndex == NSNotFound || glyphRange.length != 1) {
        return CGRectZero;
    }
    
    CGSize attachmentSize = [layoutManager attachmentSizeForGlyphAtIndex:glyphIndex];
    if (attachmentSize.width <= 0.0 || attachmentSize.height <= 0.0) {
        return CGRectZero;
    }
    
    CGRect lineFragmentRect = [layoutManager lineFragmentRectForGlyphAtIndex:glyphIndex
                                                             effectiveRange:nil];
    CGPoint glyphLocation = [layoutManager locationForGlyphAtIndex:glyphIndex];
    
    if (lineFragmentRect.size.width <= 0.0 || lineFragmentRect.size.height <= 0.0) {
        return CGRectZero;
    }
    
    return CGRectMake(lineFragmentRect.origin.x + glyphLocation.x,
                      lineFragmentRect.origin.y + glyphLocation.y,
                      attachmentSize.width,
                      attachmentSize.height);
}

#pragma mark - NSLayoutManagerDelegate

- (void)layoutManager:(NSLayoutManager *)layoutManager
didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer
                atEnd:(BOOL)layoutFinishedFlag {
    if (layoutFinishedFlag) {
        [self layoutAttachedSubviews];
    }
}

#pragma mark - NSTextStorageDelegate

- (void)textStorage:(NSTextStorage *)textStorage
didProcessEditing:(NSTextStorageEditActions)editedMask
              range:(NSRange)editedRange
     changeInLength:(NSInteger)delta {
    if (editedMask & NSTextStorageEditedAttributes) {
        [self updateAttachedSubviews];
    }
}

@end

#pragma mark - Category Implementations

@implementation NSAttributedString (GKSubviewAttachments)

- (NSArray<NSDictionary *> *)gk_subviewAttachmentRanges {
    NSMutableArray<NSDictionary *> *ranges = [NSMutableArray array];
    
    NSRange fullRange = NSMakeRange(0, self.length);
    [self enumerateAttribute:NSAttachmentAttributeName
                     inRange:fullRange
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
        if ([value isKindOfClass:[GKSubviewTextAttachment class]]) {
            GKSubviewTextAttachment *attachment = (GKSubviewTextAttachment *)value;
            NSDictionary *rangeDict = @{
                @"attachment": attachment,
                @"range": [NSValue valueWithRange:range]
            };
            [ranges addObject:rangeDict];
        }
    }];
    
    return [ranges copy];
}

@end

@implementation UITextView (GKCoordinateConversion)

- (CGPoint)gk_convertPointToTextContainer:(CGPoint)point {
    UIEdgeInsets insets = self.textContainerInset;
    return CGPointMake(point.x - insets.left, point.y - insets.top);
}

- (CGPoint)gk_convertPointFromTextContainer:(CGPoint)point {
    UIEdgeInsets insets = self.textContainerInset;
    return CGPointMake(point.x + insets.left, point.y + insets.top);
}

- (CGRect)gk_convertRectToTextContainer:(CGRect)rect {
    UIEdgeInsets insets = self.textContainerInset;
    return CGRectOffset(rect, -insets.left, -insets.top);
}

- (CGRect)gk_convertRectFromTextContainer:(CGRect)rect {
    UIEdgeInsets insets = self.textContainerInset;
    return CGRectOffset(rect, insets.left, insets.top);
}

@end

