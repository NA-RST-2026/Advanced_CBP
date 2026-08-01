# Advanced_CBP
Repository for the Advanced CBP exercise

## Introduction
The objective of this exercise is to give you hands-on experience with the coding best practices concepts covered in the advanced lecture, including justfiles for project setup, main/orchestrator files, data validation, and de-identification. While you may need to write some code, the primary focus is on getting the intuition behind these practices down.
 - This will be a small group lecture, so feel free to ask questions of me (Jack) or your co-attendees if you get stuck. 
 - The goal is for both of you to fully understand what’s happening at every step, not just complete the activity.
 - If you have less coding experience, ask questions and ensure you’re not lost at any stage. 
 - If you have more experience, help guide those around you by explaining what each command or action does. Teaching will help reinforce your own understanding.

## Exercise part 1: Setup and Justfiles
### 1. **Clone this repository**:
Open the terminal on your computer in the folder your want to make the repository.
 - **Mac Users**:
            - Navigate to the folder where you want to store the remote repository.
            - Right-click the folder and select "New Terminal at Folder" (or open Terminal and use cd to navigate to your desired location).
 - **Windows Users**:
            - Navigate to the folder where you want to store the remote repository.
            - Right click and select “Open in Terminal”
Run the following command:
 ```bash
 git clone https://github.com/NA-RST-2026/Advanced_CBP.git
 ```

Navigate into the folder:
```bash
cd Advanced_CBP
```

Explore the folder structure:
```bash
ls
```
### 2. Download Just:

|Platform|Commands|
|-------|------|
|Windows|winget install Casey.Just|
|Mac|brew install just|

Ensure it is installed:
```bash
just --version
```

Understand the commands available to you:
```bash
just help
```

### 3. Run a just recipe to create a new folder/file structure for data Pull 1
Use the just add-new-pull to easily create the folders necessary for admin data pull 1, and copy over template versions of your deid, clean, and validate scripts to the appropriate folders.

Note that you'll need to replace the two [arguments] below with the appropriate value!
```bash
just add-new-pull [pull-number] [coding-language]
```
*extra*: What happens if you specify a non coding language in the second argument?

Now let's explore what happened -- you can either do this in the terminal through the combination of `cd` (changing directory) and `ls` (listing the files/folders in the current or specified directory), or by just going back to your normal file/folder explorer on your computer.

### Extra credit:
If you finish the above before we are ready to move on, see if you can create your own just recipe! Use your knowledge from the git/github lecture to create a recipe that would: i) Create and checkout to a new git branch called "dev"; ii) run git status; iii) checkout back to main; and iv) delete the dev branch (perhaps the least useful just recipe ever, but good to learn how to string together commands)

## Exercise part 2: Virtual Environments

### Step 1: Setting up the virtual environment
Follow the relevant steps in the below table (copied from the lecture) to create and activate a virtual environment in your preferred coding language.

| Step | Stata | R | Python: uv |
|------|-------|---|------------|
| Create a blank environment folder | Create an empty folder – `mkdir custom_ado` | `install.packages("renv")`<br>`renv::init()` | `uv init`<br>`uv venv` |
| Inspect files | Folders within `custom_ado` starting with letters – “reghdfe” would be in `custom_ado/r` | Library: `renv/library/`<br>Metadata: `renv.lock`<br>Overview: `.Rprofile` | Library: `.venv/`<br>Metadata: `uv.lock`<br>Overview: `pyproject.toml` |
| Activate that environment | `foreach fold in PLUS PERSONAL OLDPLACE{`<br>`sysdir set \`fold' "custom_ado"`<br>`}` | Automatically done with `renv::init()` | `source .venv/bin/activate` |
| Download packages | `ssc install X`<br>`net install X, from(url)` | `install.packages("X")` | `uv add X` |
| Save metadata for the environment | Can see version # with `which` command, but then any further documentation manual | `renv::snapshot()` | Done automatically by uv |
| Use another person’s saved environment | Share `custom_ado` folder<br>`foreach fold in PLUS PERSONAL OLDPLACE{`<br>`sysdir set \`fold' "custom_ado"`<br>`}` | `renv::restore()` | `uv sync` |

### Step 2: Adding the first package
Now let's add our first package! Add the following packages that we'll use in the lab for your environments:

|Language|Packages|
|-------|------|
|Stata|unique|
|R|dplyr; labelled |
|Python|pandas|

### Step 3: Updating the metadata
Look back at the table above, and run the commands necessary to document the packages that are now part of your project.

*Question*: If you're using Stata, where are you going to save that information? The readme? A do-file? Both? Up to you, but needs to go somewhere!

### Extra credit:
If you finish before we're ready to move on, try adding and then removing a couple other packages that you're familiar with from your own work.

## Exercise part 3: Main/orchestrator scripts and config files
Let's now build our main script and configuration files with the appropriate set up commands and globals.

### Step 1: Fill in setup commands
Open the appropriate 00_config file for your coding language, and follow the instructions to write the appropriate global variables. These are:
|Language|Packages|
|-------|------|
|All| The random seed <br>The num_pulls and folder path globals|
|Stata|The version|
|R & Stata| The working directory|
Specifically, try to create globals for sub-directories in an iterative way, so that if you change the top-folder name, you don't have to change all of the sub-directory globals!

*Note*: I know it feels silly to write and pull in a config file with only a few globals in it, but this is good practice for complex projects in which you might have 10s-100s of configuration globals that may change frequently!

### Step 2: Read the config file in the main script
Pull the config script into the main script and run it so that the display commands already in the main script correctly display the values you set.

*Note: If you're working in python, I've gone ahead and added the first part of the import script -- this is likely more outside of typical wheelhouses than the Stata/R version*

After that, add the globals to the correct place in the main file to actually set the seed and working directory (R and Stata).

### Step 3: Add calls for the clean and validate scripts
Even though we haven't completed adapting them yet, we can go ahead and place calls to the clean and validation scripts in the main script.

We can do this in Stata with:
```Stata
do [dofile].do
```

And in R with:
```R
source("rscript.R")
```

And in python with
```python
from script import function1, function2,...
```

## Exercise part 4: Data validation
In the lab, you'll write more data validation checks yourself. For now, open documentation/codebook.pdf and identify some validations you may want to write.

## Exercise part 5: De-identification
Before working on the data more fully, we want to de-identify the direct identifiers; but we may need the names in the future for merging into other admin data, so let's keep them in a crosswalk in our encrypted folder (data/raw).

The code to do this is already at the top of the "de_identification" scripts -- run the code from your preferred language and look at the output

## Lab Exercise:
Now work in your groups to complete the data validation, cleaning, and de-identification tasks in the associated scripts.

If you want to collaborate on the same files, you can use what you learned in the git/github lecture to work on the same branch:
```bash
git checkout -b [branch-name]
git add [filename]
git commit -m "[commit message]"
git push origin [branch-name]
```
Then you can create and merge pull requests on that branch! (pls don't touch the main branch)
But this isn't necessary if you want to focus on the tasks at hand.