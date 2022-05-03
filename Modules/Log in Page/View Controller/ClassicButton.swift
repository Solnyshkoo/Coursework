//
//  ClassicTextField.swift
//  Course
//
//  Created by Ksenia Petrova on 09.03.2022.
//

import Foundation
import SwiftUI

struct ClassicButton: View {
    var text: String

    
    var body: some View {
        Button(action: {}) {
            Text(text).fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .padding(8)
                .border(Color.purple, width: 5)
        }
    }
}

struct ClassicButton_Previews: PreviewProvider {
    static var previews: some View {
        ClassicButton(text: "Привет")
    }
}
