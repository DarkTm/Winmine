//
//  WYWinmineBtn.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineCell.h"

@interface WYWinmineCell()
{
    struct WinminValues _value;
}

-(UIColor *)getCorolWithNum:(unsigned int)num;

-(NSString *)getImageWithState:(struct WinminValues)aValue;

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

@end

@implementation WYWinmineCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{

//    [self setBgImage];
}

#pragma mark - Property Method -
-(WYWinmineCell *)initWithFrame:(CGRect)frame withValue:(struct WinminValues)aValue{

    self = [super initWithFrame:frame];

    [self setBackgroundColor:[UIColor colorWithRed:1.0 green:151.0/255 blue:0 alpha:1.0]];
    
    _value = aValue;
    
    return self;
}

-(void)setStateWithValues:(struct WinminValues)sValue{

    _value = sValue;
    [self setNeedsDisplay];
}

//-(void)setStateWithState:(WinmineState)aState{
//
//    _value.state = aState;
//    [self setNeedsDisplay];
//}

#pragma mark - Private Method -

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b{

    return [self colorWithRGB:r g:g b:b a:1.0];
}

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a{

    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
}

-(UIColor *)getCorolWithNum:(unsigned int)num{

    CGFloat r = 0.0,g = 0.0,b = 0.0,a = 1.0;
    
    r = g = b = (255.0 / 8.0) * num;
    
    switch (num) {
        case 0:

            break;
        case 1:
            ;
            break;
        case 2:
            ;
            break;
        case 3:
            ;
            break;
        case 4:
            ;
            break;
        case 5:
            ;
            break;
        case 6:
            ;
            break;
        case 7:
            ;
            break;
    }
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
}

-(NSString *)getImageWithState:(struct WinminValues)aValue{
    
    NSString *name = nil;

    switch (aValue.state) {
        case WinmineNormal:
            name = @"normal_0.png";
            break;
        case WinmineMark:
            name = @"flag_0.png";
            break;
        case WinmineOpened:{
        
            if(aValue.openState == WinmineOpenNum){
                name = [NSString stringWithFormat:@"style_0_%d.png",_value.value];
            }else if(aValue.openState == WinmineOpenEmpty){
                name = @"empty_0.png";
            }else if(aValue.openState == WinmineOpenMine){
                if(aValue.isError){
                    name = @"mine_0_faile.png";
                }else{
                    name = @"mine_0_normal.png";
                }
            }
            break;
        }
    }
    
//    if(aValue.openState == WinmineOpenNum){
//        name = [NSString stringWithFormat:@"%d",_value.value];
//    }else if(aValue.openState == WinmineOpenEmpty){
//        name = @"0";
//    }else if(aValue.openState == WinmineOpenMine){
//        name = @"9";
//    }
    
    return name;
}


- (void)drawRect:(CGRect)rect
{
    NSString *name = [self getImageWithState:_value];
//    DLog("%s",[name UTF8String]);
    UIImage *image = [UIImage imageNamed:name];
    
    [image drawInRect:rect ];
    
//    [name drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
}


@end
