//
//  LXMenuItemLabel.h
//  MenuTest
//
//  Created by 启业云 on 2019/8/30.
//  Copyright © 2019 启业云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMenuItemLabel : UILabel

@property (nonatomic, assign) IBInspectable BOOL shouldLongPress;   ///< 是否可以长按;
@property (nonatomic, weak) id forwardObject;                       ///< 转发对象

/**
 自定义长按弹出的菜单列表
 
 @warning 默认提供一个复制菜单。
 */
@property (nonatomic, strong) NSMutableArray<UIMenuItem *> *menuList;
@end

NS_ASSUME_NONNULL_END
