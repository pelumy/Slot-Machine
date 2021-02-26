//
//  ContentView.swift
//  Slot Machine
//
//  Created by Itunu Raimi on 25/02/2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    @State private var coins = 100
    @State private var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var betAmount = 10
    @State private var reels = [0, 1, 2]
    @State private var showingInfoView = false
    @State private var isActivebet10 = true
    @State private var isActivebet20 = false
    @State private var showingModal = false
    
    // MARK: - FUNCTIONS
    
    // spin the reels
    func spinReels() {
        
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    // check the winnings
    func checkWinings() {
        if reels[0] == reels[1] && reels[1] == reels[2]  && reels[0] == reels[2] {
            // player wins
            playerWins()
            // new highscore
            if coins > highScore {
                newHighScore()
            }
            
        } else {
            // player loses
            playerLoses() 
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func newHighScore() {
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActivebet20 = true
        isActivebet10 = false
    }
    
    func activateBet10() {
        betAmount = 10
        isActivebet10 = true
        isActivebet20 = false
    }
    
    // game is over
    func isGameOver() {
        if coins <= 0 {
            // show modal window
            showingModal.toggle()
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
    }
    
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
                        
                        Text(String(coins))
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }) //: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        Text(String(highScore))
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("Your\nHighScore".uppercased())
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
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: nil, content: {
                        // MARK: - REEL 2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                    }) //: HSTACK
                    .frame(maxWidth: 500)
                    
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                       spinReels()
                        checkWinings()
                        isGameOver()
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
                HStack(alignment: .center, spacing: 10) {
                    HStack {
                        // MARK: - BET 20
                        Button(action: {
                            activateBet20()
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivebet20 ? Color("ColorYellow") :  .white)
                                .modifier(BetNumberModifier())
                        }) // button
                        .modifier(BetCapsuleModifier())
                         
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActivebet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        // MARK: - BET 10
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActivebet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            activateBet10()
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActivebet10 ? Color("ColorYellow") :  .white)
                                .modifier(BetNumberModifier())
                        }) // button
                        .modifier(BetCapsuleModifier())
                         
                    }
                } // Footer
                
            }) //: VSTACK
            
            // MARK: - BUTTONS
            .overlay(
                // RESET
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            , alignment: .topLeading
            ) // OVERLAY
            
            .overlay(
                // INFO
                Button(action: {
                    showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            , alignment: .topTrailing
            ) // OVERLAY
            
            
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: showingModal ? 5 : 0)
            
            // MARK: - POPUP
            if showingModal {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    // modal
                    VStack(alignment: .center, spacing: nil, content: {
                        
                        // title
                        Text("Game Over".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("ColorPink"))
                        
                        Spacer()
                        
                        // message
                        VStack(alignment: .center, spacing: 16, content: {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                showingModal = false
                                coins = 100
                            }, label: {
                                Text(" New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            })
                        }) // vstack
                        
                        Spacer()
                        
                    })
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                } // zstack
            }
            
        } //: ZSTACK
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
