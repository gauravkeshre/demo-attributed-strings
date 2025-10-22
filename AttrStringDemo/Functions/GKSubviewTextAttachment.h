//
//  GKSubviewTextAttachment.h
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import <UIKit/UIKit.h>
#import "GKTextAttachedViewProvider.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Custom text attachment object containing a view. GKSubviewAttachingTextViewBehavior tracks attachments
 of this class and automatically manages adding and removing subviews in its text view.
 */
@interface GKSubviewTextAttachment : NSTextAttachment

@property (nonatomic, strong, readonly) id<GKTextAttachedViewProvider> viewProvider;

/**
 Initialize the attachment with a view provider.
 */
- (instancetype)initWithViewProvider:(id<GKTextAttachedViewProvider>)viewProvider;

/**
 Initialize the attachment with a view and an explicit size.
 Warning: If an attributed string that includes the returned attachment is used in more than one text view
 at a time, the behavior is not defined.
 */
- (instancetype)initWithView:(UIView *)view size:(CGSize)size;

/**
 Initialize the attachment with a view and use its current fitting size as the attachment size.
 If the view does not define a fitting size, its current bounds size is used.
 Warning: If an attributed string that includes the returned attachment is used in more than one text view
 at a time, the behavior is not defined.
 */
- (instancetype)initWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END