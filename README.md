# Movie Search App

Movie Search App is a SwiftUI-based iOS application that allows users to search for movies and view their details. The app integrates with a movie API to fetch search results and provides offline caching using Core Data. It also includes a disk-based image cache to improve performance when loading movie posters.

## Design Pattern

The app follows the MV state design pattern. While similar to MVVM, in this implementation, each ViewModel serves as an aggregate for a specific domain rather than being tied to individual views. This approach reduces code duplication and improves overall code organization, making the project more maintainable and easier to understand.

## Challenges Faced

1. Core Data Integration:
   One of the main challenges encountered during development was integrating Core Data for offline caching. As I had limited prior experience with Core Data, I had to invest time in learning and implementing the cache feature. It involved setting up the Core Data stack, managing contexts, and performing data persistence operations. Through thorough research and experimentation, I was able to overcome this challenge and successfully integrate Core Data into the app.

2. Disk-Based Image Cache:
   Another significant challenge was implementing a disk-based image cache to optimize the loading of movie posters. As Swift doesn't provide direct support for converting SwiftUI Image to data, I couldn't utilize popular solutions like AsyncImage. To overcome this limitation, I developed the `ImageInDiskCacheView` component. This custom view using URLSession to load image data from links so that I can save those data into disk.

## Usage

To run the app, open the Xcode project file and build the app for the desired simulator or device. The app supports iOS 16.4 and later.

## Dependencies

The project has the following dependencies:

- SwiftUI: The declarative UI framework used to build the user interface.
- CoreData: The framework used for offline caching of movie data.

Ensure that the dependencies are installed or fetched using a package manager like Swift Package Manager or CocoaPods before building the app.

## License

This project is licensed under the [MIT License](LICENSE).

