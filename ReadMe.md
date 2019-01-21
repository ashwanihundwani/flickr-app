# FlickrApp

This project is aimed at using the Flickr image search API and showing the results in the mobile app.

## Features
- The app shows the recent images first up, using the Flickr getRecent API.
- The app lets users enter queries, results are displayed to the users based on the search query.
- The app downloads the images infinitely until all the results are fetched by loading the results while user scrolls to the bottom of the screen. The app displays the results in 3 column UI(Collection View)

## Requirements

- iOS 10.0+
- Xcode 10.1+
- Swift 4.2+

## Architecture
The code is structured based on the MVVM(Model–view–viewmodel) architecture. The idea here is to offload the View Controllers, to make code more testable.

### What's Covered
- The major features mentioned above.
- Unit Testing
- Image Caching
- Basic error handling for failure cases while calling Flickr API
- Documentation/Commenting - Code documentation is done for(Classes, Structs, Enums, Methods & Properties).


### What's not covered due to limited timeline

- Extensive Unit Testing - More test cases could have been introduced
- Image Caching Policy - The app uses the cache with the default policy. The app might use the more memory than expected for some cases, this could have been managed better.
- Error Handling - More specific error handling like specific error messages for the error scenarios could have been taken care of.
- Loading UI - While fetching results there should have been a loading UI/Activity Indicator.
- URLS are built with minimal modifications. API key should have been placed elsewhere(more secure way).
- Code Documentation - Specific scenarios could have been documented well. For Example - Comments for specific lines of codes.


