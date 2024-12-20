//
//  APIEndpoint.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/12/24.
//

import Foundation

struct APIEndpoint{

    static let BaseURL = "https://api.coingecko.com"
    static let CoinsApiPath = "/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
}
