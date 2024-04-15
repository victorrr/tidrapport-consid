//
//  CalendarData.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

struct ProjectData: Hashable, Identifiable {
    var id: String
    var date: Date?
    var hours: Float
    var article: String
    var customer: String
    var project: String
    var activity: String
    var errandNumber: String
    var description: String
    var isSubmitted: Bool
}
