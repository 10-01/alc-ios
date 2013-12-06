/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAlittlecloserWebAlittlecloserApiMessagesSearchMessage;

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse
//

// ProtoRPC message definition to represent a list of stored scores.

@interface GTLAlittlecloserWebAlittlecloserApiMessagesSearchResponse : GTLObject
@property (copy) NSString *cursor;
@property (copy) NSString *message;
@property (retain) NSNumber *numOfResults;  // longLongValue

// ProtoRPC message definition to represent a score that is stored.
@property (retain) NSArray *search;  // of GTLAlittlecloserWebAlittlecloserApiMessagesSearchMessage

@end
