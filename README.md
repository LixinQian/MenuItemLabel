# MenuItemLabel
UILabel自定义长按弹出系统菜单

默认自带复制菜单，可以自定义其他菜单。
提供分类和子类两种不同实现。

# 使用简介
```
UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"XX" action:@selector(qyc_labeMenuXX:)];
[self.blueLabel.menuList addObject:item2];
self.blueLabel.forwardObject = self;
self.blueLabel.shouldLongPress = YES;

- (void)qyc_labeMenuXX:(id)sender {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:@"自定义菜单" preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [aler addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil ];
}

```
