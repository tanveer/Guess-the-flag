//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tanveer Bashir on 10/20/19.
//  Copyright © 2019 Tanveer Bashir. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white).font(.title)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle).fontWeight(.black)
                    }
                    ForEach(0..<4){ number in
                        Button(action: {
                            self.flagTapped(number)
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original).clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                Text("Score: \(score)").foregroundColor(.white).font(.largeTitle)
                Spacer()
                }.alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Play again!")){
                            self.askQuestion()
                        })
                }
         }
    }

    private func flagTapped(_ number: Int){
        if number == correctAnswer {
            score += 1
            self.scoreTitle = "Correct!"
            self.message = "Congratulation!! your score is \(score)"
        } else {
            score -= 1
            self.scoreTitle = "Wrong"
            self.message = "Oh snap! that's the flag of \(countries[number].uppercased())"
        }
        self.showingScore.toggle()
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    private func randomNumber() -> Int {
        return Int.random(in: 0..<countries.count)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
