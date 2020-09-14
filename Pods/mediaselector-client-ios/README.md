mediaselector-client-ios
========================
Objective-C/Swift client Framework for interacting with the BBC Media-Selector select API in order to obtain prioritised URLs for streams/captions for a specified version PID and media-set.

This component is provided as a component of the BBC Mobile Application Platform (MAP). See the Confluence documentation for the components in the Media AT Reference space:

 https://confluence.dev.bbc.co.uk/display/MEDIAATR/Home

You should review the Mobile Application Platform page, and the sub-page relating to this component, in addition to this readme.

## Building 

Please consult the [building guidelines](.github/BUILDING.md) for instructions regarding building MAP components.

## Requirements

The MediaSelector Client works on:

- iOS 8.0 and above
- tvOS 9.0 and above
- macOS 10.11 and above

## Language Support

The MediaSelector Client works with both Objective-C and Swift. Note that the library has been annoted for Swift so the API is more 'Swifty' when calling it from Swift and the library name is 'MediaSelector'. On Objective-C, the library name is 'BBCMediaSelectorClient'.

# Using the Framework

Add the BBC Pods repo to your Podfile
```ruby
source 'git@github.com:bbc/map-ios-podspecs.git'
```
Add the media selector client pod and version you require
```ruby
pod 'mediaselector-client-ios', '~>4'
```
Tell Cocoapods to use frameworks
```ruby
use_frameworks!
```
Example Podfile to install via CocoaPods

```ruby
source 'git@github.com:bbc/map-ios-podspecs.git'

use_frameworks!
platform :ios, '8.0'

pod 'mediaselector-client-ios', '~>4'
```

## Obtaining a media-selector client
### Using the shared client
```objc
BBCMediaSelectorClient *client = [BBCMediaSelectorClient sharedClient];
```
### Instantiating your own client
```objc
BBCMediaSelectorClient *client = [[BBCMediaSelectorClient alloc] init];
```
### Configuring the client (optional)
If you want to change the configuration, HTTP-client or the response queue used by the shared client (to substitute your own configuration for the default configuration or substitute your own network queue management such as AFNetworking), there are methods on BBCMediaSelectorClient that can be used to do that:
```objc
id<BBCMediaSelectorConfiguring> myConfiguring;
BBCMediaSelectorClient *client = [[BBCMediaSelectorClient sharedClient] withConfiguring:myConfiguring];

id<BBCHTTPClient> myHTTPClient;
BBCMediaSelectorClient *client = [[BBCMediaSelectorClient sharedClient] withHTTPClient:myHTTPClient];
```
This follows the builder pattern, meaning that the methods can be chained to replace all three implementations:
```objc
BBCMediaSelectorClient *client = [[[[BBCMediaSelectorClient alloc] init] withHTTPClient:myHTTPClient] withConfiguring:myConfiguring];
```
#### Configuring the media-selector base URL (required)
Implement the following method of the BBCMediaSelectorConfiguring protocol and return a valid base URL:
```objc
- (NSString *)mediaSelectorBaseURL
{
    return @"https://open.live.bbc.co.uk/mediaselector/6/select/";
}
```
The above example is the default implementation.

#### Configuring the secure media-selector base URL (optional, but required if sending requests with SAML tokens - otherwise an exception is thrown)
Implement the following method of the BBCMediaSelectorConfiguring protocol and return a valid secure base URL:
```objc
- (NSString *)secureMediaSelectorBaseURL
{
    return @"https://av-media-sslgate.live.bbc.co.uk/saml/mediaselector/5/select/";
}
```
The above example is the default implementation.

#### Configuring the secure client-ID (optional, but required if sending requests with SAML tokens - otherwise an exception is thrown)
Implement the following method of the BBCMediaSelectorConfiguring protocol and return your client-ID string (used in constructing the Authorization header for requests that contain a SAML token) - for example:
```objc
- (NSString *)secureClientId
{
    return @"iplayer";
}
```
#### Configuring default parameters (optional)
Implement the following method of the BBCMediaSelectorConfiguring protocol and return an array of BBCMediaSelectorRequestParameter:
```objc
- (NSArray *)defaultParameters
{
    return @[[[BBCMediaSelectorRequestParameter alloc] initWithName:@"version" value:@"2.0"],[[BBCMediaSelectorRequestParameter alloc] initWithName:@"format" value:@"json"]];
}
```
Note that the default implementation of BBCMediaSelectorConfiguring returns the version and format parameters required for the request to return the correct response format.

