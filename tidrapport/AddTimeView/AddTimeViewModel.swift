//
//  AddTimeViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-05.
//

import Foundation

final class AddTimeViewModel: ObservableObject {
    let selectedDates: [Date]
    @Published var project: String = ""
    @Published var hours: Float = 0
    @Published var article: String = ""
    @Published var customer: String = ""
    @Published var activity: String = ""
    @Published var errandNumber: String = ""
    @Published var description: String = ""

    init(selectedDates: [Date]) {
        self.selectedDates = selectedDates
    }

    func prefillProjectData() {
        hours = lastHours
        article = lastArticle
        customer = lastCustomer
        project = lastProject
        activity = lastActivity
        errandNumber = lastErrandNumber
        description = lastDescription
    }

    var projectData: ProjectData {
        ProjectData(id: UUID().uuidString,
                    date: nil,
                    hours: hours,
                    article: article,
                    customer: customer,
                    project: project,
                    activity: activity,
                    errandNumber: errandNumber,
                    description: description,
                    isSubmitted: false)
    }

    var days: [String] {
        selectedDates.map {
            let day = Calendar.current.component(.day, from: $0)
            let month = Calendar.current.component(.month, from: $0)
            return "\(day)/\(month)"}
    }

    func saveProjectData() {
        UserDefaults.standard.setValue(project, forKey: Key.lastProject)
        UserDefaults.standard.setValue(hours, forKey: Key.lastHours)
        UserDefaults.standard.setValue(article, forKey: Key.lastArticle)
        UserDefaults.standard.setValue(customer, forKey: Key.lastCustomer)
        UserDefaults.standard.setValue(activity, forKey: Key.lastActivity)
        UserDefaults.standard.setValue(errandNumber, forKey: Key.lastErrandNumber)
        UserDefaults.standard.setValue(description, forKey: Key.lastDescription)
    }
}

private extension AddTimeViewModel {

    var lastProject: String {
        UserDefaults.standard.string(forKey: Key.lastProject) ?? ""
    }

    var lastHours: Float {
        UserDefaults.standard.float(forKey: Key.lastHours)
    }

    var lastArticle: String {
        UserDefaults.standard.string(forKey: Key.lastArticle) ?? ""
    }

    var lastCustomer: String {
        UserDefaults.standard.string(forKey: Key.lastCustomer) ?? ""
    }

    var lastActivity: String {
        UserDefaults.standard.string(forKey: Key.lastActivity) ?? ""
    }

    var lastErrandNumber: String {
        UserDefaults.standard.string(forKey: Key.lastErrandNumber) ?? ""
    }

    var lastDescription: String {
        UserDefaults.standard.string(forKey: Key.lastDescription) ?? ""
    }

    func clearProjectData() {
        UserDefaults.standard.removeObject(forKey: Key.lastProject)
        UserDefaults.standard.removeObject(forKey: Key.lastHours)
        UserDefaults.standard.removeObject(forKey: Key.lastArticle)
        UserDefaults.standard.removeObject(forKey: Key.lastCustomer)
        UserDefaults.standard.removeObject(forKey: Key.lastActivity)
        UserDefaults.standard.removeObject(forKey: Key.lastErrandNumber)
        UserDefaults.standard.removeObject(forKey: Key.lastDescription)
    }
}

// MARK: - Key

private extension AddTimeViewModel {

    struct Key {
        static let lastProject = "lastProject"
        static let lastHours = "lastHours"
        static let lastArticle = "lastArticle"
        static let lastCustomer = "lastCustomer"
        static let lastActivity = "lastActivity"
        static let lastErrandNumber = "lastErrandNumber"
        static let lastDescription = "lastDescription"
    }
}
