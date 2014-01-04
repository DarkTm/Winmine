//
//  WYWinmineMap.m
//  Winmine
//
//  Created by tom on 14-1-1.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "WYWinmineMap.h"

#import "WYWinmineCell.h"

#define BTN_WIDE 44.0
#define BTN_HEIGHT 44.0


#define MAX_SIZE 256

#define BTN_TAG 10000


@interface WYWinmineMap()
-(BOOL)isFinish;

-(void)success;

-(void)faile;

-(void)emptyWithI:(int)i j:(int)j;

-(void)touchNum:(int)i j:(int)j;

-(void)animationWithTip:(WYWinmineCell *)cell withValue:(struct WinminValues)value;

-(void)animationWith:(WYWinmineCell *)cell withValue:(struct WinminValues)value;
@end

@implementation WYWinmineMap{

    struct WinminValues _dataArray[255][255];
    
    unsigned int _wide;
    unsigned int _height;
 
    unsigned int countMine;
    unsigned int countNum;
    
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
    
    
    [self setBackgroundColor:[UIColor colorWithRed:1.0 green:151.0/255 blue:0 alpha:1.0]];
    
    _transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self initDta:_wide height:_height];
    
    float sep = 0;
    
    for (int i = 0; i < _wide; i++) {
        for (int j = 0; j < _height; j++) {
            
            WYWinmineCell *btn = [[WYWinmineCell alloc] initWithFrame:CGRectMake(sep + j * (BTN_WIDE + sep), sep + i * (BTN_HEIGHT + sep), BTN_WIDE, BTN_HEIGHT) withValue:_dataArray[i][j]];
            btn.tag = BTN_TAG + i * MAX_SIZE + j;

//            btn.layer.borderWidth = 1.0f;
//            btn.layer.borderColor = [[UIColor blueColor] CGColor];
            
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

-(void)touchNum:(int)i j:(int)j{
//open 
    
}

-(void)animationWithTip:(WYWinmineCell *)cell withValue:(struct WinminValues)value{
//animation tip
}

-(void)animationWith:(WYWinmineCell *)cell withValue:(struct WinminValues)value{

    [cell.layer removeAnimationForKey:@"transform3D"];
    
    [CATransaction begin ];
    
    [CATransaction setCompletionBlock:^{
        [cell setStateWithValues:value];//渐显
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    animation.duration = .2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [cell.layer addAnimation:animation forKey:@"transform3D"];
    [animation setRemovedOnCompletion:YES];
    [CATransaction commit];
}

-(BOOL)isFinish{
    
    BOOL isEnd = NO;
    
    int mine = 0;
    int num = 0;
    for (int i = 0; i < _wide; i++) {
        
        for (int j = 0; j < _height; j++) {
            
            struct WinminValues value = _dataArray[i][j];
            
            if(value.state == WinmineOpenMine && value.state == WinmineMark)
                mine += 1;
            else if((value.openState == WinmineOpenEmpty || value.openState == WinmineOpenNum) && value.state == WinmineOpened){
                num += 1;
            }
        }
    }
    
//    printf("\n %d.%d",num,mine);
    if(mine == countMine) isEnd = YES;
    if(num == countNum) isEnd = YES;
    
    if(isEnd)
        [self success];
    else
        DLog("not finish");
    
    return isEnd;
}

-(void)success{
    DLog("success");
    self.isEnd = 1;
    for (int i = 0; i < _wide; i++) {
        for (int j = 0; j < _height; j++) {
            
            struct WinminValues value = _dataArray[i][j];
            
            if(value.state == WinmineNormal){//没有打开的就继续
                
                int tag = BTN_TAG + i * MAX_SIZE + j;
                
                value.state = WinmineOpened;
                
                _dataArray[i][j] = value;
                
                WYWinmineCell *b = (WYWinmineCell*)[self viewWithTag:tag];
                
                [self animationWith:b withValue:value];
            }
        }
    }
    
}

-(void)faile{
    DLog("faile");
            self.isEnd = 1;
    for (int i = 0; i < _wide; i++) {
        for (int j = 0; j < _height; j++) {
            
            struct WinminValues value = _dataArray[i][j];
            if(_dataArray[i][j].state == WinmineNormal){//没有打开的就继续

                value.state = WinmineOpened;
                _dataArray[i][j] = value;
                
                int tag = BTN_TAG + i * MAX_SIZE + j;
                
                WYWinmineCell *b = (WYWinmineCell*)[self viewWithTag:tag];
                
                [self animationWith:b withValue:value];
            }
        }
    }
}

#pragma mark - Action -

-(void)emptyWithI:(int)i j:(int)j{
    int m = i + 1;
    int n = j + 1;
    
    if(m>=_wide)
        m--;
    if(m>=_wide)
        m--;
    if(m>=_wide)
        m--;
        
    for(;m >= 0 && m < _wide && m > i - 2;m--){
        n = j + 1;
        
        if(n>=_height)
            n--;
        if(n>=_height)
            n--;
        if(n>=_height)
            n--;
        
        for(; n >= 0 && m < _height && m > j - 2; n--){
            
            struct WinminValues value = _dataArray[m][n];
            if(value.openState == WinmineOpenEmpty && value.state == WinmineNormal){
            
                value.state = WinmineOpened;
                _dataArray[m][n] = value;
                
                int tag = BTN_TAG + m * MAX_SIZE + n;
                
                WYWinmineCell *b = (WYWinmineCell*)[self viewWithTag:tag];
                
                [self animationWith:b withValue:value];
                
                [self emptyWithI:m j:n];
            }
        }
    }
}

-(void)on_singleTap:(UIGestureRecognizer *)g{

    UIView *v = g.view;
    if([v isKindOfClass:[WYWinmineCell class]]){
        
        WYWinmineCell *b = (WYWinmineCell *)v;
        
        unsigned int index = b.tag - BTN_TAG;
        int i = index / MAX_SIZE;
        int j = index % MAX_SIZE;
        
        struct WinminValues value = _dataArray[i][j];
     
        if(value.state == WinmineOpened){
            
            
            [self touchNum:i j:j];
            return;
        }
        
        value.state = WinmineOpened;
        
        _dataArray[i][j] = value;
        
        [self animationWith:b withValue:value];
        
        if(value.openState == WinmineOpenMine){
            
            value.isError = YES;
            _dataArray[i][j] = value;
            
            [self animationWith:b withValue:value];
            
            [self faile];
            return;
        }
        
        if(value.openState == WinmineOpenEmpty){
            //检查周围相连接的是否未空，如果为空，直接显示出来 递归
            [self emptyWithI:i j:j];
        }
        
        [self isFinish];
    }
    
}

//标记为雷
-(void)on_long:(UIGestureRecognizer *)g{
    
    if(g.state == UIGestureRecognizerStateBegan){
        
        UIView *v = g.view;
        if([v isKindOfClass:[WYWinmineCell class]]){
            
            WYWinmineCell *b = (WYWinmineCell *)v;
            
            unsigned int index = b.tag - BTN_TAG;
            int i = index / MAX_SIZE;
            int j = index % MAX_SIZE;
            
            struct WinminValues value = _dataArray[i][j];
            if(value.state == WinmineNormal){
                
                value.state = WinmineMark;
            }else if(value.state == WinmineMark){
                value.state = WinmineNormal;
            }else{
                return;
            }
            _dataArray[i][j] = value;
            
            [self animationWith:b withValue:value];
            
            [self isFinish];
        }
    }
}


//TODO:还需要增加控制雷的数量
-(void)initDta:(int)aWide height:(int)aHeight{
    
    NSAssert(aWide < MAX_SIZE && aHeight < MAX_SIZE, @"wide or height can not bigger MAX_SIZE!!!");
    
    int array1[aWide][aHeight],array2[aWide][aHeight];
    int i,j,m,n;
    srand((unsigned)time(NULL));
        
    countMine = 0;
    countNum = 0;
    
    //对array1赋值，1代表地雷，0代表无雷
    for(i=0;i<aWide;i++){
        for(j=0;j<aHeight;j++){
            int value = (int)((double)rand()/(double)RAND_MAX+0.5);
            
//            if(countMine == 10) value = 0;
            
            if(value == 0){
                countNum+=1;
            }else if(value == 1){
                countMine+=1;
            }
            
            
            
            array1[i][j]= value;
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
            
            if(_dataArray[i][j].value == 0)
                _dataArray[i][j].openState = WinmineOpenEmpty;
            else if(_dataArray[i][j].value == 9)
                _dataArray[i][j].openState = WinmineOpenMine;
            else
                 _dataArray[i][j].openState = WinmineOpenNum;
            if(j%aHeight==0 && i!=0)
                printf("\n");
            printf("%2d",array2[i][j]);
        }
    }
//    printf("\n %d.%d",countNum,countMine);
}

@end