/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesConnectionUpdateRequest.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionUpdateRequest (0 custom class methods, 14 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionUpdateRequest
//

// ProtoRPC message definition to represent a scores query.

@interface GTLAlittlecloserWebAlittlecloserApiMessagesConnectionUpdateRequest : GTLObject
@property (retain) NSNumber *apikey;  // longLongValue
@property (copy) NSString *body;
@property (copy) NSString *connectionId;
@property (retain) NSNumber *connectionStage;  // longLongValue
@property (copy) NSString *media;
@property (copy) NSString *personalizedMessage;
@property (retain) NSNumber *personthingId;  // longLongValue
@property (copy) NSString *personthingName;
@property (copy) NSString *primaryMedia;
@property (copy) NSString *privateLocation;
@property (copy) NSString *requestReason;
@property (copy) NSString *summary;
@property (copy) NSString *title;
@property (copy) NSString *type;
@end
