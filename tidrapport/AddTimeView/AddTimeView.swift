//
//  AddTimeView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-03.
//

import SwiftUI

struct AddTimeView: View {
    @ObservedObject var viewModel: AddTimeViewModel

    var body: some View {
        VStack {
            Text("Lägg till nya tider")
                .font(.title)
                .padding(.top, 8)
            Form {
                Section(header: Text("Valda datum")) {
                    List(viewModel.days, id: \.self) { day in
                        Text(day)
                    }
                }
                Section {
                    TextField("Timmar", value: $viewModel.hours, formatter: NumberFormatter())
                    TextField("Artikel", text: $viewModel.article)
                    TextField("Kund", text: $viewModel.customer)
                    TextField("Projekt", text: $viewModel.project)
                    TextField("Aktivitet", text: $viewModel.activity)
                    TextField("Ärendenummer", text: $viewModel.errandNumber)
                    TextField("Beskrivning", text: $viewModel.description)
                }
                NavigationLink {
                    viewModel.saveProjectData()
                    return SubmitView(projectData: viewModel.projectData,
                                      dates: viewModel.selectedDates)
                } label: {
                    Text("Spara")
                }
            }
        }
    }
}

#Preview {
    let viewModel = AddTimeViewModel(selectedDates: [Date()])
    return AddTimeView(viewModel: viewModel)
}
