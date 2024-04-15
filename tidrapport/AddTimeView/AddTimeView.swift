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
            Text("Valda datum")
                .font(.title)
                .padding(.top, 8)
            List(viewModel.days, id: \.self) { day in
                Text(day)
            }
            Form {
                Section(header: Text("Project Information")) {
                    TextField("Hours", value: $viewModel.hours, formatter: NumberFormatter())
                    TextField("Article", text: $viewModel.article)
                    TextField("Customer", text: $viewModel.customer)
                    TextField("Project Name", text: $viewModel.projectName)
                    TextField("Activity", text: $viewModel.activity)
                    TextField("Errand Number", text: $viewModel.errandNumber)
                    TextField("Description", text: $viewModel.description)
                }
                NavigationLink {
                    viewModel.saveProjectData()
                    return SubmitView(projectData: viewModel.projectData,
                               dates: viewModel.selectedDates)
                } label: {
                    Text("Submit")
                }
            }
        }
        .onAppear(perform: {
            viewModel.prefillProjectData()
        })
    }
}

#Preview {
    let viewModel = AddTimeViewModel(selectedDates: [])
    return AddTimeView(viewModel: viewModel)
}
