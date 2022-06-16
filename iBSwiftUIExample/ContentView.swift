//
//  ContentView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-02.
//

import SwiftUI
import Combine

public let Authenticated = PassthroughSubject<Bool, Never>()

public func IsAuthenticated() -> Bool {
    return PersistenceController.shared.loadUserData() != nil
}

struct ContentView: View {
    @State var isAuthenticated = IsAuthenticated()
    @ObservedObject var loginViewModel = LoginVM()
    
    var body: some View {
        Group {
            if isAuthenticated {
                MainView()
            } else {
                LoginView(viewModel: loginViewModel)
            }
        }
        .onReceive(Authenticated, perform: {
            isAuthenticated = $0
        })
    }    
}
