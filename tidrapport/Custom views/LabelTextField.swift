//
//  LabelTextField.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-18.
//

import SwiftUI

struct LabelTextField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label).fontWeight(.bold)
            TextField("", text: $text)
        }
    }
}

#Preview {
    @State var text: String = ""
    return LabelTextField(label: "Kund", text: $text)
}
