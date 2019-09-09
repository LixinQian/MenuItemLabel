# MenuItemLabel
UILabel自定义长按弹出系统菜单

默认自带复制菜单，可以自定义其他菜单。
提供分类和子类两种不同实现。

![效果图](https://github.com/LixinQian/MenuItemLabel/blob/master/效果图.gif "效果图")
# 使用简介
1.shouldLongPress属性设置为YES，默认实现复制菜单
```
self.blueLabel.shouldLongPress = YES;
```
2.自定义其他菜单

如需要复制和XX两个菜单 需要设置menuList 属性和 forwardObject属性
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
