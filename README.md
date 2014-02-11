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


If the client is not logged in, you may do so by calling `-login`. This method will handle displaying a
modal webview to the user and deal with the OAuth process for you. At the end you may look  

```objc
[[self.client login] subscribeError:^(NSError *error) {
    // do somethign with the error
} completed:^{
    // login completed successfully. do something.
}];
```

If you would like to get information about the currently logged in user, you may do so by accessing the `client.currentUser` property. See `CKIUser` for more information.

### Accessing the API

CanvasKit includes classes for many of the objects found in the Canvas LMS. Along with these model classes CanvasKit includes networking categories on `CKIClient` for accessing the API endpoints. For example, to fetch all the courses for the current user, you would do this:

```objc
[[client fetchCoursesForCurrentUser] subscribeNext:^(NSArray *courses) {
    // handle a page of courses
}];
```

Each networking method begins with 'fetch' making it easy for you to see all available options with Xcode auto-complete.

One thing to note is that CanvasKit uses [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa), however, it is not necessary to have any knowledge of ReactiveCocoa in order to use CanvasKit (although undertanding ReactiveCocoa will allow you to do much more powerful things). Each networking call returns a `RACSignal` object. Simply call `subscribeNext:` on that signal to process the data. Essentially the paginated data will be processed as a stream of pages, i.e. your `subscribeNext:` block will be called once for every page.

### License

CanvasKit is available under the MIT license. See the LICENSE file for more info.
