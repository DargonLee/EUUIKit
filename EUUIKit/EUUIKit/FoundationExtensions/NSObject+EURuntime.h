//
//  NSObject+EURuntime.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/23.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (EURuntime)

/**
 交换两个方法实现
 
 @param originalMethod 原来的方法
 @param newMethod 新的方法实现
 */
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 往一个对象里面添加一个方法
 
 @param newMethod 要添加f的方法实现
 @param klass 添加的类
 */
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 替换某个对象的方法
 
 @param method 替换的方法
 @param klass 要替换的类
 */
+ (void)replaceMethod:(SEL)method fromClass:(Class)klass;

/**
 检查接收方是否实现或继承指定的方法, 直到和删除层次结构中的特定类。
 
 @param selector 方法的选择器
 @param stopClass 最后停止的父类
 @return YES
 */
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 检查父类是否能相应某个方法
 
 @param selector 方法的选择器
 @return YES
 */
- (BOOL)superRespondsToSelector:(SEL)selector;

/**
 检查父类是否实现或继承指定的方法。
 
 @param selector 方法的选择器.
 @param stopClass 最后停止的父类
 @return YES
 */
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 检查接收方的实例是否实现或继承了层次结构中的特定类的指定方法。
 
 @param selector 方法的选择器.
 @param stopClass 最后停止的父类
 @return YES
 */
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;

@end

@interface NSObject (EUReflection)

//类名
- (NSString *)className;
+ (NSString *)className;
//父类名称
- (NSString *)superClassName;
+ (NSString *)superClassName;

//实例属性字典
-(NSDictionary *)propertyDictionary;

//属性名称列表
- (NSArray*)propertyKeys;
+ (NSArray *)propertyKeys;

//属性详细信息列表
- (NSArray *)propertiesInfo;
+ (NSArray *)propertiesInfo;

//格式化后的属性列表
+ (NSArray *)propertiesWithCodeFormat;

//方法列表
- (NSArray*)methodList;
+ (NSArray*)methodList;

- (NSArray*)methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)registedClassList;
//实例变量
+ (NSArray *)instanceVariable;

//协议列表
- (NSDictionary *)protocolList;
+ (NSDictionary *)protocolList;


- (BOOL) hasPropertyForKey:(NSString*)key;
- (BOOL) hasIvarForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
