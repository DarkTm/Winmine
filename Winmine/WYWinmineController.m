//
//  WYWinmineController.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineController.h"

#import "WYWinmineMap.h"

@interface WYWinmineController ()
{
    
    WYWinmineMap *_scrollView;
}
@end

@implementation WYWinmineController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    _scrollView = [[WYWinmineMap alloc] initWithWide:10 height:10];
    
    _scrollView.contentSize = CGSizeMake(49 * 10, 49 * 10);
    
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
