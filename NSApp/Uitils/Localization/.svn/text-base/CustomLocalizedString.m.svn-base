#import "CustomLocalizedString.h"

NSString* CustomLocalizedString(NSString *key, NSString *comment) {
    return [LanguageBundle() localizedStringForKey:key value:comment table:nil];
}

NSBundle *LanguageBundle(){
    NSString *local = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCAL"];
    
    if (local == nil) {
        local = @"zh-Hans";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:local ofType:@"lproj"];
    
    return [NSBundle bundleWithPath:path];
}