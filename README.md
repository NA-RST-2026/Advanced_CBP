# Advanced_CBP
Repository for the Advanced CBP exercise

## Introduction
The objective of this exercise is to give you hands-on experience with the coding best practices concepts covered in the advanced lecture, including justfiles for project setup, main/orchestrator files, data validation, and de-identification. While you may need to write some code, the primary focus is on getting the intuition behind these practices down.
 - This will be a small group lecture, so feel free to ask questions of me (Jack) or your co-attendees if you get stuck. 
 - The goal is for both of you to fully understand what’s happening at every step, not just complete the activity.
 - If you have less coding experience, ask questions and ensure you’re not lost at any stage. 
 - If you have more experience, help guide those around you by explaining what each command or action does. Teaching will help reinforce your own understanding.

## Exercise steps:
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