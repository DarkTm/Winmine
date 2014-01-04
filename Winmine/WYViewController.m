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
- (IBAction)start:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",(int)self.slider.value] forKey:@"size"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    WYWinmineController *winmine = [[WYWinmineController alloc] init];
    
    [self presentViewController:winmine animated:YES completion:NULL];
}
- (IBAction)drag:(id)sender {
    UISlider *s =(UISlider *)sender;
    self.num.text = [NSString stringWithFormat:@"%d",(int)s.value];
    DLog("%d",(int)s.value);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNum:nil];
    [self setSlider:nil];
    [super viewDidUnload];
}
@end
