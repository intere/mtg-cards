# MTG Cards

[![Build Status](https://travis-ci.org/intere/mtg-cards.svg?branch=develop)](https://travis-ci.org/intere/mtg-cards)

A Demo app that searches api.magicthegathering.io for [Magic the Gathering](https://magic.wizards.com/en) cards and shows you those cards.

## Features
- Simple UI to search for cards by name and present the results, visually (see screenshot below)
- Unit / Integration Tests
    - Unit Tests to validate some units of code
    - Integration Tests to validate UI behavior (with a mock data source)
- Fastlane integration (for running the tests, headlessly)
- Travis CI integration (see badge above) to test pull requests and main branch

## Integration Points
- RVM (recommended) for managing ruby / gem sets
- Cocoapods (1.4.0)
    - Kingfisher (for image loading)
    - UITestKit (for driving UI Tests)
- Fastlane (simple method to run unit tests)

## TODO
- [x] Update this README (with screenshots, using https://www.cockos.com/licecap/)
- [x] Add a Github PR Template
- [x] Add Travis CI (with badge): [PR #4](https://github.com/intere/mtg-cards/pull/4)
- [ ] Add some more UIs to this app (card selection 👉 push a Card View to the navigation controller)


## Screenshot
![Demo](https://github.com/intere/mtg-cards/blob/develop/screenshots/mtg-cards-demo.gif?raw=true)
