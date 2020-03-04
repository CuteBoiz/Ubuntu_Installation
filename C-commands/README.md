# C Commands

## I. Install & Run A C Program
<ul style = "list-style-type:none">
<li><b>Step 1: Install the build-essential packages</b></li>

In order to complie and execute a C program, you need to have the essential packages installed on your system.
```
$ sudo apt-get install build-essential
```

<li><b>Step 2: Write a simple C program </b></li>

After installing the essential packages, let us write a simple C program.
```
$ gedit sampleProgram.c
```

<li><b>Step 3: Compile the C program with gcc Compiler</b></li>

In your Terminal, enter the following command in order to make an executable version of the program you have written:
```
$ sudo apt-get install gcc
$ gcc [programNanme].c -o programName
```
Make sure your program is located in your Home folder. Otherwise, you will need to specify appropriate paths in this command.


<li><b>Step 4: Run the program</b></li>

The final step is to run the compiled C program. Use the following systax to do so:
```
$ ./progamName
```

</ul>