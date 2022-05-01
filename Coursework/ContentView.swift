//
//  ContentView.swift
//  Coursework
//
//  Created by Ksenia Petrova on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showingAlert = false
    var body: some View {
        Circle();
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
