//
//  WYWinmineMap.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineMap.h"

#import "WYWinmineBtn.h"

#define BTN_WIDE 44.0
#define BTN_HEIGHT 44.0

#define BTN_TAG 10000


@interface WYWinmineMap()

-(BOOL)isFinish;
-(void)success;
-(void)faile;
@end

@implementation WYWinmineMap{

    struct WinminValues _dataArray[255][255];
    
    unsigned int _wide;
    unsigned int _height;
 
    CGAffineTransform _transform;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(WYWinmineMap *)initWithWide:(unsigned int)aWide height:(unsigned int)aHeight{
    
    _wide = aWide;
    _height = aHeight;
    
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(on_doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTap];
    
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self initDta:_wide height:_height];
    
    self.minimumZoomScale = 0.5;
    self.maximumZoomScale = 2.0;
    
    for (int i = 0; i < _wide; i++) {
        for (int j = 0; j < _height; j++) {
            
            WYWinmineBtn *btn = [[WYWinmineBtn alloc] initWithFrame:CGRectMake(j * (BTN_WIDE + 5), i * (BTN_HEIGHT + 5), BTN_WIDE, BTN_HEIGHT) withValue:_dataArray[i][j]];
            btn.tag = BTN_TAG + i * _wide + j;
            
            btn.layer.borderWidth = 1.0f;
            btn.layer.borderColor = [[UIColor blueColor] CGColor];

            
            UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(on_long:)];
            [btn addGestureRecognizer:longGes];
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(on_singleTap:)];
            singleTap.numberOfTapsRequired = 1;
            singleTap.numberOfTouchesRequired = 1;
            [btn addGestureRecognizer:singleTap];
            
            [self addSubview:btn];
        }
    }
}

#pragma mark - Private Method -

-(BOOL)isFinish{
    return NO;
}
-(void)success{
    DLog("success");
}
-(void)faile{
    DLog("faile");
}

#pragma mark - Action -

-(void)on_doubleTap:(UIGestureRecognizer *)g{

    DLog("on_doubleTap");
}

-(void)on_singleTap:(UIGestureRecognizer *)g{

    UIView *v = g.view;
    if([v isKindOfClass:[WYWinmineBtn class]]){
        
        WYWinmineBtn *b = (WYWinmineBtn *)v;
        
        unsigned int index = b.tag - BTN_TAG;
        int i = index / _wide;
        int j = index % _height;
        
        struct WinminValues value = _dataArray[i][j];
     
        if(value.state == WinmineOpened) return;
        
        value.state = WinmineOpened;
        
        _dataArray[i][j] = value;
        
//        可以做个动画
        
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            b.alpha = 0;
        } completion:^(BOOL finished) {
            [b setStateWithValues:value];
            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                b.alpha = 1;
            } completion:NULL];
        }];
        
        
        
        
        
        if(value.openState == WinmineOpenMine){
            [self faile];
            return;
        }
        
        if(value.openState == WinmineOpenEmpty){
            //检查周围相连接的是否未空，如果为空，直接显示出来 递归
        }
        
        [self isFinish];
    }
    
}

//标记为雷
-(void)on_long:(UIGestureRecognizer *)g{
    
    if(g.state == UIGestureRecognizerStateBegan){
        
        UIView *v = g.view;
        if([v isKindOfClass:[WYWinmineBtn class]]){
            
            WYWinmineBtn *b = (WYWinmineBtn *)v;
            
            unsigned int index = b.tag - BTN_TAG;
            int i = index / _wide;
            int j = index % _height;
            
            struct WinminValues value = _dataArray[i][j];
            if(value.state == WinmineNormal){
                
                value.state = WinmineMark;
            }else if(value.state == WinmineMark){
                value.state = WinmineNormal;
            }else{
                return;
            }
            _dataArray[i][j] = value;
//            可以做个动画
            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                b.alpha = 0;
            } completion:^(BOOL finished) {
                [b setStateWithValues:value];
                [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    b.alpha = 1;
                } completion:NULL];
            }];
            
            [self isFinish];
        }
    }
}

//TODO:还需要增加控制雷的数量
-(void)initDta:(int)aWide height:(int)aHeight{
    
    NSAssert(aWide < 255 && aHeight < 255, @"wide or height can not bigger 255!!!");
    
    int array1[aWide][aHeight],array2[aWide][aHeight];
    int i,j,m,n;
    srand((unsigned)time(NULL));
    //对array1赋值，1代表地雷，0代表无雷
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            array1[i][j]=(int)((double)rand()/(double)RAND_MAX+0.5);
        }
    }
    
    //将地雷标记为9
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            
            if(array1[i][j]==1)
                array1[i][j]=9;
        }
    }
    //初始化array2,全部赋值0
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            array2[i][j]=0;
        }
    }
    //计算每一格周围8个格的地雷数目
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            if(array1[i][j]==0){
                if((i==0)&&(j==0)){//左上角
                    for(m = 0;m<2;m++){
                        for(n=0;n<2;n++){
                            if(array1[i+1][j+1]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i==aWide-1)&&(j==aHeight-1)){//右下角
                    for(m=0;m<2;m++){
                        for(n=0;n<2;n++){
                            if(array1[i-1+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i==0)&&(j==aHeight-1)){//右上角
                    for(m=0;m<2;m++){
                        for(n=0;n<2;n++){
                            if(array1[i+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i==aWide-1)&&(j==0)){//左下角
                    for(m=0;m<2;m++){
                        for(n=0;n<2;n++){
                            if(array1[i-1+m][j+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i>0)&&(i<aWide-1)&&(j==0)){//左边
                    for(m=0;m<3;m++){
                        for(n=0;n<2;n++){
                            if(array1[i-1+m][j+n])
                                array2[i][j]++;
                        }
                    }
                }else if((i==0)&&(j>0)&&(j<aHeight-1)){//上边
                    for(m=0;m<2;m++){
                        for(n=0;n<3;n++){
                            if(array1[i+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i==aWide-1)&&(j>0)&&(j<aHeight-1)){//下边
                    for(m=0;m<2;m++){
                        for(n=0;n<3;n++){
                            if(array1[i-1+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i>0)&&(i<aWide-1)&&(j==aHeight-1)){//右边
                    for(m=0;m<3;m++){
                        for(n=0;n<2;n++){
                            if(array1[i-1+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }else if((i>0)&&(i<aWide-1)&&(j>0)&&(j<aHeight-1)){//非边界区域
                    for(m=0;m<3;m++){
                        for(n=0;n<3;n++){
                            if(array1[i-1+m][j-1+n]==9)
                                array2[i][j]++;
                        }
                    }
                }
            }else{
                array2[i][j]=9;
            }
        }
    }
    //打印地雷图
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            
            _dataArray[i][j].value = array2[i][j];
            _dataArray[i][j].state = WinmineNormal;
            
            if(_dataArray[i][i].value == 0)
                _dataArray[i][i].openState = WinmineOpenEmpty;
            else if(_dataArray[i][i].value == 9)
                _dataArray[i][i].openState = WinmineOpenMine;
            else
                 _dataArray[i][i].openState = WinmineOpenNum;
            
//            if(j%aHeight==0 && i!=0)
//                printf("\n");
//            printf("%2d",array2[i][j]);
        }
    }
    
}

@end