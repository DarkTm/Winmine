//
//  WYViewController.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYViewController.h"

#import "WYWinmineController.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    WYWinmineController *winmine = [[WYWinmineController alloc] init];

    [self presentViewController:winmine animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
