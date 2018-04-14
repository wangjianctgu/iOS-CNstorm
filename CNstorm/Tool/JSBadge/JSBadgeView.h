/*
Copyright (c) 2014 Xue Yingsong.
 
 Thanks to Javier Soto.
 Source: https://github.com/JaviSoto/JSBadgeView
 
 Keyworlds: BadgeView BadgeNumber Badge

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import <UIKit/UIKit.h>

//Compatible for ARC or NO ARC
#if __has_feature(objc_arc)
    #define SAFE_COPY copy
    #define SAFE_RETAIN strong
#else
    #define SAFE_COPY copy
    #define SAFE_RETAIN retain
#endif

typedef NS_ENUM(NSUInteger, JSBadgeViewAlignment)
{
    JSBadgeViewAlignmentTopLeft = 1,
    JSBadgeViewAlignmentTopRight,
    JSBadgeViewAlignmentTopCenter,
    JSBadgeViewAlignmentCenterLeft,
    JSBadgeViewAlignmentCenterRight,
    JSBadgeViewAlignmentBottomLeft,
    JSBadgeViewAlignmentBottomRight,
    JSBadgeViewAlignmentBottomCenter,
    JSBadgeViewAlignmentCenter,
    JSBadgeViewAlignmentOnCell
};

@interface JSBadgeView : UIView

@property (nonatomic, SAFE_COPY) NSString *badgeText;

#pragma mark - Customization

@property (nonatomic, assign) JSBadgeViewAlignment badgeAlignment UI_APPEARANCE_SELECTOR;

@property (nonatomic, SAFE_RETAIN) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize badgeTextShadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, SAFE_RETAIN) UIColor *badgeTextShadowColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, SAFE_RETAIN) UIFont *badgeTextFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, SAFE_RETAIN) UIColor *badgeBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the overlay circle at the top. Default is semi-transparent white.
 */
@property (nonatomic, SAFE_RETAIN) UIColor *badgeOverlayColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the badge shadow. Default is semi-transparent black.
 */
@property (nonatomic, SAFE_RETAIN) UIColor *badgeShadowColor UI_APPEARANCE_SELECTOR;

/**
 * Offset of the badge shadow. Default is 3.0 points down.
 */
@property (nonatomic, assign) CGSize badgeShadowSize UI_APPEARANCE_SELECTOR;

/**
 * Width of the circle around the badge. Default is 2.0 points.
 */
@property (nonatomic, assign) CGFloat badgeStrokeWidth UI_APPEARANCE_SELECTOR;

/**
 * Color of the circle around the badge. Default is white.
 */
@property (nonatomic, SAFE_RETAIN) UIColor *badgeStrokeColor UI_APPEARANCE_SELECTOR;

/**
 * Allows to shift the badge by x and y points.
 */
@property (nonatomic, assign) CGPoint badgePositionAdjustment UI_APPEARANCE_SELECTOR;

/**
 * You can use this to position the view if you're drawing it using drawRect instead of `-addSubview:`
 * (optional) If not provided, the superview frame is used.
 */
@property (nonatomic, assign) CGRect frameToPositionInRelationWith UI_APPEARANCE_SELECTOR;

/**
 * Optionally init using this method to have the badge automatically added to another view.
 */
- (id)initWithParentView:(UIView *)parentView alignment:(JSBadgeViewAlignment)alignment;

@end