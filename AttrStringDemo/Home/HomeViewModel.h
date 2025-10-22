//
//  HomeViewModel.h
//  AttrStringDemo
//
//  Created by Gaurav Keshre on 22/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *iconName;

- (instancetype)initWithTitle:(NSString *)title 
                  description:(NSString *)description 
                    className:(NSString *)className 
                     iconName:(NSString *)iconName;

+ (NSArray<HomeViewModel *> *)defaultModels;

@end

NS_ASSUME_NONNULL_END
