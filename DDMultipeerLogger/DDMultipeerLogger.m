//
//  DDMultipeerLogger.m


#import "DDMultipeerLogger.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface DDMultipeerLogger () <MCNearbyServiceAdvertiserDelegate,MCAdvertiserAssistantDelegate, MCSessionDelegate,UIAlertViewDelegate> {
    MCPeerID *_myDevicePeerId;
    MCSession *_session;
    MCAdvertiserAssistant *_advertiserAssistant;
    MCNearbyServiceAdvertiser *_nearbyAdvertiser;
    NSString* _displayName;
    
    BOOL _useAssistant;
}

@end
@implementation DDMultipeerLogger

- (id)init {
    if (self = [super init]) {
        
        if (!_displayName) {
            _displayName = [[UIDevice currentDevice] name];
        }
        _myDevicePeerId = [[MCPeerID alloc] initWithDisplayName:_displayName];
        
        _session = [[MCSession alloc] initWithPeer:_myDevicePeerId securityIdentity:nil encryptionPreference:MCEncryptionNone];
        _session.delegate = self;
        
        if (_useAssistant) {
            _advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"debugee-service" discoveryInfo:nil session:_session];
            [_advertiserAssistant start];
        } else {
            _nearbyAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:_myDevicePeerId discoveryInfo:nil serviceType:@"debugee-service"];
            _nearbyAdvertiser.delegate = self;
            [_nearbyAdvertiser startAdvertisingPeer];
        }
    }
    return self;
}

- (id)initWithPeerDisplayName:(NSString*) name withAssistant:(BOOL) useAssistant {
    _useAssistant = useAssistant;
    _displayName = name;

    return [self init];
}

- (id)initWithPeerDisplayName:(NSString*) name {
    return [self initWithPeerDisplayName:name withAssistant:YES];
}

#pragma mark - DDLogger

- (void)logMessage:(DDLogMessage *)logMessage {
    NSDictionary* logMessageDict = @{ @"logMsg" : logMessage->logMsg,
                                      @"logFlag" : @(logMessage->logFlag)
                                     };
    NSData* logMessageAsData = [NSKeyedArchiver archivedDataWithRootObject:logMessageDict];
    [_session sendData:logMessageAsData toPeers:_session.connectedPeers withMode:MCSessionSendDataReliable error:nil];
}

#pragma mark - MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    if (invitationHandler) {
        invitationHandler(YES, _session);
    }
}

#pragma mark - MCSessionDelegate Methods

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
	switch (state) {
		case MCSessionStateConnected:
            NSLog(@"PEER CONNECTED: %@", peerID.displayName);
			break;
		case MCSessionStateConnecting:
            NSLog(@"PEER CONNECTING: %@", peerID.displayName);
			break;
		case MCSessionStateNotConnected:
            NSLog(@"PEER NOT CONNECTED: %@", peerID.displayName);
			break;
	}
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
}

@end
