//
//  AddTimeView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-03.
//

import SwiftUI

struct AddTimeView: View {
    @ObservedObject var viewModel: AddTimeViewModel
    var successAction: () -> Void
    @State private var path: NavigationPath = NavigationPath()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Form {
                    Section(header: Text("Valda datum")) {
                        List(viewModel.selectedDateStrings, id: \.self) { dateString in
                            Text(dateString)
                        }
                    }
                    Section {
                        VStack(alignment: .leading) {
                            Text("Timmar").fontWeight(.bold)
                            TextField("", value: $viewModel.hours, formatter: NumberFormatter())
                        }
                        LabelTextField(label: "Artikel", text: $viewModel.article)
                        LabelTextField(label: "Kund", text: $viewModel.customer)
                        LabelTextField(label: "Projekt", text: $viewModel.project)
                        LabelTextField(label: "Aktivitet", text: $viewModel.activity)
                        LabelTextField(label: "Ärendenummer", text: $viewModel.errandNumber)
                        LabelTextField(label: "Beskrivning", text: $viewModel.description)
                    }
                    NavigationLink {
                        viewModel.saveProjectData()
                        return SubmitView(viewModel: viewModel.submitViewModel) {
                            successAction()
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Spara")
                    }
                }
            }
            .navigationTitle("Lägg till tid")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Stäng")
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = AddTimeViewModel(selectedDates: [Date()])
    return AddTimeView(viewModel: viewModel, successAction: {})
}
