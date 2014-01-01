//
//  WYWinmineMap.h
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYWinmineMap : UIScrollView<UIGestureRecognizerDelegate>

-(WYWinmineMap *)initWithWide:(unsigned int)aWide height:(unsigned int)aHeight;

//-(void)initDta:(int)aWide height:(int)aHeight;

@end
