DDMultipeerLogger
=================

A logger for [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) that uses multipeer connectivity

## Usage

Add the logger as you would any other custom logger.  All the Multipeer connectivity code is hidden behind the logger.


``` objective-c
	// default name is the device name
    [DDLog addLogger:[[DDMultipeerLogger alloc] init]];

    // or with a custom name
	[DDLog addLogger:[[DDMultipeerLogger alloc] initWithPeerDisplayName:@"My Sweet Custom Name"]];
```

## Contact

PJ Gray

- http://github.com/pj4533
- http://twitter.com/pj4533
- pj@pj4533.com

## License

DDMultipeerLogger is available under the MIT license. See the LICENSE file for more info.

