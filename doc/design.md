#Design Document

##Summary
This app is a variation on the populair "Hangman" game. It is played the same way as the original game but when the player guesses a letter, the computer tries to 'cheat' by changing the word everytime a correct letter is guessed.


#Classes

##Model

Words: Class that parses the words.plist to an NSArray of strings.
Functions:
-parse(): Takes a plist file with words and returns an array with these words.
-getWordsWithLength() takes an integer l as an argument and returns an array with all words of length l.

Game: Contains all the game logic and algorithms needed to play the game.
Functions:
startGame(): initializes an array of words from the word class and starts a game with an unknown word of lenght n (stored in NSUserDefaults).




##View

PlayingFieldView: a subclass of UIView that contains:
	a UILabel to display the score
	a UILabel to display the word to guess (letters are replaced by a "_" if they have not been guessed yet).
	a SKView to display Sprite Kit content (used to animate the stickman).

GameOverView: a subclass of UIView that contains:
	a UILabel to display the score
	a UILabel to display the final word

GameKeyboard: a custom keyboard class, contains a UIButton for every letter in the alphabet. when letters are guessed, the keystate will be inactive.



##Controller
HangManGameViewController: Subclass of UIViewcontroller to control the main screen. This viewcontroller is used to display the playingfield, the custom keyboard and control the buttons that are used to restart the game and to navigate to the settings menu.

SettingsViewController: Subclass of UIViewController that is used to display the settings menu.


APIs
This app mostly uses the default apple APIs, but in particular UIKit & Sprite Kit.
