/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse (0 custom class methods, 4 custom properties)

#import "GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse.h"

#import "GTLAlittlecloserWebAlittlecloserApiMessagesSearchMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse
//

@implementation GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse
@dynamic cursor, message, numOfResults, search;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"num_of_results"
                                forKey:@"numOfResults"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLAlittlecloserWebAlittlecloserApiMessagesSearchMessage class]
                                forKey:@"search"];
  return map;
}

@end