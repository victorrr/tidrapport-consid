//
//  AddTimeViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-05.
//

import Foundation

final class AddTimeViewModel {
    private let selectedDates: [Date]

    init(selectedDates: [Date]) {
        self.selectedDates = selectedDates
    }

    var days: [String] { selectedDates.map { "\(Calendar.current.component(.day, from: $0))/\(Calendar.current.component(.month, from: $0))"} }
}
