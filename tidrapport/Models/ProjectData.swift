//
//  CalendarData.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

struct ProjectData: Hashable, Identifiable {
    var id: String
    var date: String
    var hours: String
    var project: String
    var description: String
    var isBillable: Bool
    var isSubmitted: Bool
}
