//
//  EventsViewController.swift
//  Coursework
//
//  Created by Ksenia Petrova on 30.04.2022.
//

import Foundation
import SwiftUI
struct EventsView: View {
    @State private var searchProperties: Set<String> = []
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    SearchBar(searchText: "Find our event", isSearching: false).padding(.bottom, 8)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            CustomButton(searchProperties: $searchProperties, text: "Free", width: 80, height: 10)
                            CustomButton(searchProperties: $searchProperties, text: "Today", width: 80, height: 10)
                            CustomButton(searchProperties: $searchProperties, text: "Near", width: 80, height: 10)
                        }
                    }.padding(.leading, 20)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            EventsView().preferredColorScheme($0)
        }
    }
}
