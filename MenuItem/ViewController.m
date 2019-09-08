//
//  ViewController.m
//  MenuItem
//
//  Created by 钱立新 on 2019/8/31.
//  Copyright © 2019 钱立新. All rights reserved.
//

#import "ViewController.h"
#import "LXMenuItemLabel.h"
#import "UILabel+LXMenuItem.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LXMenuItemLabel *redLabel;

@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (nonatomic, strong)  NSMutableArray *add;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"XX" action:@selector(qyc_labeMenuXX:)];
    [self.redLabel.menuList addObject:item1];
    self.redLabel.forwardObject = self;
    self.redLabel.shouldLongPress = YES;

    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"XX" action:@selector(qyc_labeMenuXX:)];
    [self.blueLabel.menuList addObject:item2];
    self.blueLabel.forwardObject = self;
    self.blueLabel.shouldLongPress = YES;
    
}

- (void)qyc_labeMenuXX:(id)sender {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:@"自定义菜单" preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [aler addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil ];
}

- (void)dealloc {
    NSLog(@"---------销毁了---------");
}
@end
