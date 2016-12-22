# Description
#   Tells the user a joke.
#
# Commands:
#   "nameOfBot:" followed by "joke" in a sentence
#   Example -> GooeyJrVaibhav: Joke, please.
#
# Author:
#   VaibhavBajaj (https://github.com/VaibhavBajaj)

jokeList = [
            ["Who is the hide and seek champion since 1958?", ";"],
            ["I'm on a whiskey diet. Guess what.", "I've lost three days already."],
            ["A seal walks into a club... ", "... That's it really"],
            ["Did you hear about the guy whose whole left side was cut off?", "He's all right now."],
            ["How many programmers does it take to change a light bulb?", "None, that's a hardware problem"],
            ["If you put a million monkeys at a million keyboards, one of them will eventually write a Java program.", "The rest of them will write Perl programs."],
            ["To understand what recursion is...", "you must first understand recursion."],
            ["So this programmer goes out on a date with a hot chick", "Hahahaha ... okay, I'm okay now... Hahahahahhahahah!!"],
            ["Why don't jokes work in octal?", "Because 7 10 11."],
            ["Keyboard not found ...", "Press F1 to continue"],
            ["I never make mistakes.I thought I did once...", "But I was wrong."],
            ["If you understand English, press 1. If you do not understand English, press 2.", "Get it? :D"]
      ]


module.exports = (robot) ->
   userEnteredJokeList = robot.brain.get 'jokeList'
   if userEnteredJokeList is null
      userEnteredJokeList = []

   for joke in userEnteredJokeList
      jokeList.push joke

   robot.respond /.*Q:(.*)A:(.*)/, (msg) ->
      jokeFirstPart = msg.match[1]
      jokeSecondPart = msg.match[2]
      tempJoke = [jokeFirstPart, jokeSecondPart]
      jokeList.push tempJoke
      userEnteredJokeList.push tempJoke
      robot.brain.set 'jokeList', userEnteredJokeList
      userEnteredJokeList = robot.brain.get 'jokeList'
      msg.send ":P. That is funny indeed. Saving it in memory... Done"
      msg.send userEnteredJokeList
      msg.send robot.brain.get 'jokeList'

   robot.respond /(.*)joke[^s](.*)/i, (msg) ->
      msg.send "Joke? Joke! I know a JOKE!"
      joke = msg.random jokeList
      msg.send joke[0]
      setTimeout () ->
         msg.send joke[1]
      ,4000
      msg.send userEnteredJokeList

   robot.respond /how (should|do|can) i (save|store|add) jokes.*/i, (msg) ->
      msg.send "Please enter a two-part joke with 'Q:'' to indicate question and 'A:' to indicate concluding sentence like so:"
      msg.send "Q:Did you hear about the guy whose whole left side was cut off? A: He's all right now."

   robot.respond /refresh jokes memory/i, (msg) ->
      msg.send "Clearing up data... Done"
      robot.brain.remove 'jokeList'
      userEnteredJokeList = []
      jokeList = jokeList[0..12]
         