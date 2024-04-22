//
//  DateInformationViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-19.
//

import Foundation

final class DateInformationViewModel {
    private var timeEntry: TimeEntry?
    var extraInfo: String?

    init(timeEntry: TimeEntry?, extraInfo: String? = nil) {
        self.timeEntry = timeEntry
        self.extraInfo = extraInfo
    }

    var title: String {
        guard let timeEntry = timeEntry else { return "Ingen tidrapport" }
        return "Tidrapport för \(timeEntry.date)"
    }

    var informationStrings: [String]? {
        guard let timeEntry = timeEntry else { return nil }
        return [
            "Kund: \(timeEntry.customer.name)",
            timeEntry.project.map { "Projekt: \($0.name)" },
            "Tid: \(timeEntry.hours) timmar",
            timeEntry.description.map { "Beskrivning: \($0)" },
            timeEntry.activity.map { "Aktivitet: \($0)" },
            timeEntry.caseNumber.map { "Ärendenummer: \($0)" },
            "Artikel: \(timeEntry.article.name)",
            "Inlämnad: \(timeEntry.isSubmitted ? "Ja" : "Nej")",
            "Anställd: \(timeEntry.empId)",
        ].compactMap { $0 }
    }
}
