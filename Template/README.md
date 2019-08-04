#  Playground Book Xcode Project #

## Overview ##

Welcome to the Playground Book Xcode project! This Xcode project is set up to produce two things:

- A playground book
- An app for debugging the live view

In support of this, there are three targets in this Xcode project:

- **PlaygroundBook**: Produces a playground book as its output
- **Book_Sources**: Compiles the book-level auxiliary sources module, allowing book-level sources to be developed with full editor integration
- **LiveViewTestApp**: Produces an app which uses the `Book_Sources` module to show the live view similarly to how it would be shown in Swift Playgrounds

This project includes the PlaygroundSupport and PlaygroundBluetooth frameworks from Swift Playgrounds to allow the Book_Sources and LiveViewTestApp targets to take full advantage of those APIs. The supporting content included with this template, including these frameworks, requires Xcode 10.2 to build. Attempting to use this template with another version of Xcode may result in build errors.

For more information about the playground book file format, see the *[Swift Playgrounds authoring documentation](https://developer.apple.com/go/?id=swift-playgroundbook-authoring)*.

## First Steps ##

To get started with this Xcode project, you need to make a few changes to personalize it for your playground book.

1. Open `BuildSettings.xcconfig` (in the “Config Files” group in the Project navigator) and make the following modifications:

  - Set `BUNDLE_IDENTIFIER_PREFIX` to a value appropriate for your team
  - Set `PLAYGROUND_BOOK_FILE_NAME` to a value appropriate for your playground book

You may also modify `PLAYGROUND_BOOK_CONTENT_VERSION` to set the `ContentVersion` in the book's `Manifest.plist`. `PLAYGROUND_BOOK_CONTENT_IDENTIFIER` may also be modified to customize to set a specific `ContentIdentifier` in the book's `Manifest.plist`. (It defaults to a value based on `BUNDLE_IDENTIFIER_PREFIX` and `PLAYGROUND_BOOK_FILE_NAME`.)

2. Open `ManifestPlist.strings` (in the “PrivateResources” group in the “PlaygroundBook” group in the Project navigator) and modify the values of the strings to be appropriate for your playground book.

3. Open the Project Editor, select the LiveViewTestApp target, and select the appropriate Team in the Signing section. (This step is not required if you are only testing with the iOS Simulator.)

Once you've finished configuring the project, you can build the PlaygroundBook target, which will produce your playground book as a product. (You can access it by opening the “Products” group in the Project navigator, and then right-clicking and selecting “Show in Finder”. From there, you can use AirDrop or other methods to copy the playground book to an iPad running Swift Playgrounds.)

## Common Tasks ##

This Xcode project is structured both in Xcode and on-disk in a very particular way to ensure that the book is assembled correctly. Below are guides for accomplishing some common tasks when creating your playground book.

### Adding Book-Level Auxiliary Sources ###

In order to work correctly throughout this project, book-level auxiliary sources must be added to the Xcode project, to the Book_Sources target, and to the `PlaygroundBook/Sources` folder on disk. To add a new source file, you can either use the *File > New > File…* menu item, or right-click on the “Sources” group in the “PlaygroundBook” group in the Project navigator and select *New File…*.

In the assistant, select the appropriate template (either “Swift File” or “Cocoa Touch Class”, typically). When the assistant presents a sheet to save the new file, ensure the following is true:

  - The destination of the save sheet is the `Sources` directory inside of the `PlaygroundBook` directory
  - The new source file is being added to the Book_Sources target (and no others)

Adding a source file to the previously-mentioned “Sources” group should default to a location where both of those are true.

If a source file is not in the `Sources` directory on-disk, then it will not be copied into the correct location in the final playground book and will not be usable in Swift Playgrounds.

If a source file is not a member of the Book_Sources target, then it will not be compiled in Xcode. This means that syntax highlighting, code completion, and other editor features will not work in that source file, and the API it provides will not be usable in other source files in the Book_Sources or LiveViewTestApp targets.

**Note**: Only Swift sources are supported in playground books. This Xcode project will not enforce that requirement, but if any non-Swift source files are present in the final playground book, Swift Playgrounds will ignore them.

### Adding Book-Level PrivateResources ###

To add content to the book-level `PrivateResources` directory, add the resource file to the Xcode project, and ensure it is a member of the “Copy Bundle Resources” build phase of the PlaygroundBook target. It will be compiled if necessary (as is the case for xibs, storyboards, asset catalogs, and some other resource types) and then copied in to the playground book's `PrivateResources` directory.

### Adding Book-Level PublicResources ###

This Xcode project does not support book-level `PublicResources` by default. To add a `PublicResources` directory to your book, do the following:

  1. Create `PublicResources` directory in Finder in the `PlaygroundBook` directory
  2. Add the `PublicResources` directory to the “PlaygroundBook” group in Xcode as a folder reference (not as a group reference)
  3. Add the `PublicResources` directory to the “Copy Book Contents” build phase in the PlaygroundBook target in the Project editor

Unlike `PrivateResources`, the contents of the `PublicResources` directory are only copied. They will not be compiled; if you use compiled resources, you must treat them as `PrivateResources`.

### Adding Chapters, Pages, or Chapter- or Page-Level Content ##

This Xcode project has limited support for editing the chapters and pages in your playground book. The `Chapters` directory is present in the Xcode project as a folder. You may add `.playgroundchapter` packages there, and they will automatically be copied into the final playground book.

When adding a chapter or a page, you must also edit the book's or chapter's `Manifest.plist` file to reference the new chapter or page.

This Xcode project does not support syntax highlighting, code completion, live issues, or other advanced editor features inside of chapters and pages. It is therefore recommended that as much source code as possible be included in the book-level auxiliary sources, and that the chapters and pages have as little source code as possible.

### Testing the Live View ###

This Xcode project includes support for testing your playground book's live view. This testing support assumes that the live view for your playground book is implemented in the book-level auxiliary sources. If it is implemented elsewhere (i.e. in chapter- or page-level auxiliary sources, or in a page's `Contents.swift` or `LiveView.swift` file), then it cannot easily be tested using this mechanism.

To test your live view, run the LiveViewTestApp app. This app, which works both on iPad and in the iOS Simulator, is capable of displaying a live view in a manner similar to how Swift Playgrounds would display it. Most notably, LiveViewTestApp will correctly configure the live view safe area layout guides exposed by the PlaygroundSupport framework.

To configure your live view, implement the `setUpLiveView()` method in `AppDelegate.swift`. This should return a `UIView` or `UIViewController` which is ready to be used as the live view.

By default, LiveViewTestApp will run your live view in full screen. LiveViewTestApp is also able to run your live view in a side-by-side view (as if it were in Swift Playgrounds with the source code editor either next to or below the live view). To enable this, make the `liveViewConfiguration` property in `AppDelegate.swift` return `.sideBySide` instead of `.fullScreen`.
