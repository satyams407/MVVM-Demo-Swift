# MVVM-Demo-Swift
MVVM architecture Demo 
OnSite Coding Test - MutualMobile


Problem statement
      Fetch data from "https://jsonplaceholder.typicode.com/photos" and show them in list and grid views

1. Followed MVVM Architecture:
   
Landing View Controller is handling all UI stuff - all collection view data source and delegateMethods, actions of segments etc
Called FetchPhotoService class from viewDidLoad()
In response to service parse the data in Landing View model class
Initialised the photocell model only with image URL and its title.
In case failure of response show alert messages
On tapping of any cell, performed segue to show the enlarged image with a title in new viewController, added pinch gesture to image for zoom in and zoom out 
Asynchronously downloaded the images (lazy loading) for smooth scrolling


2. UI Part - 
 a.) Added launch screen.
 b.) Used Collection view to show photos and its title. 
 c.) Created a segment to switch in between the grid and list layouts.
 d.) Showed alert messages when the user is in offline mode or unable to fetch the data.
 e.) Work for all the screen sizes of iPad and iPhone


 3.  Unit Testing 
    Tested the service class and landing view model class
       testFetchPhotoServiceSuccess()
       testFetchPhotoServiceFailure()
       testModelIntialisation()













