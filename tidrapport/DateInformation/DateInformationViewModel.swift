//
//  DateInformationViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-19.
//

import Foundation

final class DateInformationViewModel {
    private var timeEntry: TimeEntry?

    init(timeEntry: TimeEntry?) {
        self.timeEntry = timeEntry
    }

    var informationString: String? {
        guard let timeEntry = timeEntry else { return nil }
        return "Kund: \(timeEntry.customer.name)\nTid: \(timeEntry.hours)"
    }
}
