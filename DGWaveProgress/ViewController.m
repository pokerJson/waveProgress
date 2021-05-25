//
//  ViewController.m
//  DGWaveProgress
//
//  Created by dzc on 2021/5/25.
//

#import "ViewController.h"
#import "WaveProgressView.h"


@interface ViewController ()

@property (nonatomic,strong)WaveProgressView * wave;

@property (nonatomic,strong)WaveProgressView * wave2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    WaveProgressView * wave = [[WaveProgressView alloc]initWithFrame:CGRectMake(0,80, [UIScreen mainScreen].bounds.size.width, 160)];
    self.wave = wave;
//    wave.percen = 0.5;
    [self.view addSubview:wave];
    wave.layer.masksToBounds = YES;
    [wave start];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 40, 300, 20)];
    slider.minimumValue = 0;// 设置最小值
    slider.maximumValue = 100;// 设置最大值
    slider.value = 0;// 设置初始值
    slider.continuous = YES;// 设置可连续变化
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [self.view addSubview:slider];
    
    WaveProgressView * wave2 = [[WaveProgressView alloc]initWithFrame:CGRectMake(30,400, 160, 160)];
    self.wave2 = wave2;
    wave2.percen = 0.4;
    wave2.running = YES;
    [self.view addSubview:wave2];
    wave2.layer.cornerRadius = 160/2.0;
    wave2.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    wave2.layer.borderWidth = 2;
    wave2.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
}

- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.wave.percen = slider.value/100.0;
}
@end
