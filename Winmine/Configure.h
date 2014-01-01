//
//  Configure.h
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#ifndef Winmine_Configure_h
#define Winmine_Configure_h

typedef NS_OPTIONS(unsigned int, WinmineState) {
    
    WinmineNormal = 0,
    WinmineOpened = 1,
    WinmineMark = 99
};


typedef NS_OPTIONS(unsigned int, WinmineOpenState) {
    
    WinmineOpenEmpty = 0,
    WinmineOpenNum = 1,
    WinmineOpenMine = 99
};



struct WinminValues{
    
    unsigned int value;
    WinmineState state;
    WinmineOpenState openState;
};

#endif
