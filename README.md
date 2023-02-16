

```diff
- Description
This repository contains the experiment code and files needed to run an flanker task (plus single rdk baseline task) with random-dot kinematograms. The task is written in MATLAB, using Psychtoolbox.

+ How to Run
start_experiment(coherenceLevels, trialsPerCell)
i.e. start_experiment([20 90],100)

+ Things to note.
  In this repository, all Labjack commands are currently commented out. Ensure these are uncommented before use.
  Trials per cell refers to the number of trials per combination of 
  Motion Direction and Coherence in the single RDK task and per combination of Motion Direction, 
  Coherence & Congruency in the flanker task.
   
The experiment can be quit any time using the 'q' button the keyboard. 
Instruct participants to not touch the letter Q!

The keys to respond are 'z' for leftwards movement and 'm' for rightwards movement.

The code asks for the following demographic information: 
age, gender and participant number. This information is saved to a structure 
variable (along with the trial sequence). The trial sequence is written to the datafile after each block.






------------------------------------------------------------------------------------
 EEG TRIGGER CODES
+ 1 - Fixation

+ Stimulus Onset
! Single RDK Task
Coded by (Target Direction (1 = right, 2 = left) | Coherence (depends on coherence inputted) | Practice (0 = experimental trial, 1 = practice)
Examples (assuming coherence = [20 90])

121 = Rightwards target direction, 90% coherence, practice trial.
210 = Leftwards target direction, 20% coherence, experimental trial.

! Flanker Task
Coded by (Target Direction (1 = right, 2 = left) | Coherence (depends on coherence inputted) | Congruency (1 = congruent, 2 = incongruent) | Practice (0 = experimental trial, 1 = practice)
Examples (assuming coherence = [20 90])

1211 = Rightwards target direction, 90% coherence, congruent trial, practice trial.
2120 = Leftwards target direction, 20% coherence, incongruent trial, experimental trial.

+ 2 - Correct Response
+ 3 - Incorrect Response

------------------------------------------------------------------------------------
```
