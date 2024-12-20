//
//  CryptoTrendsTests.swift
//  CryptoTrendsTests
//
//  Created by Bhuiyan Wasif on 12/9/24.
//

import XCTest
@testable import CryptoTrends

final class CryptoTrendsTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var dummyNetworkManager: DummyNetworkManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
        dummyNetworkManager = nil
    }

    func testExample() throws {
        
    }

    func testCoinList_whenInputIsValid() throws {
        let expectation = expectation(description: "Coin List")
        let waitDuration = 2.0
        
        //given
        
        dummyNetworkManager = DummyNetworkManager()
        dummyNetworkManager.urlPath = "CryptoDummyData"
        
        //when
        //in the init of homeViewModel, we are fetching the coin list
        homeViewModel = HomeViewModel(networkManager: dummyNetworkManager)
        
        //then
        DispatchQueue.main.async{
            XCTAssertNotNil(self.homeViewModel)
            XCTAssertEqual(self.homeViewModel.allCoins.count, 3)
            XCTAssertGreaterThan(self.homeViewModel.allCoins.count, 0)
            
            let coin = self.homeViewModel.allCoins.first!
            XCTAssertEqual(coin.id, "bitcoin")
            XCTAssertEqual(coin.symbol, "btc")
            XCTAssertEqual(coin.name, "Bitcoin")
            XCTAssertEqual(coin.currentPrice, 95055)
            XCTAssertEqual(coin.marketCapRank, 1)
            XCTAssertEqual(coin.high24H, 98328)
            XCTAssertEqual(coin.low24H, 94541)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testGetCoinsList_whenInputIsWrong() throws {
        let expectation = self.expectation(description: "Wrong Input")
        let waitDuration = 2.0
        //given
        dummyNetworkManager = DummyNetworkManager()
        dummyNetworkManager.urlPath = "wrongUrl"
        homeViewModel = HomeViewModel(networkManager: dummyNetworkManager)
        
        
        //then
        DispatchQueue.main.async{
            XCTAssertNotNil(self.homeViewModel)
            XCTAssertEqual(self.homeViewModel.allCoins.count, 0)
            
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testGetCoinsList_WithParsingIssue() throws {
        let expectation = self.expectation(description: "Parsing Issue")
        let waitDuration = 2.0
        //given
        dummyNetworkManager = DummyNetworkManager()
        dummyNetworkManager.urlPath = "ParsingIssueCryptoDummyData"
        homeViewModel = HomeViewModel(networkManager: dummyNetworkManager)
        
        
        //then
        DispatchQueue.main.async{
            XCTAssertNotNil(self.homeViewModel)
            XCTAssertEqual(self.homeViewModel.allCoins.count, 0)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }

}