#### Configuring the media-set (optional)
If you want to define a default media-set (so that requests don't need to specify it every time) implement the following method of the BBCMediaSelectorConfiguring protocol:
```objc
- (NSString *)mediaSet
{
    return @"mobile-phone-main";
}
```
## Making a request
### Simple request for stream URL for a vpid
#### Specifying media-set
If you just want the preferred stream URL for the highest bitrate available for a version PID, you can call the following method, specifying the vpid and media-set:
```objc
[[BBCMediaSelectorClient sharedClient] sendMediaSelectorRequest:[[[BBCMediaSelectorRequest alloc] initWithVPID:@"b873p780"]    
                                                withMediaSet:@"mobile-phone-main"]
                                                 success:^(NSURL *url) {
                                                     // Play the URL
                                                 }
                                                 failure:^(NSError *error) {
                                                     // Handle the error
                                                 }];

```
#### Using media-set from configuration
If your application always works with the same media-set, you may find it more convenient to implement the optional mediaSet method of BBCMediaSelectorConfiguring and specify the media-set there rather than for every request - you can then call:
```objc
[[BBCMediaSelectorClient sharedClient] sendMediaSelectorRequest:[[BBCMediaSelectorRequest alloc] initWithVPID:@"b873p780"] 
                                                 success:^(NSURL *url) {
                                                     // Play the URL
                                                 }
                                                 failure:^(NSError *error) {
                                                     // Handle the error
                                                 }];
```
(Note that if mediaSet is not implemented by your configuring object, an assertion will be thrown.)

### Request for full media-selector response with additional parameters
If you want to specify additional parameters to filter the media-selector response (such as proto or transferFormats), you can construct a BBCMediaSelectorRequest with those parameters:
```objc
BBCMediaSelectorRequest *request = [[[[[[BBCMediaSelectorRequest alloc] init] withMediaSet:@"mobile-phone-main"] withVPID:@"b873p780"] withProto:@"http"] withTransferFormats:@[@"hls"]];
```
If you want to specify a protocol preference (rather than constrain the protocol using `withProto`), you can construct a `BBCMediaSelectorRequest` using the parameter `withSecureConnectionPreference`:
```objc
BBCMediaSelectorRequest *request = [[[[[[BBCMediaSelectorRequest alloc] init] withMediaSet:@"mobile-phone-main"] withVPID:@"b873p780"] withSecureConnectionPreference:BBCMediaSelectorSecureConnectionPreferSecure] withTransferFormats:@[@"hls"]];
```
`withSecureConnectionPreference` takes a `BBCMediaSelectorSecureConnectionPreference` enum arguement, for which there are 4 options:
```objc
BBCMediaSelectorSecureConnectionPreferSecure
BBCMediaSelectorSecureConnectionEnforceSecure
BBCMediaSelectorSecureConnectionEnforceNonSecure
BBCMediaSelectorSecureConnectionUseServerResponse
```
`EnforceSecure` enforces HTTPS connections, `EnforceNonSecure` enforces HTTP connections, `PreferSecure` enforces HTTPS connections if they are available, and `UseServerResponse` enforces nothing.

If your request requires a SAML token to authorize it:
```objc
BBCMediaSelectorRequest *request = [[[[[[[BBCMediaSelectorRequest alloc] init] withMediaSet:@"mobile-phone-main"] withVPID:@"b873p780"] withSecureConnectionPreference:BBCMediaSelectorSecureConnectionPreferSecure] withTransferFormats:@[@"hls"] withSAMLToken:@"<saml-token>"];
```
You then pass this to the sendMediaSelectorRequest method as follows:
```objc
[client sendMediaSelectorRequest:_testRequest
                         success:^(BBCMediaSelectorResponse *response) {
                             // Use the response
                         }
                         failure:^(NSError *error) {
                             // Handle the error
                         }];
```
In the case of success, the BBCMediaSelectorResponse returned will contain an array of BBCMediaItem objects (one for each available bitrate or other type of media) which in turn contain an array of BBCMediaConnection objects. You can obtain a list of the available bitrates (as integer NSNumber objects in ascending order) by calling the following:
```objc
NSArray *bitrates = [response availableBitrates];
```
You can then obtain the media-item for specific bitrate as follows:
```objc
BBCMediaItem *item = [response itemForBitrate:@1500];
```
Or just ask for the highest bitrate media-item:
```objc
BBCMediaItem *item = [response itemForHighestBitrate];
```
If you want to get the media-item for captions (subtitles) call the following method:
```objc
BBCMediaItem *item = [response itemForCaptions];
```
Having obtained a BBCMediaItem, you can then get a sorted list of connections from it:
```objc
BBCMediaConnection *connection = [item.connections firstObject];
```
Which contain the URL used to play/download the stream (or subtitles):
```objc
NSURL *streamURL = [connection href];
```
# Tests
## Unit tests
You can run the unit tests using the MediaSelectorTests, MediaSelector-tvOSTests and MediaSelector-macOSTests schemes. These must all be passing before pushing any changes to the GitHub repository.

