//
//  SearchBarView.swift
//  SearchFeatureTest
//
//  Created by Kevin K Collins on 2021/08/17.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)

                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                    // swiftlint:disable multiple_closures_with_trailing_closure
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }

                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                        to: nil,
                                                        from: nil,
                                                        for: nil
                        )

                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: true)
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
