//
//  Source/Hooks/SBDeleteIconAlertItem.xm
//  SearchDelete
//
//  Created by inoahdev on 12/25/16
//  Copyright © 2016 - 2017 inoahdev. All rights reserved.
//

#import <version.h>
#import "../Classes/SearchDeleteTweak.h"

#import "SFSearchResult.h"
#import "SPSearchResult.h"

#import "SPUISearchViewController.h"
#import "SearchUISingleResultTableViewCell.h"

%group iOS9
%hook SBDeleteIconAlertItem
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    %orig();

    SearchDeleteTweak *searchDelete = [SearchDeleteTweak sharedInstance];
    SearchUISingleResultTableViewCell *currentJitteringCell = [searchDelete currentJitteringCell];

    if (!currentJitteringCell) {
        return;
    }

    if ([searchDelete shouldJitter] && ![currentJitteringCell searchdelete_isJittering]) {
        return;
    }

    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    NSString *deleteButtonTitle = [[NSBundle mainBundle] localizedStringForKey:@"DELETE_ICON_CONFIRM" value:@"None" table:@"SpringBoard"];

    if ([buttonTitle isEqualToString:deleteButtonTitle]) {
        if ([(SPSearchResult *)currentJitteringCell.result searchdelete_isSystemApplication]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Respring"
                                                            message:@"A respring is required to fully delete System Applications. Until you respring, a non-functioning icon will exist on SpringBoard and Spotlight will still show results for the Application. Do you want to respring now?"
                                                           delegate:[%c(SPUISearchViewController) sharedInstance]
                                                  cancelButtonTitle:@"Later"
                                                  otherButtonTitles:@"Respring", nil];
            [alert show];
        }
    }
}
%end
%end

%ctor {
    if (IS_IOS_BETWEEN(iOS_9_0, iOS_9_3)) {
        %init(iOS9);
    }
}
