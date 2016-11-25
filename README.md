iOS Tech Test
====================

About
-----
A Junior Tech test for ******

Goal
----
To produce a simple iOS application demonstrating an understanding of the Swift language, network communication, JSON parsing and use of core UIKit frameworks. This coding test is based off an actual feature in the ***** iOS application.

Task
----
 - Poll an API endpoint: https://sheetsu.com/apis/v1.0/aaf79d4763af  
 - Parse the JSON response.  
 - Display the `name` and image defined by `image_url` in a list.  
 - Display each item returned from the API in the order defined by `sort_order`.  
 - Open the URL defined by `url` in the most appropriate way inside the app.

Requirements
------------
 - Swift >= 3.0  
 - Xcode >= 8.0  
 - CocoaPods

Stretch Goal
------------
 - Offline persistence and local storage of remote data, using whatever technology or technique you like.

Notes
-----
 - One entry in the API response does not have a URL. That entry should just display the image.

Installation
------------
- Clone this repo.
- Navigate into the splittable project directory.
- Run `pod install` to install necessary dependencies.
- Then open `splittable.xcworkspace`.
- `cmd + u` to run the tests.
- `cmd + r` to run the app on an iPhone, iPad or the simulator.
- If any issues arise please drop me an email at: jonathandpickard@gmail.com
