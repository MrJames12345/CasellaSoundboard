#!/usr/bin/env python
# SelectBoard.py - Simple board selection using tkinter

import os
import sys
import tkinter as tk
import tkinter.messagebox as msgBox

# Constants
WIDTH = 400
HEIGHT = 500
TITLE = "Board Selection"

BUTTON_BG_COLOR = "#7ec7d2"
BUTTON_FG_COLOR = "#424242"
LIST_FONT = "Helvetica 11"
TITLE_FONT = "Helvetica 14 bold"

def is_board_folder(folder_path):
    """Check if a folder is a board folder (contains only MP3 files and at least one MP3 file)"""
    if not os.path.isdir(folder_path):
        return False

    has_mp3 = False
    for file in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file)
        if os.path.isfile(file_path):
            if file.lower().endswith('.mp3'):
                has_mp3 = True
            else:
                # Found a non-MP3 file
                return False

    # Must have at least one MP3 file
    return has_mp3

def get_board_folders(base_path):
    """Get all board folders and their indices"""
    board_names = []
    board_paths = []

    # First collect all valid board folders
    for item in os.listdir(base_path):
        folder_path = os.path.join(base_path, item)
        if is_board_folder(folder_path):
            board_names.append(item)
            board_paths.append(folder_path)

    return board_names, board_paths

def select_board(event):
    """Handle board selection when a board is clicked"""
    # Get the selected index
    selected_idx = boards_listbox.curselection()
    if not selected_idx:
        return

    selected_idx = selected_idx[0]
    selected_board = board_names[selected_idx]

    # The board number is simply the index in the list (starting at 0)
    board_num = selected_idx

    # Update the BoardNum.txt file
    with open(os.path.join(base_path, "BoardNum.txt"), 'w') as f:
        f.write(str(board_num))

    # Show confirmation message at the bottom of the window
    status_label.config(text=f'Selected "{selected_board}"')

    # Schedule window to close after 1.5 seconds
    root.after(1000, root.destroy)

# No cancel function needed anymore

# Get the script directory
if getattr(sys, 'frozen', False):
    # Running as compiled executable
    base_path = os.path.dirname(sys.executable)
else:
    # Running as script
    base_path = os.path.dirname(os.path.abspath(__file__))

# Get all board folders
board_names, board_paths = get_board_folders(base_path)

if not board_names:
    msgBox.showerror("Error", "No board folders found!")
    sys.exit(1)

# Create the main window
root = tk.Tk()
root.title(TITLE)
root.geometry(f"{WIDTH}x{HEIGHT}")
root.resizable(False, True)

# Create main frame with padding
main_frame = tk.Frame(root, padx=20, pady=20)
main_frame.pack(fill=tk.BOTH, expand=True)

# Add title
title_label = tk.Label(main_frame, text="Select a Board:", font=TITLE_FONT)
title_label.pack(pady=(0, 20), anchor=tk.W)

# Create a frame for the listbox and scrollbar
list_frame = tk.Frame(main_frame)
list_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 0))

# Add scrollbar
scrollbar = tk.Scrollbar(list_frame)
scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

# Add listbox
boards_listbox = tk.Listbox(
    list_frame,
    font=LIST_FONT,
    activestyle="none",
    selectmode=tk.SINGLE,
    yscrollcommand=scrollbar.set
)
boards_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
scrollbar.config(command=boards_listbox.yview)

# Populate the listbox
for board_name in board_names:
    boards_listbox.insert(tk.END, board_name)

# Add double-click binding
boards_listbox.bind('<Double-1>', select_board)
# Add single-click binding (select on single click)
boards_listbox.bind('<ButtonRelease-1>', select_board)

# Create a frame for the bottom section
bottom_frame = tk.Frame(main_frame)
bottom_frame.pack(side=tk.BOTTOM, fill=tk.X, pady=(0, 0))

# Add status label at the bottom
status_label = tk.Label(
    bottom_frame,
    text="",
    font="Helvetica 11 bold",  # Bold font
    anchor=tk.CENTER,  # Center alignment
    fg="#008800"
)
status_label.pack(side=tk.BOTTOM, fill=tk.X, pady=(10, 0))

# No cancel button needed

# Center the window on screen
root.update_idletasks()
width = root.winfo_width()
height = root.winfo_height()
x = (root.winfo_screenwidth() // 2) - (width // 2)
y = (root.winfo_screenheight() // 2) - (height // 2)
root.geometry(f"{width}x{height}+{x}+{y}")

# Start the main loop
root.mainloop()
