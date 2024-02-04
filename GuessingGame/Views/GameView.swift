//
//  GameView.swift
//  GuessingGame
//
//  Created by Nikita Zhdanov on 2024-01-30.
//

import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    
    // What number the user has guessed
    @State var selectedNumber = 50
    @State var givenInput = ""
    @State var key = ""
    
    // What number the computer wants the user to guess
    @State var target = Int.random(in: 1...100)
    
    // Feedback to the user on what to try next
    @State var feedback = ""
    
    // The list of numbers the user has guessed so far
    @State var guessesMade: [Int] = []
    
    let stringNumbers: [String: Int] = [
        "one": 1, "two": 2, "three": 3, "four": 4, "five": 5,
        "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10,
        "eleven": 11, "twelve": 12, "thirteen": 13, "fourteen": 14, "fifteen": 15,
        "sixteen": 16, "seventeen": 17, "eighteen": 18, "nineteen": 19, "twenty": 20,
        "twenty-one": 21, "twenty-two": 22, "twenty-three": 23, "twenty-four": 24, "twenty-five": 25,
        "twenty-six": 26, "twenty-seven": 27, "twenty-eight": 28, "twenty-nine": 29, "thirty": 30,
        "thirty-one": 31, "thirty-two": 32, "thirty-three": 33, "thirty-four": 34, "thirty-five": 35,
        "thirty-six": 36, "thirty-seven": 37, "thirty-eight": 38, "thirty-nine": 39, "forty": 40,
        "forty-one": 41, "forty-two": 42, "forty-three": 43, "forty-four": 44, "forty-five": 45,
        "forty-six": 46, "forty-seven": 47, "forty-eight": 48, "forty-nine": 49, "fifty": 50,
        "fifty-one": 51, "fifty-two": 52, "fifty-three": 53, "fifty-four": 54, "fifty-five": 55,
        "fifty-six": 56, "fifty-seven": 57, "fifty-eight": 58, "fifty-nine": 59, "sixty": 60,
        "sixty-one": 61, "sixty-two": 62, "sixty-three": 63, "sixty-four": 64, "sixty-five": 65,
        "sixty-six": 66, "sixty-seven": 67, "sixty-eight": 68, "sixty-nine": 69, "seventy": 70,
        "seventy-one": 71, "seventy-two": 72, "seventy-three": 73, "seventy-four": 74, "seventy-five": 75,
        "seventy-six": 76, "seventy-seven": 77, "seventy-eight": 78, "seventy-nine": 79, "eighty": 80,
        "eighty-one": 81, "eighty-two": 82, "eighty-three": 83, "eighty-four": 84, "eighty-five": 85,
        "eighty-six": 86, "eighty-seven": 87, "eighty-eight": 88, "eighty-nine": 89, "ninety": 90,
        "ninety-one": 91, "ninety-two": 92, "ninety-three": 93, "ninety-four": 94, "ninety-five": 95,
        "ninety-six": 96, "ninety-seven": 97, "ninety-eight": 98, "ninety-nine": 99, "one hundred": 100
    ]

    
    // MARK: Computed properties
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 30) {
                
                Text("I'm thinking of a number between 1 and 100.")
                
                Text("Guess what it is!")
                    .font(.headline)
                
                TextField("Make a guess", text: $givenInput)
                
                Button {
                    checkGuess()
                } label: {
                    Text("Submit Guess")
                }
                .buttonStyle(.borderedProminent)
                
                Text(feedback)
                    .font(
                        .custom(
                            "BradleyHandITCTT-Bold",
                            size: 24.0,
                            relativeTo: .title3
                        )
                    )
                    

                Button {
                    reset()
                } label: {
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

                
                // Show the user's guesses
                Text("Guesses made")
                    .font(.title3.smallCaps())
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(guessesMade, id: \.self) { currentGuess in
                            Text("\(currentGuess)")
                            Divider()
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Guessing Game")
            
        }

    }
    
    // MARK: Functions
    func checkGuess() {
        guard let number = Int(givenInput) else {
            guard let numberFromString = stringToInt(numberString: givenInput.lowercased()) else {
                feedback = "Please provide a valid number or its word representation."
                return
            }
            
            selectedNumber = numberFromString
            processGuess(selectedNumber: selectedNumber)
            return
            
        }
        
        selectedNumber = number
        processGuess(selectedNumber: selectedNumber)
    }

    func stringToInt(numberString: String) -> Int? {
        return stringNumbers[numberString]
    }

    // A new function to process the guess now that selectedNumber is available
    func processGuess(selectedNumber: Int) {
        // Provide feedback to the user
        if target < selectedNumber {
            feedback = "My number is lower!"
        } else if target > selectedNumber {
            feedback = "My number is higher!"
        } else {
            feedback = "Correct! You've guessed the number!"
        }
        
        // Save the user's guess
        guessesMade.append(selectedNumber)
    }

    // Start a new game
    func reset() {

        // Start the user back at 50
        givenInput = ""
        
        // Have the computer guess a new number
        target = Int.random(in: 1...100)
        
        // Reset feedback
        feedback = ""
        
        // Remove guesses made
        guessesMade.removeAll()
        
    }
}

#Preview {
    GameView()
}
