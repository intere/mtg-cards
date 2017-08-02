//
//  MockCardDataService.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

@testable import MTG_Cards
import Foundation

class MockCardDataService {
    struct Constants {
        static let mockCards = [
            Card(name: "DeadPool, fairy princess", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/f3/d5/93/f3d593cbfdc378555d0537ad1fc20332.jpg"),
            Card(name: "Dredge Pirate Roberts", imageUrlString: "https://i.pinimg.com/564x/26/1f/2a/261f2a99d76f9218352238f294400bf5.jpg"),
            Card(name: "Killer Rabbit", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/21/99/43/219943d3d72485f426310a2340640312.jpg"),
            Card(name: "Kool-Aid Man", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/71/c7/0f/71c70fe42bec59ee21aebdd91f11cca7.jpg"),
            Card(name: "Logan \"Wolverine\"", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/99/82/fc/9982fc1b6939fa051c703e5b3873da62.jpg"),
            Card(name: "Chuck Norris", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/a6/d1/39/a6d139a162dc8abebe83df3fd3f7ae0a.jpg"),
            Card(name: "Yoda, Jedi Master", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/6f/2e/1e/6f2e1e415371224d456c181b33b9515d.jpg"),
            Card(name: "Snape", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/8c/77/4c/8c774c0be9537d90f97b7e8209558b51.jpg"),
            Card(name: "The Doctor", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/b9/17/a9/b917a91bd3d29570b87f5ac76a919b74.jpg"),
            Card(name: "The Death Star", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/29/d7/fd/29d7fd69d89794d4235c2b2029a22b8e.jpg"),
            Card(name: "Darth Sidious, Sith Lord", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/0d/35/81/0d358183ea84851ec4c52bc44b8b2ac3.jpg"),
            Card(name: "Batman, The Dark Knight", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/51/4b/e7/514be7395722d1e0d64cd9638ffcff33.jpg"),
            Card(name: "Kirk, Enterprise Captain", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/24/df/e2/24dfe22325d9bca873009d50e60237c4.jpg"),
            Card(name: "Force of Will", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/ca/2e/08/ca2e085282f126bcfd73df681dc257ce.jpg"),
            Card(name: "Stephen Colbert", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/3a/d5/23/3ad5232d152e110200fba9c224389439.jpg"),
            Card(name: "Jango Fett", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/1a/52/3b/1a523ba319f2292f9922ec74360eb446.jpg"),
            Card(name: "Trog Dor!! the Burninator", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/3a/ff/e4/3affe4507177d82af4d7821396b5a477.jpg"),
            Card(name: "Gotham City", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/6d/a7/15/6da715c510e8f3a4fbfae62fc050a8df.jpg"),
            Card(name: "Jack Harkness", imageUrlString: "https://i.pinimg.com/564x/10/02/88/1002881ad1f0452130c760af6bb5ade1.jpg"),
            Card(name: "Weeping Angel", imageUrlString: "https://s-media-cache-ak0.pinimg.com/564x/2a/c2/7f/2ac27f46d1e3d46ca867fcb96172b431.jpg")

        ]
    }

    static var realService: CardService?
    static var mockInstance = MockCardDataService()

    var errorResult: Error?

    /// Begins mocking by injecting the mock instance into the RemoteCardService singleton
    /// (but keeping track of the original).
    static func beginMocking() {
        guard let realService = RemoteCardService.shared as? RemoteCardService else {
            return
        }
        MockCardDataService.realService = realService
        RemoteCardService.shared = mockInstance
    }

    /// If we have a reference to the real service, then we inject that into 
    // the RemoteCardService singleton
    static func endMocking() {
        guard let realService = realService else {
            return
        }
        RemoteCardService.shared = realService
    }


}

// MARK: - CardService

extension MockCardDataService: CardService {

    func search(for cardNamed: String, callback: @escaping CardSearchCallback) {

        // Callback wtih an error if that's what we're supposed to do
        if let errorResult = errorResult {
            return DispatchQueue.global(qos: .background).async {
                callback(errorResult, nil)
            }

        }

        let results = Constants.mockCards.filter({ (card) -> Bool in
            return card.name.lowercased().contains(cardNamed.lowercased())
        }).sorted(by: { return $0.name < $1.name })

        DispatchQueue.global(qos: .background).async {
            callback(nil, results)
        }
    }

}

// MARK: - Card Extension

extension Card {

    convenience init(name: String, imageUrlString: String) {
        self.init(from: ["name": name, "imageUrl": imageUrlString])
    }

}
