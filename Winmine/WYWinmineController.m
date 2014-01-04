//
//  WYWinmineController.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineController.h"

#import "WYWinmineMap.h"

@interface WYWinmineController ()<UIScrollViewDelegate>
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

    int size = [[[NSUserDefaults standardUserDefaults] valueForKey:@"size"] integerValue];
    
    _scrollView = [[WYWinmineMap alloc] initWithWide:size height:size];

    _scrollView.contentSize = CGSizeMake(44 * size, 44 * size);
        
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(on_pinTap:)];
    [self.view addGestureRecognizer:pin];
    
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *t=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(on_tap)];
    t.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:t];
}
-(void)on_tap{
    if(_scrollView.isEnd)
        [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)on_pinTap:(UIPinchGestureRecognizer *)g{
    return;
    
    if(g.scale > 2.0 || g.scale < .5) return;
    DLog("%.2f",g.scale);
    CGPoint center = _scrollView.center;
    
    _scrollView.transform = CGAffineTransformMakeScale(g.scale, g.scale);
    CGSize size = _scrollView.contentSize;
    _scrollView.contentSize = CGSizeMake(size.width * g.scale, size.height *g.scale);
    
    CGRect fram = _scrollView.frame;
    
    _scrollView.frame = CGRectMake(0, 0, fram.size.width * g.scale, fram.size.height * g.scale);
    
    _scrollView.center = center;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
}

#pragma mark - UIScrollViewDelegate

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return _scrollView;
//}
////当滑动结束时
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
//{
//    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
//    [_scrollView setZoomScale:scale animated:NO];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
