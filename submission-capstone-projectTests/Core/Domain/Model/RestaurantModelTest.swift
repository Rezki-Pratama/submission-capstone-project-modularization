//
//  RestaurantModelTest.swift
//  submission-capstone-projectTests
//
//  Created by Rezki Pratama on 22/11/22.
//

import XCTest
@testable import submission_capstone_project

class RestaurantModelTest: XCTestCase {

  func testRestaurantModelSuccessParser() {
      let fakeRestaurantResponse = RestaurantResponse.fake()
      let json = """
                {
                      "id": "rqdv5juczeskfw1e867",
                      "name": "Melting Pot",
                      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                      "city": "Medan",
                      "address": "Jln. Pandeglang no 19",
                      "pictureId": "14",
                      "categories": [
                          {
                              "name": "Italia"
                          }
                      ],
                      "menus": {
                          "foods": [
                              {
                                  "name": "Paket rosemary"
                              }
                          ],
                          "drinks": [
                              {
                                  "name": "Es krim"
                              }
                          ]
                      },
                      "rating": 4.2,
                      "customerReviews": [
                          {
                              "name": "Ahmad",
                              "review": "Tidak rekomendasi untuk pelajar!",
                              "date": "13 November 2022"
                          }
                      ]
                  }
          """.data(using: .utf8)
      
      let restaurant = try! JSONDecoder().decode(RestaurantResponse.self, from: json!)
      XCTAssertNotNil(restaurant)
    XCTAssertEqual(restaurant.id, fakeRestaurantResponse.id)
  }

}
