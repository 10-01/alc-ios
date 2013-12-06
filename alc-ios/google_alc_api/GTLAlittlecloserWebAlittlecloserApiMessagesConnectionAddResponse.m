/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse (0 custom class methods, 2 custom properties)

#import "GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse.h"

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse
//

@implementation GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse
@dynamic message, newConnectionId;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"new_connection_id"
                                forKey:@"newConnectionId"];
  return map;
}

@end
