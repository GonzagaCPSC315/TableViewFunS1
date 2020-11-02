//
//  Dog.swift
//  TableViewFunS1
//
//  Created by Gina Sprint on 10/21/20.
//  Copyright © 2020 Gina Sprint. All rights reserved.
//

import Foundation

// dog.png author credit:
// <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

// MARK: - Persistent Data Storage
// users expect their data to persist across runs of the app
// 2 main classifications for data storage
// 1. local
// 2. remote

// iOS has a few options for local storage
// 1. UserDefaults: is used to stores simple types in a dictionary (e.g. key value pairs). so the types include: bool, int, array, float, string, etc....
// e.g. a simple value like a game high score (or the user's volume setting for playing music) would be great for UserDefaults
// 2. Archiving: ADS 4.7 reading and writing Codable objects to the file system
// archiving is inefficient because you have read/write the whole file even if you only need access to one object in the file
// 3. SQLite database: a lightweight relational database that uses SQL (structured query language)
// 4. Core Data: this is an Apple framework that is an OOP wrapper for a data store. By default on iOS, the data store is a SQLite database

// remote options: Backend as a service (BaaS) like Firebase or Realm, your own server,...

// MARK: - Archiving
// many of the standard types (like String) conform to the Codable protocol
// game plan
// 1. we need to get a URL for a dogs.plist in the app's document directory
// a URL is like a file path except because of the application sandbox, the URL changes (for security purposes)
// 2. write a static function that saves the array of dogs to dogs.plist file
// 3. write a static function that loads the array of dogs from dogs.plist file

class Dog: Codable {
    var name: String
    var breed: String
    var imageName: String
    
    static let pListURL: URL = {
       // this is called an initialization closure
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // userDomainMask refer's to the current user's home directory
        let fileURL = documentsDirectoryURL.appendingPathComponent("dogs").appendingPathExtension("plist")
        return fileURL
    }()
    
    static func saveDogsToFile(dogs: [Dog]) {
        let encoder = PropertyListEncoder()
        
        if let dogsData = try? encoder.encode(dogs) {
            // dogsData is of type Data (byte representation)
            // we can write Data to a URL (e.g. the plist)
            try? dogsData.write(to: pListURL)
        }
    }
    
    static func loadDogsFromFile() -> [Dog]? {
        let decoder = PropertyListDecoder()
        
        if let dogsData = try? Data(contentsOf: pListURL), let decodedDogs = try? decoder.decode([Dog].self, from: dogsData) {
            return decodedDogs
        }
        return nil
    }
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
        self.imageName = "dog"
    }
}
