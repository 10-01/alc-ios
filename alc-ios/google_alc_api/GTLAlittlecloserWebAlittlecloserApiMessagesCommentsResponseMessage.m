/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesCommentsResponseMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesCommentsResponseMessage (0 custom class methods, 15 custom properties)

#import "GTLAlittlecloserWebAlittlecloserApiMessagesCommentsResponseMessage.h"

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesCommentsResponseMessage
//

@implementation GTLAlittlecloserWebAlittlecloserApiMessagesCommentsResponseMessage
@dynamic body, commentId, connectionId, connectionTitle, created, media,
         personthingId, personthingName, postType, socialMediaJson, tags, title,
         updated, userId, userName;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"comment_id", @"commentId",
      @"connection_id", @"connectionId",
      @"connection_title", @"connectionTitle",
      @"personthing_id", @"personthingId",
      @"personthing_name", @"personthingName",
      @"post_type", @"postType",
      @"social_media_json", @"socialMediaJson",
      @"user_id", @"userId",
      @"user_name", @"userName",
      nil];
  return map;
}

@end
