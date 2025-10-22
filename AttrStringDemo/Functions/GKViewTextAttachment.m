//
//  GKViewTextAttachment.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 23/10/25.
//

#import "GKViewTextAttachment.h"

@implementation GKViewTextAttachment

- (UIImage *)image {
    // Return a rendered image of the view for text layout, while keeping the actual view for interactivity
    if (self.customView) {
        // Render the actual view to an image for display in the text
        UIGraphicsBeginImageContextWithOptions(self.customView.bounds.size, NO, 0.0);
        [self.customView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return renderedImage;
    }
    return nil;
}

@end