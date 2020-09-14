# httpclient-ios

This library provides a common HTTP client for use in iOS, tvOS and macOS components and applications that does two things:

- Provides a common protocol (interface) for an HTTP client and associated requests/responses/errors to avoid duplicating this between components that make HTTP requests
- Provides a reference implementation of this protocol that uses NSURLSession

## Building 

Please consult the [building guidelines](.github/BUILDING.md) for instructions regarding building MAP components.

## Requirements

The HTTP Client works on:

- iOS 8.0 and above
- tvOS 9.0 and above
- macOS 10.11 and above

## Language Support

The HTTP Client works with both Objective-C and Swift. Note that the library has been annoted for Swift so the API is more 'Swifty' when calling it from Swift and the library name is 'HTTPClient'. On Objective-C, the library name is 'BBCHTTPClient'.

# Integrating the library

1. Add the map-ios-podspecs repo to your CocoaPods installation:

    ```
    pod repo add map-ios-podspecs git@github.com:bbc/map-ios-podspecs.git
    ```

   Or add the location of the map-ios-podspecs repo to your Podile:
   
    ```
    source 'git@github.com:bbc/map-ios-podspecs.git'
    ```

2. Tell Cocoapods to use frameworks
    
    ```
    use_frameworks!
    ```

3. Add the httpclient-ios pod to your Podfile - for example:

    ```
    pod 'httpclient-ios'
    ```

# Using the library
## Create a network client
The BBCHTTPNetworkClient provides a reference implementation of the BBCHTTPClient protocol which uses NSURLSession to send requests:

```
self.networkClient = [BBCHTTPNetworkClient networkClient];
```

*(Note that this is not a shared-client/singleton, but all instances of BBCHTTPNetworkClient use [NSURLSession sharedSession] meaning that there is effectively a single network queue shared between all instances of BBCHTTPNetworkClient. This allows multiple instances of BBCHTTPNetworkClient to be configured for different purposes.)*
	
## Sending a request
### Create the request
Requests need to conform to the BBCHTTPRequest protocol which requires you to specify the URL and allows you to optionally specify the method, user-agent, headers, body, cache-policy and timeout used for the request:

```
@protocol BBCHTTPRequest <NSObject>

@property (readonly) NSString *url;

@optional

@property (readonly) NSString *method;
@property (readonly) id<BBCHTTPUserAgent> userAgent;
@property (readonly) NSDictionary *headers;
@property (readonly) NSData *body;
@property (readonly) NSURLRequestCachePolicy cachePolicy;
@property (readonly) NSTimeInterval timeoutInterval;
@property (readonly) NSArray<id<BBCHTTPRequestDecorator>> * _Nullable requestDecorators;
@property (readonly) NSArray<id<BBCHTTPResponseProcessor>> * _Nullable responseProcessors;
@property (readonly) NSValue * _Nonnull acceptableStatusCodeRange; 

@end
```

BBCHTTPNetworkRequest provides an implementation of this protocol that implements all of the required and optional properties and implements the builder pattern to allow these to be set.

### Specifying response processors (optional)
Response processors allow the response body received from the server to be modified before it is passed back to the success/failure blocks - e.g. to parse JSON or create an image from the data in the response body. An array of response-processors may be specified on a request by calling withResponseProcessors:

```
BBCHTTPNetworkRequest *request = [[[BBCHTTPNetworkRequest alloc] initWithString:@"http://www.bbc.co.uk"] withResponseProcessors: responseProcessors];
```

Response processors may be chained together to apply multiple transformations to the response body and are called in the order specified in the responseProcessors array. They must conform to the BBCHTTPResponseProcessor protocol:

```
@protocol BBCHTTPResponseProcessor <NSObject>

- (id)processResponse:(id)response error:(NSError **)error;

@end
```

The first response-processor called will be passed an instance of NSData containing the raw body of the response. Each processor's implementation of processResponse should then return the transformed response object. If a response processor does not return a response object, it should set *error to an NSError giving the reason for the failure (if error is non-null).

The following sample response processors are provided:

- BBCHTTPJSONResponseProcessor - attempts to parse the supplied NSData to a JSON object (NSArray or NSDictionary) using NSJSONSerialization - returns nil if parsing fails and populates *error with the parsing error.
- BBCHTTPImageResponseProcessor - attempts to parse the supplied NSData to a UIImage - returns nil if this fails (but does not populate *error).

### Send via the client
To send the request, call the sendRequest method of BBCHTTPClient passing in your request:

