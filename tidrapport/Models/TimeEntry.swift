//
//  CalendarData.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

struct TimeEntry: Decodable, Hashable, Identifiable {
    let id: Int
    let date: String
    let hours: Double
    let article: Article
    let customer: Customer
    let project: Project?
    let activity: String?
    let caseNumber: String?
    let description: String?
    let isSubmitted: Bool
    let empId: String

    enum CodingKeys: String, CodingKey {
        case id = "timeRowId"
        case date
        case hours
        case article
        case customer
        case project
        case activity
        case caseNumber
        case description
        case isSubmitted
        case empId
    }
}

struct Article: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "articleId"
        case name
    }
}

struct Customer: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "customerId"
        case name
    }
}

struct Project: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "projectId"
        case name
    }
}
