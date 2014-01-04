//
//  WYWinmineBtn.h
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYWinmineCell : UIView

-(WYWinmineCell *)initWithFrame:(CGRect)frame withValue:(struct WinminValues)aValue;

-(void)setStateWithValues:(struct WinminValues)sValue;
//-(void)setStateWithState:(WinmineState)aState;

@end
