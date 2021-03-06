/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage (0 custom class methods, 26 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse;

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage
//

// ProtoRPC message definition to represent a score that is stored.

@interface GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage : GTLObject
@property (copy) NSString *blogUrl;
@property (retain) NSNumber *completed;  // boolValue
@property (retain) GTLDateTime *completionDate;
@property (retain) NSNumber *connectionStage;  // longLongValue
@property (copy) NSString *connectionType;
@property (retain) GTLDateTime *created;

// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (retain) NSNumber *identifier;  // longLongValue

@property (retain) NSNumber *latitude;  // doubleValue
@property (copy) NSString *locName;
@property (retain) NSNumber *longitude;  // doubleValue
@property (copy) NSString *markerColor;
@property (copy) NSString *markerSize;
@property (copy) NSString *markerSymbol;
@property (retain) NSArray *media;  // of GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse
@property (copy) NSString *personthingId;
@property (copy) NSString *personthingName;
@property (copy) NSString *primaryMedia;
@property (copy) NSString *reqReason;
@property (copy) NSString *socialMediaJson;
@property (copy) NSString *summary;
@property (copy) NSString *title;
@property (copy) NSString *type;
@property (retain) GTLDateTime *updated;
@property (retain) NSNumber *userId;  // longLongValue
@property (copy) NSString *userName;
@property (copy) NSString *userPicture;
@end
