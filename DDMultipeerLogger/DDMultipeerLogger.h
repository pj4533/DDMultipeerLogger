//
//  DDMultipeerLogger.h

#import "DDLog.h"

@interface DDMultipeerLogger : DDAbstractLogger <DDLogger>

- (id)initWithPeerDisplayName:(NSString*) name;
- (id)initWithPeerDisplayName:(NSString*) name withAssistant:(BOOL) useAssistant;

@end
