//
//  AddTimeViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-05.
//

import Foundation

final class AddTimeViewModel: ObservableObject {
    let selectedDates: [Date]
    @Published var projectName: String = ""
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
        projectName = lastProjectName
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
                    project: projectName,
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
        UserDefaults.standard.set(projectName, forKey: "lastProjectName")
        UserDefaults.standard.set(hours, forKey: "lastHours")
        UserDefaults.standard.set(article, forKey: "lastArticle")
        UserDefaults.standard.set(customer, forKey: "lastCustomer")
        UserDefaults.standard.set(activity, forKey: "lastActivity")
        UserDefaults.standard.set(errandNumber, forKey: "lastErrandNumber")
        UserDefaults.standard.set(description, forKey: "lastDescription")
    }
}

private extension AddTimeViewModel {

    var lastProjectName: String {
        UserDefaults.standard.string(forKey: "lastProjectName") ?? ""
    }

    var lastHours: Float {
        UserDefaults.standard.float(forKey: "lastHours")
    }

    var lastArticle: String {
        UserDefaults.standard.string(forKey: "lastArticle") ?? ""
    }

    var lastCustomer: String {
        UserDefaults.standard.string(forKey: "lastCustomer") ?? ""
    }

    var lastActivity: String {
        UserDefaults.standard.string(forKey: "lastActivity") ?? ""
    }

    var lastErrandNumber: String {
        UserDefaults.standard.string(forKey: "lastErrandNumber") ?? ""
    }

    var lastDescription: String {
        UserDefaults.standard.string(forKey: "lastDescription") ?? ""
    }

    func clearProjectData() {
        UserDefaults.standard.removeObject(forKey: "lastProjectName")
        UserDefaults.standard.removeObject(forKey: "lastHours")
        UserDefaults.standard.removeObject(forKey: "lastArticle")
        UserDefaults.standard.removeObject(forKey: "lastCustomer")
        UserDefaults.standard.removeObject(forKey: "lastActivity")
        UserDefaults.standard.removeObject(forKey: "lastErrandNumber")
        UserDefaults.standard.removeObject(forKey: "lastDescription")
    }
}
