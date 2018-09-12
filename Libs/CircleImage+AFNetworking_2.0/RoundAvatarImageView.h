//
//  RoundAvatarImageView.h
//  ImageDL
//
//  Created by Pierre Abi-aad on 21/03/2014.
//  Copyright (c) 2014 Pierre Abi-aad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoundAvatarImageViewDelegate <NSObject>
@optional
- (void)RoundAvatarImageViewDidTapped:(id)view;
@end

@interface RoundAvatarImageView : UIView

@property (nonatomic, weak) id<RoundAvatarImageViewDelegate> delegate;

@property (nonatomic, assign, getter = isCacheEnabled) BOOL cacheEnabled;
@property (nonatomic, strong) UIImage *placeHolderImage;
@property (nonatomic, strong, readonly) UIImageView *containerImageView;

@property (nonatomic, strong) UIColor *backgroundProgresscolor;
@property (nonatomic, strong) UIColor *progressColor;

- (id)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor progressColor:(UIColor *)progressColor;
- (void)setImageURL:(NSURL *)URL;
- (void)setImageURL:(NSURL *)URL completion:(void (^)(NSError *error))completionBlock;
- (void)setImage:(UIImage *)image;

- (void)setBackgroundWidth:(CGFloat)width;

//Vishal Custom
- (void)updateWithImage:(UIImage *)image animated:(BOOL)animated;
- (void)vishal_updateWithImage:(UIImage *)image animated:(BOOL)animated;

@end
