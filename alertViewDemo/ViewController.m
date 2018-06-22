//
//  ViewController.m
//  alertViewDemo
//
//  Created by toro宇 on 2018/6/22.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "ViewController.h"
#import "ChildrenAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    [self.view addSubview:btn];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)showAlert
{
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@"那时候的我们，10块钱可以吃遍校园的一条街。她知道我喜欢粉红色，所有和粉红色沾边的礼物她都会特别上心。那时候的豪言壮志都在彼此的见证之下，一个一个实现。比如，期末的时候不仅是奖学金获得者，同时还有优秀三好生的称号。我们一起欢呼，我们一起庆祝，我们一起鼓励彼此要加油。那时候的我们，看到过彼此最为狼狈也最难过的时光，我明白她不言不语背后的那一份落寞，她也懂得我沉默不语背后的所有故事。那时候，我们都有一双爱笑的眼睛。那时候，我们对彼此的友情也一定真挚的不可替代。",@"人的自信到底从何而来？以及如何培养自己的自信？高度的自信，从高度的自律而来。自律又是什么？自律就是自己管理自己，自己约束自己。这是一个很重要的能力。先学会克制自己，用严格的日程表来控制生活，才能在这种自律中不断磨练出自信。自信也代表着对事情的控制能力，连最基本的时间都控制不了，谈何自信？", nil];
    ChildrenAlertView *alertView = [ChildrenAlertView childrenAlertView:ary];
    [self.view addSubview:alertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
