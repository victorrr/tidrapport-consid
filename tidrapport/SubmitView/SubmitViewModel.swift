//
//  SubmitViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-17.
//

import Foundation

final class SubmitViewModel: ObservableObject {
    @Published var projectData: TimeEntry
    @Published var dates: [Date]
    @Published var isLoading = false
    @Published var isSuccessful = false
    @Published var isError = false

    init(projectData: TimeEntry, dates: [Date]) {
        self.projectData = projectData
        self.dates = dates
    }

    func submitData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.isLoading = false
            self.isSuccessful = true
        }
    }
}
