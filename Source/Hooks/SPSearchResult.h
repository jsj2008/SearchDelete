//
//  Source/Hooks/SPSearchResult.h
//
//  Created by inoahdev on 12/25/16
//  Copyright © 2016 inoahdev. All rights reserved.
//

#ifndef HOOKS_SPSEARCHRESULT_H
#define HOOKS_SPSEARCHRESULT_H

#include "../Headers/Search/SPSearchResult.h"

@interface SPSearchResult ()
- (BOOL)searchdelete_isApplication;
- (BOOL)searchdelete_isSystemApplication;
- (BOOL)searchdelete_allowsUninstall;
@end

#endif