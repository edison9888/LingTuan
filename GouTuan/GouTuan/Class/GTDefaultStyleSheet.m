//
//  GTDefaultStyleSheet.m
//  GouTuan
//
//  Created by  on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GTDefaultStyleSheet.h"

@implementation GTDefaultStyleSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)navigationBarTintColor {
    return [UIColor blackColor];
}

- (UIColor*)toolbarTintColor {
    return [UIColor blackColor];
}

- (UIColor*)tabTintColor {
    return [UIColor redColor];
}

- (UIColor*)tabBarTintColor {
    return [UIColor redColor];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)wallButton:(UIControlState)state {
    return
    [self toolbarButtonForState:state
                          shape:[TTRoundedRectangleShape shapeWithRadius:4.5]
                      tintColor:TTSTYLEVAR(tablePlainBackgroundColor)
                           font:nil];
}

- (TTStyle*)remoteButton:(UIControlState)state {
    if (state == UIControlStateHighlighted) {
        return [TTImageStyle styleWithImageURL:nil
                                  defaultImage:TTIMAGE(@"bundle://default_product_detail.png")
                                   contentMode:UIViewContentModeCenter
                                          size:CGSizeMake(200, 120)
                                          next:[TTSolidBorderStyle styleWithColor:RGBACOLOR(0,0,0,0.2) width:1 next:
                                                [TTSolidFillStyle styleWithColor:RGBACOLOR(0,0,0,0.5) next:nil]]];

    } else {
        return [TTImageStyle styleWithImageURL:nil
                                  defaultImage:TTIMAGE(@"bundle://default_product_detail.png")
                                   contentMode:UIViewContentModeCenter
                                          size:CGSizeMake(200, 120)
                                          next:[TTSolidBorderStyle styleWithColor:RGBACOLOR(0,0,0,0.2) width:1 next:nil]];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)rounded{
    return
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
     [TTSolidBorderStyle styleWithColor:RGBACOLOR(0,0,0,0.2) width:1 next:[TTContentStyle styleWithNext:nil]]];
}
@end
