//
//  ContentView.swift
//  QuizScore
//
//  Created by benjamin on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    let questionAnswer = [
        ["All spiders have eight eyes","False"],
        ["A group of crows is called a murder", "True"],
        ["Sharks can blink with both eyes", "False"],
        ["Dolphins sleep with one eye open", "True"],
        ["Ostriches can run faster than horses", "True"],
        ["Bats are mammals", "True"],
    ]
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack{
                Text("Quiz Time")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
                
                ForEach(0..<2) { index in
                    Text("Question \(index)/" + String(questionAnswer.count))
                        .padding()
                    Spacer()
                    Text(questionAnswer[index][0])
                    Spacer()
                    
                    HStack {
                        AnswerButton(text: "\(questionAnswer[0][1])")
                    }
                }
                
                
            }
        }
        
        
    }
}

struct AnswerButton: View {
    let text: String
    var body: some View {
        Button(action: {
            print("You selected " + text)
        }) {
            Text(text)
        }
        .padding()
        .border(Color.red, width: 10)
    }
}
#Preview {
    ContentView()
}
