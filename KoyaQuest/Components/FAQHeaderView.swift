//
//  FAQHeaderView.swift
//  SearchFeatureTest
//
//  Created by Kevin K Collins on 2021/09/11.
//

import SwiftUI

struct FAQHeaderView: View {
        var header: String
        var body: some View {
            HStack {
                Text(header)
                .font(.headline)
                .foregroundColor(.orange)
                    .padding(.leading, 6)
                Spacer()
            }
            .frame(height: 30, alignment: .leading)
            .border(Color.orange, width: 0.5)
            .background(Color(.secondarySystemBackground))
            .padding(.horizontal)
        }
    }

struct FAQHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FAQHeaderView(header: "People")
    }
}
