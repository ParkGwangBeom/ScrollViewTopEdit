//
//  ViewController.m
//  MinMaxTest
//
//  Created by yellomobile on 2015. 2. 26..
//  Copyright (c) 2015년 yellomobile. All rights reserved.
//

#import "ViewController.h"
#define TOP @"1111"



#define TOP_HEIGHT 120.0f
#define kDuration 0.3f
#define SELECT_COLOR            [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]
#define NON_SELECT_COLOR        [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f]

@interface ViewController ()<UIScrollViewDelegate>{
    
    __weak IBOutlet UIScrollView *scr_View;
    __weak IBOutlet UIView *v_top;
    __weak IBOutlet UIButton *btn_Home;
    
    
    //TopView
    __weak IBOutlet UIImageView *iv_Profile;
    __weak IBOutlet UILabel *lb_Title;
    __weak IBOutlet UILabel *lb_SubTitle;
    __weak IBOutlet UILabel *lb_HideTitle;
    __weak IBOutlet UIImageView *iv_ButtonImage;
    
    
    //Button
    __weak IBOutlet UILabel *lb_Story;
    __weak IBOutlet UILabel *lb_Read;
    __weak IBOutlet UILabel *lb_Reader;
    __weak IBOutlet UILabel *lb_StoryCnt;
    __weak IBOutlet UILabel *lb_ReadCnt;
    __weak IBOutlet UILabel *lb_ReaderCnt;
    
    
    NSInteger                           scrollDirection;
}
@property (nonatomic,assign) CGFloat lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lastContentOffset = 0.0f;
    scr_View.contentSize = CGSizeMake(self.view.frame.size.width, 1000.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    [UIView animateWithDuration:kDuration animations:^{
        iv_ButtonImage.frame = CGRectMake(btn.frame.origin.x,
                                          iv_ButtonImage.frame.origin.y,
                                          iv_ButtonImage.frame.size.width,
                                          iv_ButtonImage.frame.size.height);
    }completion:^(BOOL finish){
        
    }];
    
    switch (btn.tag) {
        case 1:
            lb_Story.textColor = SELECT_COLOR;
            lb_StoryCnt.textColor = SELECT_COLOR;
            lb_Read.textColor = NON_SELECT_COLOR;
            lb_ReadCnt.textColor = NON_SELECT_COLOR;
            lb_Reader.textColor = NON_SELECT_COLOR;
            lb_ReaderCnt.textColor = NON_SELECT_COLOR;
            break;
        case 2:
            lb_Story.textColor = NON_SELECT_COLOR;
            lb_StoryCnt.textColor = NON_SELECT_COLOR;
            lb_Read.textColor = SELECT_COLOR;
            lb_ReadCnt.textColor = SELECT_COLOR;
            lb_Reader.textColor = NON_SELECT_COLOR;
            lb_ReaderCnt.textColor = NON_SELECT_COLOR;
            break;
        default:
            lb_Story.textColor = NON_SELECT_COLOR;
            lb_StoryCnt.textColor = NON_SELECT_COLOR;
            lb_Read.textColor = NON_SELECT_COLOR;
            lb_ReadCnt.textColor = NON_SELECT_COLOR;
            lb_Reader.textColor = SELECT_COLOR;
            lb_ReaderCnt.textColor = SELECT_COLOR;
            break;
    }
}

-(void)ShowHomeButton{
    [UIView animateWithDuration:kDuration animations:^{
        btn_Home.frame = CGRectMake(btn_Home.frame.origin.x,
                                    480.0f,
                                    btn_Home.frame.size.width,
                                    btn_Home.frame.size.height);
    }completion:^(BOOL finish){
        
    }];
}

-(void)HideButton{
    CGRect rect = [self.view bounds];
    float i_Screen_H = rect.size.height;
    
    [UIView animateWithDuration:kDuration animations:^{
        btn_Home.frame = CGRectMake(btn_Home.frame.origin.x,
                                    i_Screen_H,
                                    btn_Home.frame.size.width,
                                    btn_Home.frame.size.height);
    }completion:^(BOOL finish){
        
    }];
}

//Mypage 적용할 Effect
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float f_alpha = (TOP_HEIGHT - scrollView.contentOffset.y) / TOP_HEIGHT;
    
    iv_Profile.alpha = f_alpha;
    lb_SubTitle.alpha = f_alpha;
    lb_Title.alpha = f_alpha;
    
    if (scrollView.contentOffset.y > TOP_HEIGHT) {
        v_top.frame = CGRectMake(v_top.frame.origin.x, scrollView.contentOffset.y - TOP_HEIGHT, 320, 270);
        
        lb_HideTitle.hidden = NO;
    }
    else if(scrollView.contentOffset.y > 0){
        float y = MIN(scrollView.contentOffset.y, 0);
        v_top.frame = CGRectMake(v_top.frame.origin.x, y, 320, 270);
        
        lb_HideTitle.hidden = YES;
    }
    
    if (self.lastContentOffset < scrollView.contentOffset.y){
        scrollDirection = ScrollDirectionUp;
        
        if(scrollDirection == ScrollDirectionUp) {
            [self HideButton];
        }
    }
    else if (self.lastContentOffset > scrollView.contentOffset.y){
        scrollDirection = ScrollDirectionDown;
        
        if(scrollDirection == ScrollDirectionDown) {
            [self ShowHomeButton];
        }
    }
    
    if(scrollView.contentOffset.y > 0)
        self.lastContentOffset = scrollView.contentOffset.y;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self ShowHomeButton];
}

//피키캐스트 Top Banner Effect
/*
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 v_top.frame = CGRectMake(v_top.frame.origin.x, scrollView.contentOffset.y/2, 600, 200);
 }
 */


@end
