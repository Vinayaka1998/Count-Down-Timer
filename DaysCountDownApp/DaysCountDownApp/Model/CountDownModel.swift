//
//  DaysCountModel.swift
//  DaysCountDownApp
//
//  Created by Vinayaka on 13/03/24.
//

import Foundation

//MARK: - Count down timer model.
struct CountdownTimer: Codable {
    var days: Int
    var hours: Int
    var minutes: Int
    var seconds: Int
}
