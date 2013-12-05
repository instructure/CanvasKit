## CanvasKit by Instructure iOS

***
CanvasKit is a Work in Progress—the architecture is still prone to change and not all off the API endpoints are implemented.
***

CanvasKit is a library that will help you integrate your own third party app with [Canvas by Instructure](https://instructure.com/).

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

CanvasKit 2.0 is a major refactor from the previous version of CanvasKit. Until now CanvasKit has only been used on internal projects at [Instructure](http://www.instructure.com/). One of our major goals of the recent refactor was to make CanvasKit open source and easy to use for third party developers.

## Usage

### Setup

In order to use CanvasKit with Instructure mangaged instances of [Canvas LMS](https://github.com/instructure/canvas-lms) you must obtain a Client ID and Shared Secret. CanvasKit uses [OAuth 2](https://canvas.instructure.com/doc/api/file.oauth.html) for authentication. Request your Client ID and Shared Secret by sending an email to <mike@instructure.com>. Make sure to give us your name, email, and what you are hoping to do with CanvasKit.

### CKIClient

The `CKIClient` is in charge of all the networking in CanvasKit. Insantiate a `CKIClient` with your client ID and shared secret like so:

```objc
CKIClient *client = [CKIClient clientWithBaseURL:url clientID:ClientID sharedSecret:SharedSecret];
```

This method will first try to load any previous session from the keychain. To see if the client is already logged in, call `[client isLoggedIn]`.

If the client is not logged in, you may do so by calling `-loginWithSuccess:failure:`. This method will handle displaying a
modal webview to the user and deal with the OAuth process for you. 

```objc
[self.client loginWithSuccess:^{
    // we're logged in. do anything we need to do after completion here.
} failure:^(NSError *error) {a
    // handle error
}];
```

The authentication token will remain in the keychain until you call `[client logout]`.

If you would like to get information about the currently logged in user, you may do so by accessing the `client.currentUser` property. See `CKIUser` for more information.

### Accessing the API

CanvasKit includes classes for many of the objects found in the Canvas LMS. Along with these model classes CanvasKit includes networking categories for accessing the API endpoints. This means if you wanted to get data from the API related to courses you would start with the CKICourse class and envoke one of the networking methods. For example:

```objc
[client fetchCoursesForCurrentUserWithSuccess:^(CKIPagedResponse *response) {
    // Success fetching courses
} failure:^(NSError *error) {
    // Failed to fetch courses
}];
```

Each networking method begins with 'fetch' making it easy for you to see all available options with Xcode auto-complete.

### License

CanvasKit is available under the MIT license. See the LICENSE file for more info.
