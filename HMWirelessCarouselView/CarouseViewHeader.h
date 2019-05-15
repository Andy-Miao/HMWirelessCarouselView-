//
//  CarouseViewHeader.h
//  HMWirelessCarouselView
//
//  Created by humiao on 2019/4/15.
//  Copyright © 2019年 humiao. All rights reserved.
//

#ifndef CarouseViewHeader_h
#define CarouseViewHeader_h

#define CURREENT_SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define CURREENT_SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

//#define FIT_HEIGHT(value)    ((value)/750.0f*CURREENT_SCREEN_HEIGHT)
#define FIT_HEIGHT(value)    ((value)/750.0f*CURREENT_SCREEN_WIDTH)
#define IPHONEX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define IPHONE4OR5  IPHONE4||IPHONE5

#pragma mark - 导航栏/状态栏的高度
#define NAV_STATE_HEIGHT    (IPHONEX ? 88 : 64)


#define COLOR_FROM_RGB(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* CarouseViewHeader_h */
