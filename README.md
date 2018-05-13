

<p align="center">
  <img src="./Art/JSWIFTLOGO.png" alt="drawing" width="450" height="450"/>
</p>


Easily conversion of JSON into Codable Structs supported by Swift 4

- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Features

- [ ] Codable Alamofire Support
- [ ] Cocopods Library 
- [ ] Swift Dictionary Mapping Support

## Usage

### User Interface

Paste your JSON or open a JSON file:

![Alt Text](https://media.giphy.com/media/mPzOSufN2bkZwgXqwg/giphy.gif)

### Extension

Selecting JSON using XCode:

![Alt Text](https://media.giphy.com/media/1g2JAtxGpTNAg4tSQs/giphy.gif)

Using copied JSON from your Clipboard:

![Alt Text](https://media.giphy.com/media/2kNswBCM2hUj9ZnTwJ/giphy.gif)



Once you have your codable structs created, you can easily retrieve data using:

```swift
let url = URL(string: "http://yourjsonurl.com")
let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in	
	let response = try JSONDecoder().decode(Main.self, from: data!)
}
task.resume()
```

## Requirements

- macOS 10.13+
- Xcode 8.3+
- Swift 4.0+

## Installation

### Download the App

- Download last jSwift's release

#### XCodeExtesion
- Run the app, then quit. Do not delete the App
- Go to System Preferences -> Extensions -> Xcode Source Editor and enable the JSwiftExtension extension
- Menu items should now be available from Xcode's Editor menu

Soon available in App Store 🙌

### Manual

- Clone or download the repo
- Run ``pod install``
- Open ``JSwift.xcworkspace``
- Enable target signing for both the Application and the Source Code Extension using your own developer ID

#### XCodeExtesion
- Select the application target and then Product > Archive
- Export the archive as a macOS App
- Run the app, then quit. Do not delete the App
- Go to System Preferences -> Extensions -> Xcode Source Editor and enable the JSwiftExtension extension
- The menu item should now be available from Xcode's Editor menu


## Credits

Thank you to my friend Seb Holt for doing JSwift's logo


## License

JSwift is released under the MIT license. [See LICENSE](https://github.com/ConradoMateu/JSwift/blob/master/LICENSE) for details.
