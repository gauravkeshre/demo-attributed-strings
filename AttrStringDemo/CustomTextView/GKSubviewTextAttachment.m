//
//  GKSubviewTextAttachment.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "GKSubviewTextAttachment.h"

@interface GKDirectTextAttachedViewProvider : NSObject <GKTextAttachedViewProvider>
@property (nonatomic, strong) UIView *view;
- (instancetype)initWithView:(UIView *)view;
@end

@implementation GKDirectTextAttachedViewProvider

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
    }
    return self;
}

- (UIView *)instantiateViewForAttachment:(GKSubviewTextAttachment *)attachment 
                              inBehavior:(GKSubviewAttachingTextViewBehavior *)behavior {
    return self.view;
}

- (CGRect)boundsForAttachment:(GKSubviewTextAttachment *)attachment
                textContainer:(NSTextContainer *)textContainer
        proposedLineFragment:(CGRect)lineFrag
               glyphPosition:(CGPoint)position {
    return attachment.bounds;
}

@end

@interface UIView (GKTextAttachmentFittingSize)
- (CGSize)gk_textAttachmentFittingSize;
@end

@implementation UIView (GKTextAttachmentFittingSize)

- (CGSize)gk_textAttachmentFittingSize {
    CGSize fittingSize = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (fittingSize.width > 1e-3 && fittingSize.height > 1e-3) {
        return fittingSize;
    } else {
        return self.bounds.size;
    }
}

@end

@implementation GKSubviewTextAttachment

- (instancetype)initWithViewProvider:(id<GKTextAttachedViewProvider>)viewProvider {
    self = [super initWithData:nil ofType:nil];
    if (self) {
        _viewProvider = viewProvider;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view size:(CGSize)size {
    GKDirectTextAttachedViewProvider *provider = [[GKDirectTextAttachedViewProvider alloc] initWithView:view];
    self = [self initWithViewProvider:provider];
    if (self) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view size:[view gk_textAttachmentFittingSize]];
}

#pragma mark - NSTextAttachmentContainer

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex {
    return [self.viewProvider boundsForAttachment:self
                                    textContainer:textContainer
                            proposedLineFragment:lineFrag
                                   glyphPosition:position];
}

- (nullable UIImage *)imageForBounds:(CGRect)imageBounds
                       textContainer:(nullable NSTextContainer *)textContainer
                      characterIndex:(NSUInteger)charIndex {
    return nil;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    [NSException raise:NSInternalInconsistencyException
                format:@"GKSubviewTextAttachment cannot be decoded."];
    return nil;
}

@end