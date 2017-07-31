//
//  URLSessionPrototypingTest.swift
//  MTG Cards
//
//  Created by Eric Internicola on 7/31/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import XCTest


/// This class contains a set of blackbox tests that demonstrate how to use URLSession to 
/// perform an HTTP GET of a secure and insecure HTTP server
class URLSessionPrototypingTest: XCTestCase {

    struct Constants {
        static let googleSecure = URL(string: "https://www.google.com")!
        static let googleInsecure = URL(string: "http://www.google.com")!

        static let invalidDomainSecure = URL(string: "https://a.b.c.d.e.f.g.com")!

        static let notFoundSecure = URL(string: "https://www.google.com/a/b/c/d/e/f/g")!

        /// A session configuration that uses no persistent storage for caches, cookies, or credentials.
        static let noCaching = URLSessionConfiguration.ephemeral
    }
    
}

// MARK: - HTTP Secure (Happy Path)

extension URLSessionPrototypingTest {

    /// Demonstrates how we communicate securely with an HTTPS server (Happy Path)
    func testGetSecureHttpData() {

        // 1. Create a URLSession that doesn't use caching
        let connection = URLSession(configuration: Constants.noCaching)

        // 2. Create a URLRequest (ignore all caching) and specify a 10 second timeout
        let request = URLRequest(url: Constants.googleSecure, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)

        // 3.  Because this task will execute asynchronously, we need to wait for it
        let exp = expectation(description: "HTTPS Data Task")

        // 4.  Create the data task with a callback handler (uses block syntax)
        let dataTask = connection.dataTask(with: request) { (data, response, error) in
            defer {
                // After we've validated, tell the expectation that we've completed
                // `defer` will before the block exits
                exp.fulfill()
            }

            // If the error is not nil, then we've got a problem
            if let error = error {
                return XCTFail("Failed with error: \(error)")
            }

            // Ensure the response object is an HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                return XCTFail("We received an invalid response object type: \(type(of: response))")
            }

            // Ensure we got a 200 response
            guard httpResponse.statusCode == 200 else {
                return XCTFail("Received an unexpected status code: \(httpResponse.statusCode)")
            }

            // Ensure we have received data back
            guard let data = data else {
                return XCTFail("We didn't receive any data back")
            }

            guard let payload = String(data: data, encoding: .unicode) else {
                return XCTFail("The payload could not be converted to a UTF-8 String")
            }

            print(payload)
        }

        // 5.  Tell the data task to start
        dataTask.resume()

        // 6. Wait for the expectations to complete
        waitForExpectations(timeout: 10)

    }

}

// MARK: - HTTP Secure (Rainy Paths)

extension URLSessionPrototypingTest {

    /// Demonstrates how we communicate securely with an HTTPS server (Happy Path)
    func testGetSecureHttp404() {

        // 1. Create a URLSession that doesn't use caching
        let connection = URLSession(configuration: Constants.noCaching)

        // 2. Create a URLRequest (ignore all caching) and specify a 10 second timeout
        let request = URLRequest(url: Constants.notFoundSecure, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)

        // 3.  Because this task will execute asynchronously, we need to wait for it
        let exp = expectation(description: "HTTPS Data Task")

        // 4.  Create the data task with a callback handler (uses block syntax)
        let dataTask = connection.dataTask(with: request) { (data, response, error) in
            defer {
                // After we've validated, tell the expectation that we've completed
                // `defer` will before the block exits
                exp.fulfill()
            }

            // If the error is not nil, then we've got a problem
            if let error = error {
                return XCTFail("Failed with error: \(error)")
            }

            // Ensure the response object is an HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                return XCTFail("We received an invalid response object type: \(type(of: response))")
            }

            // Ensure we got a 404 response
            guard httpResponse.statusCode == 404 else {
                return XCTFail("Received an unexpected status code: \(httpResponse.statusCode)")
            }

            // Ensure we have received data back
            guard let data = data else {
                return XCTFail("We didn't receive any data back")
            }

            guard let payload = String(data: data, encoding: .unicode) else {
                return XCTFail("The payload could not be converted to a UTF-8 String")
            }

            print(payload)
        }

        // 5.  Tell the data task to start
        dataTask.resume()
        
        // 6. Wait for the expectations to complete
        waitForExpectations(timeout: 10)
        
    }

    /// Validates that we're handling an error case where we supply an invalid domain name
    func testGetInvalidDomain() {
        // 1. Create a URLSession that doesn't use caching
        let connection = URLSession(configuration: Constants.noCaching)

        // 2. Create a URLRequest (ignore all caching) and specify a 10 second timeout
        let request = URLRequest(url: Constants.invalidDomainSecure, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)

        // 3.  Because this task will execute asynchronously, we need to wait for it
        let exp = expectation(description: "HTTPS Data Task")

        // 4.  Create the data task with a callback handler (uses block syntax)
        let dataTask = connection.dataTask(with: request) { (data, response, error) in
            defer {
                // After we've validated, tell the expectation that we've completed
                // `defer` will before the block exits
                exp.fulfill()
            }

            // If the error is not nil, then we've got a problem
            guard let error = error else {
                return XCTFail("We did not fail with an error")
            }

            // Success Case!
            print("Invalid Domain Error: \(error)")
        }

        // 5.  Tell the data task to start
        dataTask.resume()
        
        // 6. Wait for the expectations to complete
        waitForExpectations(timeout: 10)
    }

}

// MARK: - HTTP


extension URLSessionPrototypingTest {

    /// Demonstrates how we communicate securely with an HTTPS server (Happy Path)
    func testGetInsecureHttpData() {

        // 1. Create a URLSession that doesn't use caching
        let connection = URLSession(configuration: Constants.noCaching)

        // 2. Create a URLRequest (ignore all caching) and specify a 10 second timeout
        let request = URLRequest(url: Constants.googleInsecure, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)

        // 3.  Because this task will execute asynchronously, we need to wait for it
        let exp = expectation(description: "HTTPS Data Task")

        // 4.  Create the data task with a callback handler (uses block syntax)
        let dataTask = connection.dataTask(with: request) { (data, response, error) in
            defer {
                // After we've validated, tell the expectation that we've completed
                // `defer` will before the block exits
                exp.fulfill()
            }

            // If the error is not nil, then we've got a problem
            if let error = error {
                return XCTFail("Failed with error: \(error)")
            }

            // Ensure the response object is an HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                return XCTFail("We received an invalid response object type: \(type(of: response))")
            }

            // Ensure we got a 200 response
            guard httpResponse.statusCode == 200 else {
                return XCTFail("Received an unexpected status code: \(httpResponse.statusCode)")
            }

            // Ensure we have received data back
            guard let data = data else {
                return XCTFail("We didn't receive any data back")
            }

            guard let payload = String(data: data, encoding: .unicode) else {
                return XCTFail("The payload could not be converted to a UTF-8 String")
            }

            print(payload)
        }

        // 5.  Tell the data task to start
        dataTask.resume()
        
        // 6. Wait for the expectations to complete
        waitForExpectations(timeout: 10)
        
    }
    
}
