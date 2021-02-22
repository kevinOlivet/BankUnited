# BankUnited

This pod holds the BankUnited code for use with BasicMainApp.
There are 3 environments:
DEV - Uses OHTTPStubs and json files to supply false data
QA - Connects to a free dummy backend.  Fails often due to 429 too many requests error.
PROD - Same as QA

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Xcode 12.0
Swift 5

## Installation

BankUnited is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile, note that BankUnited has a dependency on BasicCommons and BasicUIElements:

pod 'BankUnited', :git => 'https://github.com/kevinOlivet/BankUnited.git', :branch => 'develop'
pod 'BasicCommons', :git => 'git@github.com:kevinOlivet/BasicCommons.git', :branch => 'develop'
pod 'BasicUIElements', :git => 'git@github.com:kevinOlivet/BasicUIElements.git', :branch => 'develop'

## Author

Kevin Olivet, japanart1234@yahoo.com

## License

BankUnited is available under the MIT license. See the LICENSE file for more info.
