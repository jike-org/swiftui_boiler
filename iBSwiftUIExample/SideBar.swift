//
//  SideBar.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-08.
//

import SwiftUI

struct SideBarStack<SidebarContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .leading) {
                sidebarContent
                    .frame(width: sidebarWidth, alignment: .center)
                    .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                    .animation(Animation.easeInOut.speed(2))
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onEnded({ value in
                                            if value.translation.width < 0 {
                                                // left
                                                showSidebar.toggle()
                                            }

                                            if value.translation.width > 0 {
                                                // right
                                                showSidebar.toggle()
                                            }
                                            if value.translation.height < 0 {
                                                // up
                                            }

                                            if value.translation.height > 0 {
                                                // down
                                            }
                                        }))
                mainContent
                    .overlay(
                        Group {
                            if showSidebar {
                                Color.white
                                    .opacity(showSidebar ? 0.01 : 0)
                                    .onTapGesture {
                                        self.showSidebar = false
                                    }
                            } else {
                                Color.clear
                                .opacity(showSidebar ? 0 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                            }
                        }
                    )
                    .offset(x: showSidebar ? sidebarWidth : 0, y: 0)
                    .animation(Animation.easeInOut.speed(2))
                    
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        })
        
    }
}
