//
//  OAViewController.m
//  TouchCircle
//
//  Created by admin on 14-8-3.
//  Copyright (c) 2014年 DigitalOcean. All rights reserved.
//

#import "OAViewController.h"
#import "OAPageView.h"

CGFloat const ERASE_RADIUS = 30.0;

@interface OAViewController ()
{
    UISegmentedControl *_methodsChoose;
    UIView *_circleView;
    OAPageView *_pageView;
}
@end

@implementation OAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _methodsChoose = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Add Circle UIView",@"Draw Circle Path", nil]];
    _methodsChoose.frame = CGRectMake(0, 50, 300, 40);
    _methodsChoose.center = CGPointMake(self.view.frame.size.width * 0.5, 70);
    [_methodsChoose addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
    [self.view addSubview:_methodsChoose];
    _methodsChoose.selectedSegmentIndex = 0;
    
    // Method 1. circleView create a circle View;
    _circleView = [self createCircleView];
    [self.view addSubview:_circleView];
    
    // Method 2. OAPageView draw Circle; 默认显示方法二
    _pageView = [[OAPageView alloc] initWithFrame:self.view.bounds];
    _pageView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:_pageView belowSubview:_methodsChoose];
    _pageView.hidden = YES;// hiddened
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(110, 110, 200, 40)];
    label.text = @" Touch : Draw circle path";
    label.center = _pageView.center;
    [_pageView addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//具体委托方法实例

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"index:%d",Index);
    switch (Index) {
        case 0:
            _pageView.hidden = YES;
            break;
        case 1:
            _pageView.hidden = NO;
            break;
        default:
            break;
    }
    
}

- (UIView *)createCircleView
{
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(50, 50, ERASE_RADIUS*2, ERASE_RADIUS*2)];
    temp.backgroundColor = [UIColor clearColor];
    temp.hidden = YES;
    temp.layer.borderColor = [[UIColor blackColor] CGColor];
    temp.layer.cornerRadius = ERASE_RADIUS;
    temp.layer.borderWidth = 1.0;
    return temp;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint lastPoint = [touch locationInView:self.view];
    _circleView.center = CGPointMake(lastPoint.x, lastPoint.y);
    _circleView.hidden = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint lastPoint = [touch locationInView:self.view];
    _circleView.center = CGPointMake(lastPoint.x, lastPoint.y);
    _circleView.hidden = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _circleView.hidden = YES;
}


@end
