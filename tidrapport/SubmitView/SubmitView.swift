//
//  SubmitView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-15.
//

import SwiftUI

struct SubmitView: View {
    let projectData: ProjectData
    let dates: [Date]

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let projectData = ProjectData(id: "1", 
                                  hours: 8,
                                  article: "",
                                  customer: "",
                                  project: "",
                                  activity: "",
                                  errandNumber: "",
                                  description: "",
                                  isSubmitted: false)
    return SubmitView(projectData: projectData, dates: [Date()])
}
