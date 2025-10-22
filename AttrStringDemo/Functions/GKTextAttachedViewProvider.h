//
//  GKTextAttachedViewProvider.h
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@class GKSubviewTextAttachment;
@class GKSubviewAttachingTextViewBehavior;

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol that provides views inserted as subviews into text views that render a GKSubviewTextAttachment,
 and customizes their layout.
 */
@protocol GKTextAttachedViewProvider <NSObject>

/**
 Returns a view that corresponds to the specified attachment.
 Each GKSubviewAttachingTextViewBehavior caches instantiated views until the attachment leaves the text container.
 */
- (UIView *)instantiateViewForAttachment:(GKSubviewTextAttachment *)attachment 
                              inBehavior:(GKSubviewAttachingTextViewBehavior *)behavior;

/**
 Returns the layout bounds of the view that corresponds to the specified attachment.
 Return attachment.bounds for default behavior.
 */
- (CGRect)boundsForAttachment:(GKSubviewTextAttachment *)attachment
                textContainer:(nullable NSTextContainer *)textContainer
        proposedLineFragment:(CGRect)lineFrag
               glyphPosition:(CGPoint)position;

@end

NS_ASSUME_NONNULL_END