Option Explicit

' Get the script directory
Dim fso, scriptDir
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Run the Python script without showing a window
Dim shell, pythonPath, pythonScript
Set shell = CreateObject("WScript.Shell")
pythonPath = "pythonw.exe"
pythonScript = scriptDir & "\SelectBoard.py"

' Run the command with window hidden (0 = hidden)
shell.Run pythonPath & " """ & pythonScript & """", 0, False

Set shell = Nothing
Set fso = Nothing
