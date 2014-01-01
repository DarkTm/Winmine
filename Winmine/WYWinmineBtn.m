//
//  WYWinmineBtn.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineBtn.h"

@interface WYWinmineBtn()
{
    struct WinminValues _value;
}

-(UIColor *)getCorolWithNum:(unsigned int)num;

-(NSString *)getImageWithState:(struct WinminValues)aValue;

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

-(UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

@end

@implementation WYWinmineBtn

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
-(WYWinmineBtn *)initWithFrame:(CGRect)frame withValue:(struct WinminValues)aValue{

    self = [super initWithFrame:frame];

    [self setBackgroundColor:[UIColor whiteColor]];
    
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
            name = @"Normal";
            break;
        case WinmineMark:
            name = @"Mark";
            break;
        case WinmineOpened:{
        
            if(aValue.openState == WinmineOpenNum){
                name = [NSString stringWithFormat:@"%d",_value.value];
            }else if(aValue.openState == WinmineOpenEmpty){
                name = @"Empty";
            }else if(aValue.openState == WinmineOpenMine){
                name = @"Mine";
            }
            break;
        }
    }

    return name;
}


- (void)drawRect:(CGRect)rect
{

    NSString *name = [self getImageWithState:_value];
    if(name)
        [name drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
    else
        [@"NULL" drawInRect:rect withFont:[UIFont systemFontOfSize:12]];
}


@end
