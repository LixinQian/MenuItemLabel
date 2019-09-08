//
//  UILabel+LXMenuItem.h
//  MenuItem
//
//  Created by 钱立新 on 2019/9/7.
//  Copyright © 2019 钱立新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LXMenuItem)
/**
 是否可以长按 默认值NO，设置为YES时，表示可以长按弹出系统菜单。
 */
@property (nonatomic, assign) IBInspectable BOOL shouldLongPress;

/**
 自定义长按弹出的菜单列表
 
 @discussion 默认提供一个复制菜单。
 @warning shouldLongPress设置为YES时该属性才有意义
 */
@property (nonatomic, strong) NSMutableArray<UIMenuItem *> *menuList;

/**
 转发对象
 
 @discussion menuList中自定义了其他的MenuItem时，Item的action实现的所在对象
             即对应Item的点击事件的实现的所在对象
 @warning shouldLongPress设置为YES时该属性才有意义
 */
@property (nonatomic, weak) id forwardObject;

@end

NS_ASSUME_NONNULL_END
