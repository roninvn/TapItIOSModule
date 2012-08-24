#import <Foundation/Foundation.h>


@interface NSDictionary (QueryStringBuilder)

- (NSString *)queryString;
- (NSString *)queryStringWithAllowedKeys:(NSArray *)allowedKeys;

@end