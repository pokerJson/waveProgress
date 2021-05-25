//
//  WaveProgressView.m
//  DGWaveProgress
//
//  Created by dzc on 2021/5/25.
//

#import "WaveProgressView.h"

@interface WaveProgressView ()

@property (nonatomic,strong)NSTimer * myTimer;

@property (nonatomic,assign) CGRect MYframe;

@property (nonatomic,assign) CGFloat fa;

@property (nonatomic,assign) CGFloat bigNumber;

@end

@implementation WaveProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _MYframe = frame;
        self.backgroundColor = [UIColor whiteColor];
        UILabel * presentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        presentLabel.textAlignment = 1;
        [self addSubview:presentLabel];
        self.percenlabel = presentLabel;
        self.percenlabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return self;
}

- (void)createTimer{
    
    if (!self.myTimer) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(action) userInfo:nil repeats:YES];
    }
    [self.myTimer setFireDate:[NSDate distantPast]];
}
- (void)action{
    //让波浪移动效果
    _fa = _fa+10;
    if (_fa >= _MYframe.size.width * 2.0) {
        _fa = 0;
    }
    [self setNeedsDisplay];
}
- (void)start{
    _running = YES;
    [self createTimer];
}
- (void)drawRect:(CGRect)rect{
    
    if (!_running) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水1
    CGContextSetLineWidth(context, 1);
    UIColor * blue = [UIColor colorWithRed:0.6 green:0.1 blue:0.3 alpha:0.8];
    CGContextSetFillColorWithColor(context, [blue CGColor]);
    
    float y= (1 - self.percen) * rect.size.height;
    float y1= (1 - self.percen) * rect.size.height;
    
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=rect.size.width * 3.0;x++){
        //正弦函数
        y=  sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI ) *_bigNumber + (1 - self.percen) * rect.size.height ;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, rect.size.width , rect.size.height );
    CGPathAddLineToPoint(path, nil, 0, rect.size.height );
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
    CGMutablePathRef path1 = CGPathCreateMutable();

    //画水2
    CGContextSetLineWidth(context, 1);
    UIColor * blue1 = [UIColor colorWithRed:0.6 green:0.1 blue:0.3 alpha:0.8];
    CGContextSetFillColorWithColor(context, [blue1 CGColor]);
    
    CGPathMoveToPoint(path1, NULL, 0, y1);
    for(float x=0;x<=rect.size.width;x++){
        
        y1= sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI  +M_PI ) *_bigNumber + (1 - self.percen) * rect.size.height ;
        CGPathAddLineToPoint(path1, nil, x, y1);
    }
    
    CGPathAddLineToPoint(path1, nil, rect.size.width, rect.size.height );
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height );
    
    CGContextAddPath(context, path1);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path1);
    
    
    //添加文字
    NSString *str = [NSString stringWithFormat:@"%.2f%%",self.percen * 100.0];
    self.percenlabel.text = str;
    
}


- (void)setPercen:(CGFloat)percen{
    _percen = percen;
    //启动定时器
    [self createTimer];
    //修改波浪的幅度
    if (percen <= 0.5) {
        _bigNumber = _MYframe.size.height * 0.1 * percen * 2;
    }else{
        _bigNumber = _MYframe.size.height * 0.1 * (1 - percen) * 2;
    }
}

@end
