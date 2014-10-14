//
//  QuizletImages.h
//  ios_quizlet_client
//
//  Created by Maxim Bilan on 8/19/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//
//  Latest code can be found on GitHub: https://github.com/maximbilan/ios_quizlet_client
//

#import <Foundation/Foundation.h>

@class QuizletAuth;

/**
 Quizlet Images API
 */
@interface QuizletImages : NSObject

/**
 POST: /images
 Upload one or more images
 
 Parameter      Type	Description
 imageData[]	array	An array of one or more images.
 */
- (void)uploadImageFromURLs:(NSArray *)urls
                   withAuth:(QuizletAuth *)auth
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

@end
