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
            ZStack {
                Form {
                    Section(header: Text("Valda datum")) {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.selectedDateStrings, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    Section(header: Text("Information")) {
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
                }
            }
            .navigationTitle("Lägg till tid")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Stäng")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveTimeEntry()
                        path.append("submit")
                    } label: {
                        Text("Spara")
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .navigationDestination(for: String.self) { view in
                        if view == "submit" {
                            SubmitView(viewModel: viewModel.submitViewModel) {
                                successAction()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - DatesGridView

struct DatesGridView: View {
    let items: [String]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)")
                        .padding(6)
                        .background(.red)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    let dates = (0..<13).map { Date().addingTimeInterval(TimeInterval($0 * 86400)) }
    let viewModel = AddTimeViewModel(selectedDates: dates)
    return AddTimeView(viewModel: viewModel, successAction: {})
}
