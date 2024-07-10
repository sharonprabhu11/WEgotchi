-- Define the questions and options
local questions = {
    {
        code = {
            "int main() {",
            "printf(\"Hello, World!\");",
            "return 0;"
        },
        options = {
            "Missing semicolon after return statement",
            "Print should be in uppercase",
            "Missing closing brace for main function"
        },
        correctOption = 3
    },
    {
        code = {
            "int a = 10;",
            "int b = 20;",
            "int c = ab;"
        },
        options = {
            "Variable b is not defined",
            "Missing semicolon after a",
            "Incorrect operator between a and b"
        },
        correctOption = 3
    },
    {
        code = {
            "int main() {",
            "int a = 5;",
            "if(a = 5) {",
            "printf(\"a is 5\");",
            "}",
            "return 0; }"
        },
        options = {
            "Incorrect comparison operator in if statement",
            "Missing semicolon after if statement",
            "a should be a float"
        },
        correctOption = 1
    },
    {
        code = {
            "#include <stdio.h>",
            "void main() {",
            "int x = 10;",
            "printf(\"Value of x: %d\", x);",
            "return 0; ",
            "}"
        },
        options = {
            "void main() should be int main()",
            "Incorrect format specifier in printf",
            "x should be a float"
        },
        correctOption = 1
    },
    {
        code = {
            "int main() {",
            "char c = 'A';",
            "printf(\"Character: %s\", c);",
            "return 0; ",
            "}"
        },
        options = {
            "Missing semicolon after printf",
            "Incorrect format specifier in printf",
            "c should be an int"
        },
        correctOption = 2
    }
}

-- Initialize score
local score = 0

-- Function to ask questions
local function askQuestions()
    for i, question in ipairs(questions) do
        print("\nQuestion " .. i .. ": Identify the error in the following code:\n")
        for _, line in ipairs(question.code) do
            print(line)
        end

        print("\nOptions:")
        for j, option in ipairs(question.options) do
            print(j .. ". " .. option)
        end

        print("\nEnter the number of the correct option:")
        local userAnswer = tonumber(io.read())

        if userAnswer == question.correctOption then
            print("Correct!\n")
            score = score + 1
        else
            print("Wrong! The correct answer was option " .. question.correctOption .. ".\n")
        end
    end
end

-- Run the quiz
print("Welcome !!")
askQuestions()

-- Display the final score
print("Quiz complete! Your final score is: " .. score .. " out of " .. #questions)

 


