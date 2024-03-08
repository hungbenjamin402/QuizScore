import SwiftUI

struct ContentView: View {
    @State private var question: Question
    @State private var selectedAnswer: String? = nil
    @State private var score = 0
    @State private var timeRemaining = 30
    @State private var timer: Timer?
    
    init(question: Question) {
        self._question = State(initialValue: question)
    }
    
    var body: some View {
        ZStack {
            Color(hex: 0x313b5c)
                .ignoresSafeArea()
            VStack {
                HStack (spacing: 130, content: {
                    Text("Quiz Time")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                })
                
                Spacer()
                
                
                Text(question.question)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding()

                Spacer()
                
                Text("Time: \(timeRemaining)s")
                    .onAppear(perform: startTimer)
                    .foregroundColor(.white)
                
                HStack {
                    AnswerButton(answer: "True", isSelected: $selectedAnswer, correctAnswer: question.correctAnswer) {
                        processAnswer("True")
                    }
                    .background(selectedAnswer == "True" ? colorForButton(correctAnswer: "True") : Color.white)
                    .cornerRadius(10)
                    
                    AnswerButton(answer: "False", isSelected: $selectedAnswer, correctAnswer: question.correctAnswer) {
                        processAnswer("False")
                    }
                    .background(selectedAnswer == "False" ? colorForButton(correctAnswer: "False") : Color.white)
                    .cornerRadius(10)
                }
                
            }
        }
    }
    
    func processAnswer(_ answer: String) {
        selectedAnswer = answer
        stopTimer()
        
        if answer == question.correctAnswer {
            score += 1
            goToNextQuestion()
        } else {
            generateNewQuestion()
        }
    }
    
    func goToNextQuestion() {
        if let currentIndex = Question.allQuestions.firstIndex(where: { $0.question == question.question }),
           currentIndex + 1 < Question.allQuestions.count {
            question = Question.allQuestions[currentIndex + 1]
        } else {
            // Reset to first question or show completion if at the end of the array
            question = Question.allQuestions.first!
        }
        resetForNextQuestion()
    }
    
    func generateNewQuestion() {
        question = Question.allQuestions.randomElement()!
        resetForNextQuestion()
    }
    
    func resetForNextQuestion() {
        selectedAnswer = nil
        startTimer()
    }
    
    func startTimer() {
        timeRemaining = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
                // Automatically go to next question or generate new question when time expires
                self.generateNewQuestion()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func colorForButton(correctAnswer: String) -> Color {
        if let selected = selectedAnswer, selected == question.correctAnswer {
            return .green
        } else if let selected = selectedAnswer, selected != question.correctAnswer {
            return .red
        } else {
            return .blue
        }
    }
}

struct AnswerButton: View {
    let answer: String
    @Binding var isSelected: String?
    let correctAnswer: String
    let onClick: () -> Void
    
    var body: some View {
        Button(action: {
            onClick()
        }, label: {
            Text(answer)
                .foregroundColor(.black)
                .padding()
        })
        .border(Color.red, width: 8)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

#Preview {
    ContentView(question: Question.allQuestions[0])
}
