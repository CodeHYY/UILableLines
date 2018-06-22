//
//  ChildrenAlertView.m
//  alertViewDemo
//
//  Created by toro宇 on 2018/6/22.
//  Copyright © 2018年 CodeYu. All rights reserved.
//


#import "ChildrenAlertView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"


@interface ChildrenAlertView()
@property (nonatomic, strong)NSMutableArray *childrenData;
@property (nonatomic, weak)UIButton *arrowBtn;
@property (nonatomic, weak)UIButton *selectedChildrenBtn;
@property (nonatomic, weak) UILabel *strLab;
@end

@implementation ChildrenAlertView

+(ChildrenAlertView *)childrenAlertView:(NSMutableArray *)childrenData
{
    ChildrenAlertView *alertView = [[ChildrenAlertView alloc] initWithData:childrenData];
    return alertView;
}
-(instancetype)initWithData:(NSMutableArray *)childrenData
{
    self = [super init];
    if (self) {
        self.childrenData = childrenData;
        [self initCustomUI];
    }
    return self;
}


-(void)initCustomUI
{
    
    __weak typeof(self) weakSelf = self;
    //arrowBtn
    
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:arrowBtn];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15);
        make.top.equalTo(weakSelf).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    _arrowBtn = arrowBtn;
    [arrowBtn addTarget:self action:@selector(arrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [arrowBtn setImage:[UIImage imageNamed:@"angleup"] forState:UIControlStateNormal];
    [arrowBtn setImage:[UIImage imageNamed:@"angledown"] forState:UIControlStateSelected];

    // lab
    
    UILabel *titleLab = [[UILabel alloc] init];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.arrowBtn.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.arrowBtn);
    }];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = @"[今日宝宝变化]";
    titleLab.textColor = [UIColor colorWithHex:@"#4ccfac"];
    
    // 宝宝头像
    for (int i = 0; i < self.childrenData.count ;  i++) {
        UIButton *childrenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:childrenBtn];
        [childrenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.arrowBtn);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.equalTo(weakSelf).offset(-(15 + i * (30 + 15)));
        }];
        childrenBtn.backgroundColor = [UIColor greenColor];
        childrenBtn.layer.masksToBounds = YES;
        childrenBtn.layer.cornerRadius = 30 * 0.5;
        [childrenBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar%d",i]] forState:UIControlStateNormal];
        childrenBtn.tag = 1000 + i;
        [childrenBtn addTarget:self action:@selector(childrenAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 宝宝简介
    UILabel *instrLab = [[UILabel alloc] init];
    [self addSubview:instrLab];
    [instrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(60);
        make.right.equalTo(weakSelf).offset(-30);
        make.left.equalTo(weakSelf).offset(30);
        make.bottom.equalTo(weakSelf).offset(-30);
    }];
    _strLab = instrLab;
    instrLab.textColor = [UIColor colorWithHex:@"#6f6f6f"];
    instrLab.font = [UIFont systemFontOfSize:15];
    
}

-(void)didMoveToSuperview
{
    self.layer.borderWidth = 0.4;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    // 初始化布局UI
    _selectedChildrenBtn = (UIButton *)[self viewWithTag:1000];
    _selectedChildrenBtn.selected = YES;
    
    _strLab.text = self.childrenData[0];
    _strLab.numberOfLines = 2;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview);
        make.right.equalTo(self.superview);
        make.bottom.equalTo(self.superview).offset(0);
        make.height.equalTo(@140);
    }];
}

#pragma mark - Action
-(void)childrenAction:(UIButton *)childrenBtn
{
    if (childrenBtn == _selectedChildrenBtn)  return;
    _selectedChildrenBtn.selected = NO;
    childrenBtn.selected = YES;
    _selectedChildrenBtn = childrenBtn;
    
    //
    _strLab.text = self.childrenData[_selectedChildrenBtn.tag -1000];
    
    if (_arrowBtn.selected) {
     // 更新view 布局
        [self refreshLayout];
    }
}

- (void)arrowBtn:(UIButton *)Btn
{
    _arrowBtn.selected = !Btn.selected;
    [self refreshLayout];
}

- (void)refreshLayout
{
    // 儿童简介
    CGFloat viewHeight;
    
    if (_arrowBtn.selected) {
        _strLab.numberOfLines = 0;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
         CGSize textSize = [_strLab.text boundingRectWithSize:CGSizeMake(_strLab.bounds.size.width, MAXFLOAT) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil].size;
        viewHeight =  textSize.height + 60 + 30 + 1;
    }else
    {
        _strLab.numberOfLines = 2;
        viewHeight = 140;
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(viewHeight));
    }];
    [self setNeedsLayout];
    
    
}

@end
