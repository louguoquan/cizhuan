//
//  NSDictionary+Sunday.h
//  SundayFramework
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Sunday)

#pragma mark - Dictionary Convertor
///=============================================================================
/// @name Dictionary Convertor
///=============================================================================

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSDictionary *)dictionaryWithPlistData:(NSData * _Nonnull)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (nullable NSDictionary *)dictionaryWithPlistString:(NSString * _Nonnull)plist;

/**
 Serialize the dictionary to a binary property list data.
 
 @return A binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
- (nullable NSData *)plistData;

/**
 Serialize the dictionary to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)plistString;

/**
 Returns a new array containing the dictionary's keys sorted.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's keys,
 or an empty array if the dictionary has no entries.
 */
- (nullable NSArray *)allKeysSorted;

/**
 Returns a new array containing the dictionary's values sorted by keys.
 
 The order of the values in the array is defined by keys.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's values sorted by keys,
 or an empty array if the dictionary has no entries.
 */
- (nullable NSArray *)allValuesSortedByKeys;

/**
 Returns a BOOL value tells if the dictionary has an object for key.
 
 @param key The key.
 */
- (BOOL)containsObjectForKey:(id _Nonnull)key;

/**
 Returns a new dictionary containing the entries for keys.
 If the keys is empty or nil, it just returns an empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (nullable NSDictionary *)entriesForKeys:(NSArray * _Nonnull)keys;

/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (nullable NSString *)jsonStringEncoded;

/**
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)jsonPrettyStringEncoded;

/**
 Try to parse an XML and wrap it into a dictionary.
 If you just want to get some value from a small xml, try this.
 
 example XML: "<config><a href="test.com">link</a></config>"
 example Return: @{@"_name":@"config", @"a":{@"_text":@"link",@"href":@"test.com"}}
 
 @param xmlDataOrString XML in NSData or NSString format.
 @return Return a new dictionary, or nil if an error occurs.
 */
+ (nullable NSDictionary *)dictionaryWithXML:(id _Nonnull)xmlDataOrString;

#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================

- (BOOL)boolValueForKey:(NSString * _Nonnull)key default:(BOOL)def;

- (char)charValueForKey:(NSString * _Nonnull)key default:(char)def;
- (unsigned char)unsignedCharValueForKey:(NSString * _Nonnull)key default:(unsigned char)def;

- (short)shortValueForKey:(NSString * _Nonnull)key default:(short)def;
- (unsigned short)unsignedShortValueForKey:(NSString * _Nonnull)key default:(unsigned short)def;

- (int)intValueForKey:(NSString * _Nonnull)key default:(int)def;
- (unsigned int)unsignedIntValueForKey:(NSString * _Nonnull)key default:(unsigned int)def;

- (long)longValueForKey:(NSString * _Nonnull)key default:(long)def;
- (unsigned long)unsignedLongValueForKey:(NSString * _Nonnull)key default:(unsigned long)def;

- (long long)longLongValueForKey:(NSString * _Nonnull)key default:(long long)def;
- (unsigned long long)unsignedLongLongValueForKey:(NSString * _Nonnull)key default:(unsigned long long)def;

- (float)floatValueForKey:(NSString * _Nonnull)key default:(float)def;
- (double)doubleValueForKey:(NSString * _Nonnull)key default:(double)def;

- (NSInteger)integerValueForKey:(NSString * _Nonnull)key default:(NSInteger)def;
- (NSUInteger)unsignedIntegerValueForKey:(NSString * _Nonnull)key default:(NSUInteger)def;

- (nullable NSNumber *)numverValueForKey:(NSString * _Nonnull)key default:(nullable NSNumber *)def;
- (nullable NSString *)stringValueForKey:(NSString * _Nonnull)key default:(nullable NSString *)def;

@end



/**
 Provide some some common method for `NSMutableDictionary`.
 */
@interface NSMutableDictionary (Sunday)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistData:(NSData * _Nonnull)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistString:(NSString * _Nonnull)plist;


/**
 Removes and returns the value associated with a given key.
 
 @param aKey The key for which to return and remove the corresponding value.
 @return The value associated with aKey, or nil if no value is associated with aKey.
 */
- (nullable id)popObjectForKey:(id _Nonnull)aKey;

/**
 Returns a new dictionary containing the entries for keys, and remove these
 entries from receiver. If the keys is empty or nil, it just returns an
 empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (nullable NSDictionary *)popEntriesForKeys:(NSArray * _Nonnull)keys;

@end
