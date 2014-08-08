//
//  APIUrl.h
//  NSApp
//
//  Created by DongCai on 7/27/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USE_TEST_DATA_MODE 0


#define Test_Version                         1

#define Product_Version                      0

//API Return Code

#define API_Sucess_Code                     200
#define API_IDType_Error_Code               400
#define API_NotAuthorized_Error_Code        401
#define API_PayMent_Required_Error_Code     402
#define API_Forbidden_Error_Code            403
#define API_RequestURL_NotFound_Error_Code  404
#define API_Server_Error_Code               500
#define API_Not_Implemented_Error_Code      501

/*UAT Version*/

#if Test_Version

#define NOISIM_ERROR_DEMAIN                     @""
#define NOISIM_BASE_URL                         @"http://serverurl"
#define NOISIM_BASE_PATH                        @""

//启动
#define NOISIM_PATH_VERSIONCHECK              @"/versioncheck"

#endif

/* Product Version */
#if Product_Version

#define NOISIM_ERROR_DEMAIN                     @""
#define NOISIM_BASE_URL                         @"http://serverurl"
#define NOISIM_BASE_PATH                        @"/api"

//启动
#define NOISIM_PATH_VERSIONCHECK              @"/versioncheck"
#endif

