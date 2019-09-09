//
//  UILabel+LXMenuItem.m
//  MenuItem
//
//  Created by 钱立新 on 2019/9/7.
//  Copyright © 2019 钱立新. All rights reserved.
//

#import "UILabel+LXMenuItem.h"
#import <objc/runtime.h>

static const void *forwardObjectKey = &forwardObjectKey;
static const void *menuListKey = &menuListKey;
static const void *shouldLongPressKey = &shouldLongPressKey;
static const void *longPressGestureRecognizerKey = &longPressGestureRecognizerKey;

@interface UILabel ()
@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
@end

@implementation UILabel (LXMenuItem)

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return self.shouldLongPress;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // Only return YES for the copy: action AND the shouldLongPress property is YES.
    BOOL matching = NO;
    for (UIMenuItem *item in self.menuList) {
        if (item.action == action && self.shouldLongPress) {
            matching = YES;
            break;
        }
    }
    return matching;
}

#pragma mark - UI Actions

- (void) longPressGestureRecognized:(UIGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer == self.longPressGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self becomeFirstResponder];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuItemsHiden) name:UIMenuControllerWillHideMenuNotification object:nil];
            
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            copyMenu.menuItems = self.menuList.copy;
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = UIMenuControllerArrowDefault;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - Private Methods

- (void)menuItemsHiden {
    UIMenuController *copyMenu = [UIMenuController sharedMenuController];
    copyMenu.menuItems = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldLongPress {
    return [objc_getAssociatedObject(self, shouldLongPressKey) boolValue];
}

- (void)setShouldLongPress:(BOOL)shouldLongPress {
    if(self.shouldLongPress != shouldLongPress) {
        objc_setAssociatedObject(self, shouldLongPressKey, @(shouldLongPress), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setupGestureRecognizers];
    }
}

- (id)forwardObject {
    return objc_getAssociatedObject(self, forwardObjectKey);
}

- (void)setForwardObject:(id)forwardObject {
    if (![self.forwardObject isEqual:forwardObject]) {
        objc_setAssociatedObject(self, forwardObjectKey, forwardObject, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    return objc_getAssociatedObject(self, longPressGestureRecognizerKey);
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    objc_setAssociatedObject(self, longPressGestureRecognizerKey, longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<UIMenuItem *> *)menuList {
    NSMutableArray <UIMenuItem*> *list = objc_getAssociatedObject(self, menuListKey);
    if (!list) {
        UIMenuItem *textcopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(qyc_textcopy:)];
        list = @[textcopy].mutableCopy;
        objc_setAssociatedObject(self, menuListKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return list;
}

- (void)setMenuList:(NSMutableArray<UIMenuItem *> *)menuList {
    objc_setAssociatedObject(self, menuListKey, menuList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) setupGestureRecognizers {
    // Remove gesture recognizer
    if(self.longPressGestureRecognizer) {
        [self removeGestureRecognizer:self.longPressGestureRecognizer];
        self.longPressGestureRecognizer = nil;
    }
    
    if(self.shouldLongPress) {
        self.userInteractionEnabled = YES;
        // Enable gesture recognizer
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

- (void)qyc_textcopy:(id)sender {
    if (self.text) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.text];
    }
}

- (id)forwardingTargetForSelector:(SEL)sel {
    BOOL matching = NO;
    for (UIMenuItem *item in self.menuList) {
        if (item.action == sel) {
            matching = YES;
            break;
        }
    }
    if (matching) {
        return self.forwardObject;
    }
    return [super forwardingTargetForSelector:sel];
}


@end