```
- (id<BBCHTTPTask>)sendRequest:(id<BBCHTTPRequest>)request success:(BBCHTTPClientSuccess)success failure:(BBCHTTPClientFailure)failure;
```

And supplying a success block:

```
typedef void(^BBCHTTPClientSuccess)(id<BBCHTTPRequest>request, id<BBCHTTPResponse> response);
```

And a failure block:

```
typedef void(^BBCHTTPClientFailure)(id<BBCHTTPRequest>request, id<BBCHTTPError> error);
```

The object returned from sendRequest is an instance of a class conforming to the BBCHTTPTask protocol which allows the caller to cancel the pending request:

```
@protocol BBCHTTPTask <NSObject>

- (void)cancel;

@end
```

### Handle the response/error
The response passed to the success block conforms to the BBCHTTPResponse protocol which gives access to the response's status-code, headers and body:

```
@protocol BBCHTTPResponse <NSObject>

@property (readonly) NSInteger statusCode;
@property (readonly) NSDictionary *headers;
@property (readonly) id body;

@end
```

While the error returned to the failure block conforms to the BBCHTTPError protocol which gives access to an error object and the response's body:

```
@protocol BBCHTTPError <NSObject>

@property (readonly) NSError *error;
@property (readonly) id body;

@end
```

For HTTP status codes outside of the client's range of acceptable status codes (normally 200-299), the error will have the domain "HTTP" and the code set to the status code.

## Configuring the client
### Set the user agent (optional)
To set the user-agent, call the setUserAgent method on the BBCHTTPClient protocol:

```
- (void)setUserAgent:(id<BBCHTTPUserAgent>)userAgent;
```

Passing an instance of a class conforming to BBCHTTPUserAgent:

```
@protocol BBCHTTPUserAgent <NSObject>

- (NSString *)userAgent;

@end
```

The following implementations of BBCHTTPUserAgent are provided:

- BBCHTTPDefaultUserAgent - specifies a user-agent string conforming to the BBC guidelines for mobile application user-agent string containing both the application name and version and the HTTP client component name and version (e.g. *"MyApplication/1.0.0 (x86_64; iPhone OS 9.1) BBCHTTPClient/1.0.0"*)
- BBCHTTPLibraryUserAgent - initialized with the name and version of a library that uses the BBCHTTPClient - returns a similar user-agent string to BBCHTTPDefaultUserAgent but containing the library name and version as an additional token (e.g. *"MyApplication/1.0.0 (x86_64; iPhone OS 9.1) MyLibrary/1.0.0 BBCHTTPClient/1.0.0"*)
- BBCHTTPStringUserAgent - initialized with a static user-agent string

### Set the response queue (optional)
By default, the client returns responses on the main queue - if you wish to continue processing responses on a different queue, you can specify our own queue by calling setResponseQueue:

```
- (void)setResponseQueue:(dispatch_queue_t)responseQueue;
```

### Set the acceptable range of (non-error) status codes (optional)
By default, the client treats HTTP status codes in the range 200-299 as indicating a successful request - all other status codes lead to a BBCHTTPError being returned to the failure block. To change the range of non-error status codes, call setAcceptableStatusCodeRange:

```
- (void)setAcceptableStatusCodeRange:(NSRange)acceptableStatusCodeRange;
```

### Specifying request decorators (optional)
Request decorators allow requests being sent by the client to be modified in a consistent way that does not require this decoration to be done before every call to sendRequest (an example usage would be to add authorization headers). An array of request-decorators may be specified to the client by calling setRequestDecorators:

```
- (void)setRequestDecorators:(NSArray *)requestDecorators;
```

Request decorators may be chained together to apply multiple transformations to the request and are called in the order specified in the requestDecorators array. They must conform to the BBCHTTPRequestDecorator protocol:

```
@protocol BBCHTTPRequestDecorator <NSObject>

- (NSURLRequest *)decorateRequest:(NSURLRequest *)request;

@end
```

The first request decorator is passed the original request created by the HTTP client. Each decorator's implementation of decorateRequest should return a new instance of NSURLRequest containing the decorated request.

The following sample request decorators are supplied:

- BBCHTTPOAuthRequestDecorator - when the authenticationProvider (e.g. "IdP") and accessToken properties are set, populates the X-Authentication-Provider and Authorization headers of the request with the appropriate values.
- BBCHTTPSAMLRequestDecorator - when initialized with a clientId (e.g. "iplayer") and the samlToken property is set, populates the Authorization header of the request with the appropriate value.

# Tests
## Unit tests
You can run the unit tests using the BBCHTTPClient schemes. These must all be passing on all platforms before pushing any changes to the GitHub repository.

