# CHaRM
CHaRM Application
Eugene Ahn, Annette Cochran, Pranay Kumar, Adya Modi, Arianna Pathammavong


# Release Notes

v1.0.0

*New Features*
- Create account and login functionality
- Donate through PayPal
- Record materials brought to recycle
- View total recycling material brought in database
- View personal recycling history
- View fun facts about the benefits of recycling

*Bug Fixes Since Last Release*
- Since this is the initial release, the bug fixes were all done during the development and testing of this application. An example of a bug that was fixed during development is the quantity of materials not properly updating in a user’s recycling history after they submitted materials on the recycle page. Another bug that was fixed was the materials not updating correctly in the database due to a race condition, which was fixed by modifying how the application uses multithreading. A bug that prevented users from logging out properly was also fixed during testing. Smaller bugs, such as verifying that user input was valid in the recycle and account creation pages, were also fixed during development.

*Known Bugs and Defects*
- All features requested by the client and promised by the development team were implemented in the application. A known bug is that, when a user is selecting items they brought to recycle, if they deselect an item it will still appear in their saved history. Another defect currently is that users do not have the ability to reset their account password through the application interface. 

# Install Guide

Prerequisites: macOS device running Mojave (10.14.1) or higher and XCode version 10.1 or higher

Dependent Libraries: Application is not dependent on any libraries
 
Download Instructions:
Clone or download the CHaRM repository to get a local copy on a macOS device

Build Instructions:
For running in XCode simulator:
1. Open the CHaRM.xcworkspace file with XCode
2. Go to Product in the menu bar, under which there is an action labeled build. Click on build. Alternatively, use the keyboard shortcut ⌘ + B to build the application.

Installation of Actual Application:
Building the application in XCode is sufficient to install the application. 

Steps to publish in App Store:
To give users access to the application, it must be published to the Apple App Store. The steps below detail this process.   
Create Valid Apple developer program account
Sign in to App Store Connect. App Store Connect is a tool used to submit and manage applications to the App Store. 
Add/Edit users for testing
Submit a request to access the App Store Connect API
Generate an API key in order to add application to App Store Connect
Add a new application
Enter application information
Add export compliance information
Create a new version of application to publish
Upload, view, and submit builds
Submit application for review: https://developer.apple.com/app-store/review/
If review is approved, application will be published to app store

Further instructions can be found here: https://help.apple.com/app-store-connect/#/dev34e9bbb5a

Run Instructions:
For use in XCode Simulator:
Either press the play button in the top left corner or navigate to Product in the menu bar and then click Run. The keyboard shortcut to run the application is ⌘ + R. 
The simulator will launch and run the application

For use on iPhone:
The user must go to the App Store on their iPhone
The user must search for and download the CHaRM application
Click on the application icon to run it

Troubleshooting
We have not run into any issues while installing the application on macOS devices. However, if any issues were to arise during the installation process, the most likely fix would be to clean the build folder and rebuild the application. The option to clean the build folder is under Product in the menu bar or can be performed with the keyboard shortcut ⇧+ ⌘ + K.
