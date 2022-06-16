//
//  File.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-31.
//

import SwiftUI


struct Validate: ViewModifier {
    
    var text: String
    var text2: String?
    var validation : (String, String?) -> ValidationStatus
    
    @State var active = false
    @State var latestValidation: ValidationStatus = .standard
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .onTapGesture {
                    active = true
                }
            Group{
                if active {
                    switch validation(text, text2) {
                    case .success:
                         AnyView(EmptyView())
                    case .failure(let message):
                        let text = Text(message)
                            .foregroundColor(Color.red)
                            .font(.caption)
                         AnyView(text)
                    case .standard:
                        AnyView(EmptyView())
                    }
                }
            }
        }
    }
}



extension View {
    func validate(with text: String,  text2: String? = nil, validation: @escaping (String, String?) ->  ValidationStatus ) -> some View {
        self.modifier(Validate(text: text, text2: text2, validation: validation))
    }
}

enum ValidationStatus {
    case standard
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
