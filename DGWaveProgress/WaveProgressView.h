//
//  WaveProgressView.h
//  DGWaveProgress
//
//  Created by dzc on 2021/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaveProgressView : UIView

@property (nonatomic,assign)CGFloat percen;

@property (nonatomic,strong)UILabel * percenlabel;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,assign)BOOL running;


- (void)start;

@end

NS_ASSUME_NONNULL_END
