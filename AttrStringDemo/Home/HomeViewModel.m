//
//  HomeViewModel.m
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)initWithTitle:(NSString *)title 
                  description:(NSString *)description 
                    className:(NSString *)className 
                     iconName:(NSString *)iconName {
    self = [super init];
    if (self) {
        _title = title;
        _descriptionText = description;
        _className = className;
        _iconName = iconName;
    }
    return self;
}

+ (NSArray<HomeViewModel *> *)defaultModels {
    return @[
        [[HomeViewModel alloc] initWithTitle:@"Plain Text"
                                 description:@"Display simple plain text using NSAttributedString"
                                   className:@"PlainTextViewController"
                                    iconName:@"text.alignleft"],
        
        [[HomeViewModel alloc] initWithTitle:@"Partially Formatted Text"
                                 description:@"Mix of bold, italic, and colored text within a single string"
                                   className:@"PartiallyFormattedViewController"
                                    iconName:@"textformat"],
        
        [[HomeViewModel alloc] initWithTitle:@"Text with Links"
                                 description:@"Clickable links embedded within attributed text"
                                   className:@"TextWithLinksViewController"
                                    iconName:@"link"],
        
        [[HomeViewModel alloc] initWithTitle:@"Text with Attachments"
                                 description:@"Images and custom views embedded using NSTextAttachment"
                                   className:@"TextWithAttachmentsViewController"
                                    iconName:@"photo.on.rectangle"],
        
        [[HomeViewModel alloc] initWithTitle:@"Styled Paragraphs"
                                 description:@"Different paragraph styles, spacing, and alignment"
                                   className:@"StyledParagraphsViewController"
                                    iconName:@"text.aligncenter"],
        
        [[HomeViewModel alloc] initWithTitle:@"Custom Fonts & Colors"
                                 description:@"Various font families, sizes, and text colors"
                                   className:@"CustomFontsViewController"
                                    iconName:@"textformat.size"],
        
        [[HomeViewModel alloc] initWithTitle:@"Underline & Strikethrough"
                                 description:@"Text decorations like underlines and strikethrough effects"
                                   className:@"TextDecorationsViewController"
                                    iconName:@"underline"],
        
        [[HomeViewModel alloc] initWithTitle:@"Shadow Effects"
                                 description:@"Drop shadows and text shadow effects"
                                   className:@"ShadowEffectsViewController"
                                    iconName:@"shadow"],
        
        [[HomeViewModel alloc] initWithTitle:@"Background Colors"
                                 description:@"Highlighted text with background colors"
                                   className:@"BackgroundColorsViewController"
                                    iconName:@"highlighter"],
        
        [[HomeViewModel alloc] initWithTitle:@"Advanced Formatting"
                                 description:@"Complex combinations of multiple text attributes"
                                   className:@"AdvancedFormattingViewController"
                                    iconName:@"wand.and.stars"]
    ];
}

@end
