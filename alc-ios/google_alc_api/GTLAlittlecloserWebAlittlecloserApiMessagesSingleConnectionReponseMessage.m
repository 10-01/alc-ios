/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2013 Google Inc.
 */

//
//  GTLAlittlecloserWebAlittlecloserApiMessagesSingleConnectionReponseMessage.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   alittlecloser/v1
// Description:
//   A Little Closer API
// Classes:
//   GTLAlittlecloserWebAlittlecloserApiMessagesSingleConnectionReponseMessage (0 custom class methods, 27 custom properties)

#import "GTLAlittlecloserWebAlittlecloserApiMessagesSingleConnectionReponseMessage.h"

#import "GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse.h"

// ----------------------------------------------------------------------------
//
//   GTLAlittlecloserWebAlittlecloserApiMessagesSingleConnectionReponseMessage
//

@implementation GTLAlittlecloserWebAlittlecloserApiMessagesSingleConnectionReponseMessage
@dynamic blogUrl, body, completed, completionDate, connectionStage,
         connectionType, created, identifier, latitude, locName, longitude,
         markerColor, markerSize, markerSymbol, media, personthingId,
         personthingName, primaryMedia, reqReason, socialMediaJson, summary,
         title, type, updated, userId, userName, userPicture;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"blog_url", @"blogUrl",
      @"completion_date", @"completionDate",
      @"connection_stage", @"connectionStage",
      @"connection_type", @"connectionType",
      @"id", @"identifier",
      @"loc_name", @"locName",
      @"marker_color", @"markerColor",
      @"marker_size", @"markerSize",
      @"marker_symbol", @"markerSymbol",
      @"personthing_id", @"personthingId",
      @"personthing_name", @"personthingName",
      @"primary_media", @"primaryMedia",
      @"req_reason", @"reqReason",
      @"social_media_json", @"socialMediaJson",
      @"user_id", @"userId",
      @"user_name", @"userName",
      @"user_picture", @"userPicture",
      nil];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse class]
                                forKey:@"media"];
  return map;
}

@end
