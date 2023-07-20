# PetFinder

App that searches for pets using a REST API and makes jay really happy if the pets happen to have bunny ears.

Demo app was created while learning iOS app development in 2019. Not updated with the latest tech.

Improvements to be made: 
- Use modern collection views API with Combine data pipelines
- Use Core Data instead of Realm Swift

## Where does it find the data?
#### Pet Finder API

This is [an example link to the API](https://api.petfinder.com/v2/animals?type=rabbit&location=Apex,%20NC "Pet Finder API") 
 

## What does it use to parse JSON data?
#### JSONDecoder and Codable (see Model/PetFinderDataModel)

## How does it interact with the REST API?
- Post (for authentication)
- Get (for acquiring data on pets)

#### URLSessions
##### Basic process for this method:
1. Check if this object has made a valid (non nil) url
2. Start an (async) data task with URLSession
3. Resume/end task


## How does it look?
#### How about you download the app and see for yourself.



#### Icon Images
Icons made by [](https://www.flaticon.com/authors/freepik "Freekpik") and licensed by [](http://creativecommons.org/licenses/by/3.0/ "Creative Commons BY 3.0")

