## CanvasKit by Instructure iOS

CanvasKit is a library that will help you integrate your own third party app with [Canvas by Instructure](https://canvas.instructure.com/).

CanvasKit is built on the [Canvas API](https://canvas.instructure.com/doc/api/index.html). CanvasKit is designed to allow for great flexibility while providing an easy to use interface. You can use CanvasKit to build apps for open source versions of Canvas as well as instances hosted by Instructure.

## How To Get Started

- [Download CanvasKit](https://github.com/instructure/CanvasKit/archive/master.zip) and try out the included iPhone example app
- Take a look at the [Canvas API](https://canvas.instructure.com/doc/api/index.html) for a complete list of endpoints

### Installation with CocoaPods

***
NOTE: Canvas Kit is not yet a cocoapod but will be soon
***

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like CanvasKit in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking).

#### Podfile

```ruby
platform :ios, '7.0'
pod "CanvasKit", "~> 2.0"
```

## 2.0

CanvasKit 2.0 is a major refactor from the previous version of CanvasKit. Until now CanvasKit has only been used on internal projects at [Instrucutre](http://www.instructure.com/). One of our major goals of the recent refactor was to make CanvasKit open source and easy to use for third party developers.

## Usage

### Setup

In order to use CanvasKit with Instructure mangaged instances of [Canvas LMS](https://github.com/instructure/canvas-lms) you must obtain a Client ID and Shared Secret. CanvasKit uses [OAuth 2](https://canvas.instructure.com/doc/api/file.oauth.html) for authentication. Request your Client ID and Shared Secret by sending an email to <mike@instructure.com>. Make sure to give us your name, email, and what you are hoping to do with the CanvasKit.

Once you have your Client ID and Shared Secret you can start using CanvasKit. Somewhere in your App Delegate's `didFinishLaunchingWithOptions` method setup CanvasKit with your Client ID and Shared Secret.

```objc
[CanvasKit prepareWithClientID:@"yourclientid" sharedSecret:@"yoursharedsecret"];
```

### User Authentication


#### CKLocalUser

CanvasKit uses the concept of a 'Local User', or the user currently using the device. `CKLocalUser` is a singleton, giving you access to the current user anywhere in your application by calling:

```objc
[CKLocalUser sharedInstance]
```

Before you can use any other CanvasKit methods to access the Canvas LMS API you must authenticate the current user. CanvasKit makes this easy by handling the OAuth 2 authentication flow for you. All you have to do is call the following method to prompt the user to authenticate.

```objc
[[CKLocalUser sharedInstance] performLoginWithDomain:@"yourschooldomain" success:^{
    [self dismissViewControllerAnimated:YES completion:nil];
    // Success the user was authenticated
} failure:^(NSError *error) {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Authentication failed 
}];
```

#### Keychain

Once authentication succeeds, an authentication token will be added to your application's keychain. If you would like to use a shared keychain with CanvasKit make sure you prepare CanvasKit with your shared keychain id:

```objc
[CanvasKit prepareWithClientID:@"yourclientid" sharedSecret:@"yoursharedsecret" keyChainId:@"yourkeychainid"];
```
The authentication token will remain in the keychain until you logout the `CKLocalUser`.

```objc
[[CKLocalUser sharedInstance] logout];
```

### Accessing the API

#### Architecture Overview

CanvasKit includes classes for many of the objects found in the Canvas LMS. Along with these model classes CanvasKit includes networking categories for accessing the API endpoints. This means if you wanted to get data from the API related to courses you would start with the CKCourse class and envoke one of the networking methods. For example:

```objc
[CKCourse fetchCoursesForCurrentUserWithSuccess:^(CKPagedResponse *response) {
    // Success fetching courses
} failure:^(NSError *error) {
    // Failed to fetch courses
}];
```

Each networking method begins with 'fetch' making it easy for you to see all available options with Xcode auto-complete.

#### `CKPagedResponse` and Pagination

You will notice that each success block will return a `CKPagedResponse` object. All of our API endpoints are treated as if they were paginated. 

CanvasKit is available under the MIT license. See the LICENSE file for more info.
