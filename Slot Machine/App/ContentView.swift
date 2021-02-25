//
//  ContentView.swift
//  Slot Machine
//
//  Created by Itunu Raimi on 25/02/2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5, content: {
                // MARK: - HEADER
                LogoView()
                Spacer()
                // MARK: - SCORE
                HStack {
                    HStack(alignment: .center, spacing: nil, content: {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }) //: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading )
                        
                    }) //: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                } //: HSTACK
                
                // MARK: - SLOT MACHINE
                
                VStack(alignment: .center, spacing: nil, content: {
                    // MARK: - REEL 1
                    ZStack {
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        // MARK: - REEL 2
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                    }) //: HSTACK
                    .frame(maxWidth: 500)
                    
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        
                    }, label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                    
                }) // Slot Machine
                .layoutPriority(2)
                
                // MARK: - FOOTER
                Spacer()
            }) //: VSTACK
            
            // MARK: - BUTTONS
            .overlay(
                // RESET
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            , alignment: .topLeading
            ) // OVERLAY
            
            .overlay(
                // INFO
                Button(action: {
                    
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            , alignment: .topTrailing
            ) // OVERLAY
            
            
            .padding()
            .frame(maxWidth: 720)
            
            // MARK: - POPUP
            
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
