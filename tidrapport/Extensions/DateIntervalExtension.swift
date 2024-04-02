//
//  DateIntervalExtension.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

extension DateInterval {
    var days: [Date] {
        return stride(from: start, to: end, by: 86400).map { $0 }
    }
}
