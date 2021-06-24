# quizapp

A new Flutter project - QuizApp

Notes:

Assignment - use the 2 jsons provided to populate the questions in quiz

Comment - Two json files for two questions are added in assets folders. If you would lile to add more questions, just add more json files in assets folder by incrementing number in file name like for third question - question3.json.

Assignment -  the quiz will have 3 layouts and can be changed with 3 upfront buttons provided in screen: vertical, horizontal and grid

Comment - 3 layouts can be chnages from settings button on question screen.

Assignment - the effects and animations to be achieved as much as you can

 but the basic zoom in out of an option after click has to be there

 the correct and incorrect animation can be a placeholder animation

Comment - Animations are added, please run app to see it.

Assignment -

Task Points:

 use the 2 jsons provided to populate the questions in quiz

 //Done

 Comment - Two json files for two questions are added in assets folders. If you would lile to add more questions, just add more json files in assets folder by incrementing number in file name like for third question - question3.json.

 the quiz will have 3 layouts and can be changed with 3 upfront buttons provided in screen: vertical, horizontal and grid

 This is to check the responsiveness of the design to fit in different form factors.

 the grid layout reference is given in a sample video, other 2 can be derived from it only

 //Done

 Comment - 3 layouts can be chnages from settings button on question screen.

 the effects and animations to be achieved as much as you can

 //Done

 but the basic zoom in out of an option after click has to be there

 //Done

 the correct and incorrect animation can be a placeholder animation

  //Done


 on incorrect the user will be shown incorrect on the same manner the correct is showing, but the question will not go next, whereas in case of correct it will go next after the get ready animation is played

  //Done


 the get ready animation can be a sample placeholder animation

  //Done


 whether to show the get ready animation or not will be controlled from a settings.json externally

  //Done


 there will the timer animation also(parameters like to show or not and duration are controlled from settings json)

  //Done


 on next time the user comes the questions state will be maintained via state

  //Done


 after the last question the summary screen will come.

  //Done

Some Notes:

Please use apk file shared along with source code to run app in android device.

1. Questions and Answers are accessed through Bloc pattern. Settings json is accessed directly.

2. More question json files can be added in assets folder and corresponding entry should be added in yaml file.

3. Answers are saved in sqflite databased and access through Bloc pattern.

4. In Settings.json file, there are three settings - showGetReadyAnimation, showTimer, timerDuration.

5. Options layout can be changed from settings screen which can be accessed through settings button on question screen.

6. After answering all questions, summary screen comes where we can see score and time for each question taken. There is a button to restart quiz, it will clear all previous saved answers.

7. Application works in both portrait and landscape mode.

8. This app is part of assignment and developed in less time frame. It can be optimised by spending some more time.

9. On summary screen, score is taken from marks field of question in json file.