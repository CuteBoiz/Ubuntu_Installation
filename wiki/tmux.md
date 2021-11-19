# TMUX CHEAT SHEET

> It is an application that allows you to split a terminal window into multiple others.  So, in a single window, we can have several instances of the terminal open, similar to GNU screen or Byobu. Tmux is ideal for speeding up terminal tasks, especially if you are a sysadmin, who needs to handle several terminals in one.

## Install 

```sh
sudo apt-get install tmux
```

## Sessions

- **Create a tmux session:**
	```sh
	tmux new -t ses_name
	```

- **Detact from session:** `Ctrl` + `b` &nbsp; `d`
  > Running commands in a session is still run after you detach from session. This is one of the best features of tmux.
	

- **Attach to an detached session:**
	```sh
	tmux a -t ses_name
	```

- **Terminate tmux session:**
	```sh
	tmux kill-ses -t ses_name
	```

## Windows

> A Tmux session had at last one window. If you create a tmux session a window would be auto generated.

- **Create new window:** `Ctrl` + `b` &nbsp; `c`

- **Rename current window:** `Ctrl` + `b` &nbsp; `,`

- **Close current window:** `Ctrl` + `b` &nbsp; `&`

- **Next window:** `Ctrl` + `b` &nbsp; `n`

- **Previous window:** `Ctrl` + `b` &nbsp; `p`

- **Switch/select window by number:** `Ctrl` + `b` &nbsp; `0`...`9`

## Panels

> You can split a window into multiple panels.

- **Split pane horizontally:** `Ctrl` + `b` &nbsp; `%`

- **Split pane vertically:** `Ctrl` + `b` &nbsp; `"`

- **Switch to pane to the direction:** `Ctrl` + `b` &nbsp; `arrow_keys`

- **Convert a pane into a window:** `Ctrl` + `b` &nbsp; `!`

- **Resize current pane height:**
	- `Ctrl` + `b` + `up_arrow`
	- `Ctrl` + `b` + `down_arrow`
	- `Ctrl` + `b` &nbsp; `Ctrl` + `up_arrow`
	- `Ctrl` + `b` &nbsp; `Ctrl` + `down_arrow`

- **Resize current pane width:**
	- `Ctrl` + `b` + `left_arrow`
	- `Ctrl` + `b` + `right_arrow`
	- `Ctrl` + `b` &nbsp; `Ctrl` + `left_arrow`
	- `Ctrl` + `b` &nbsp; `Ctrl` + `right_arrow`

- **Close current panel:** `Ctrl` + `b`  `x`

## Copy mode

- **Start copy mode:** `Ctrl` + `b` &nbsp; `[`

- **Quit copy mode:** `q` or `Esc`

- **Go to top line:** `g`

- **Scroll:**
	- ***Up:*** `up_arrow`
	- ***Down:*** `down_arrow`

- **Move cursor:** 
	- ***Left:*** `h`
	- ***Down:*** `j`
	- ***Up:*** `k`
	- ***Right:*** `l`
	- ***Forward one word:*** `w`
	- ***Backward one word:*** `b`

- **Search:**
	- ***Forward:*** `/`
	- ***Backward:*** `?`
	- ***Next keyword occurance:*** `n`
	- ***Previous keyword occurance:*** `N`

- **Start selection:** `Spacebar`

- **Clear selection:** `Esc`

- **Copy selection:** `Enter`

- **Paste content:** `Ctrl` + `b` &nbsp; `]`
	



