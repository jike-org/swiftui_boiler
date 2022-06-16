//
//  Main.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-08.
//

import SwiftUI

struct MainView: View {
    @State var showSidebar = false
    @State var Destination : AnyView? = AnyView(HomeView())
    
    var body: some View {
        NavigationView{
            ZStack{
                if showSidebar{
                    SideMenuView(showSidebar: $showSidebar, selection: $Destination)
                        .navigationBarHidden(true)
                }
                Destination
                    .transition(.move(edge: .bottom))
                    .modifier(MenuButton(showSidebar: $showSidebar))
//                HomeView()
//                    .transition(.move(edge: .bottom))
//                    .modifier(MenuButton(showSidebar: $showSidebar))
//                    .navigationTitle("Home")
            }
            .onAppear{
                if showSidebar{
                    showSidebar.toggle()
                }
            }
        }
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



struct HomeView : View{
    var viewName : String = "Home"
    var body: some View {
        ZStack{
            Color.white
            Text("wellcome")
            TabView {
                DetailsView(viewName: "Tab 1")
                           .tabItem {
                               Label("Menu", systemImage: "list.dash")
                           }

                DetailsView(viewName: "Tab 2")
                           .tabItem {
                               Label("Order", systemImage: "square.and.pencil")
                           }
            }.navigationTitle(viewName)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


struct DetailsView : View{
    var viewName : String
    var body: some View {
        ZStack {
            Color.white
            HStack{
                Text(viewName)
            }
            .navigationTitle(viewName)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

