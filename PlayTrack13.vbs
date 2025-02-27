
' // - Include 'Functions' file - //
    Set fsObj = CreateObject("Scripting.FileSystemObject")
    thisFolderPath = fsObj.GetParentFolderName(WScript.ScriptFullName)
    Set thisFolder = fsObj.GetFolder(thisFolderPath)
    Set utilsFile = fsObj.OpenTextFile(thisFolder & "\Utils.vbs", 1)
    ExecuteGlobal utilsFile.ReadAll
    utilsFile.Close
' // ----------------------------- //


trackNum = 13

' Get saved board
selectedBoardNum = GetBoardFromFile()

' Get board's folder path
boardPath = GetNthBoardPath(selectedBoardNum Mod GetNumBoards() + 1)

' Get random song
Set songsFolder = fsObj.GetFolder(boardPath)
Set songFiles = songsFolder.Files
i = 1
For Each song in songFiles
    If Int(i) = trackNum Then
        songPath = song
    End If
    i = i + 1
Next

' Play file
audioPlayer.URL = songPath
audioPlayer.controls.play 
While audioPlayer.playState <> 1 ' 1 = Stopped
  WScript.Sleep 100
Wend

' Close audio player
audioPlayer.close