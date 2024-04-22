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
    @Published var hours: Double = 8
    @Published var article: String = ""
    @Published var customer: String = ""
    @Published var activity: String = ""
    @Published var errandNumber: String = ""
    @Published var description: String = ""

    init(selectedDates: [Date]) {
        self.selectedDates = selectedDates
    }

    func prefillTimeEntry() {
        hours = lastHours
        article = lastArticle
        customer = lastCustomer
        project = lastProject
        activity = lastActivity
        errandNumber = lastErrandNumber
        description = lastDescription
    }

    var timeEntry: TimeEntry {
        TimeEntry(id: 0,
                  date: "",
                  hours: hours,
                  article: Article(id: 0,
                                   name: article),
                  customer: Customer(id: 0,
                                     name: customer),
                  project: Project(id: 0,
                                   name: project),
                  activity: activity,
                  caseNumber: errandNumber,
                  description: description,
                  isSubmitted: false,
                  empId: "Mitt användarId")
    }

    var submitViewModel: SubmitViewModel {
        SubmitViewModel(projectData: timeEntry, dates: selectedDates)
    }

    var selectedDateStrings: [String] {
        selectedDates
            .sorted()
            .map {
            let dayNumber = Calendar.current.component(.day, from: $0)
            let month = Calendar.current.component(.month, from: $0)
            return "\(dayName($0)) \(dayNumber)/\(month)"}
    }

    func saveTimeEntry() {
        UserDefaults.standard.setValue(project, forKey: Key.lastProject)
        UserDefaults.standard.setValue(hours, forKey: Key.lastHours)
        UserDefaults.standard.setValue(article, forKey: Key.lastArticle)
        UserDefaults.standard.setValue(customer, forKey: Key.lastCustomer)
        UserDefaults.standard.setValue(activity, forKey: Key.lastActivity)
        UserDefaults.standard.setValue(errandNumber, forKey: Key.lastErrandNumber)
        UserDefaults.standard.setValue(description, forKey: Key.lastDescription)
    }
}

enum DayName: String {
    case monday = "Måndag"
    case tuesday = "Tisdag"
    case wednesday = "Onsdag"
    case thursday = "Torsdag"
    case friday = "Fredag"
    case saturday = "Lördag"
    case sunday = "Söndag"

    init(_ day: Int) {
        switch day {
        case 1: self = .sunday
        case 2: self = .monday
        case 3: self = .tuesday
        case 4: self = .wednesday
        case 5: self = .thursday
        case 6: self = .friday
        case 7: self = .saturday
        default: self = .monday
        }
    }
}

private extension AddTimeViewModel {

    func dayName(_ date: Date) -> String {
        let dayName = Calendar.current.component(.weekday, from: date)
        return DayName(dayName).rawValue
    }

    var lastProject: String {
        UserDefaults.standard.string(forKey: Key.lastProject) ?? ""
    }

    var lastHours: Double {
        UserDefaults.standard.double(forKey: Key.lastHours)
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
