//
//  DDMultipeerLogger.h

#import "DDLog.h"

@interface DDMultipeerLogger : DDAbstractLogger <DDLogger>

- (id)initWithPeerDisplayName:(NSString*) name;

@end
