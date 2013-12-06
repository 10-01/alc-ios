/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage;

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse
//

// ProtoRPC message definition to represent a list of stored scores.

@interface GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse : GTLObject

// ProtoRPC message definition to represent a score that is stored.
@property (retain) NSArray *connections;  // of GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage

@property (copy) NSString *cursor;
@property (retain) NSNumber *numOfResults;  // longLongValue
@end