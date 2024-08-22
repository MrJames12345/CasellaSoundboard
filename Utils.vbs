

 ' Variables
 
Set oShell = WScript.CreateObject ("WScript.Shell")
Set audioPlayer = CreateObject("WMPlayer.OCX")



 ' Functions

Function GetBoardFromFile()

  Set boardFile = fsObj.OpenTextFile(thisFolder & "\BoardNum.txt", 1)
  boardNum = boardFile.ReadAll()
  boardFile.Close
  Set boardFile = Nothing
  GetBoardFromFile = boardNum

End Function



Function GetBoardFoldersList()

  Set GetBoardFoldersList = thisFolder.SubFolders

End Function



Function IsBoardFolder(inFolder)
 ' Only a board folder if has only mp3 files in it

  check = true
  Set folderFiles = inFolder.Files

  For Each file in folderFiles
    If Not Right(file.Name, 4) = ".mp3" Then
      check = false
    End If
  Next

  IsBoardFolder = check

End Function



Function GetNumBoards()

  i = 0
  Set allFolders = GetBoardFoldersList()
  For Each folder in allFolders
    If IsBoardFolder(folder) Then
      i = i + 1
    End If
  Next
  GetNumBoards= i

End Function



Function GetNthBoardPath(inNum)

  i = 1
  For Each boardFolder in GetBoardFoldersList()
    If IsBoardFolder(boardFolder) Then
      If Int(i) = Int(inNum) Then
        board = boardFolder
      End If
      i = i + 1
    End If
  Next

  GetNthBoardPath = board

End Function



Function GetNthBoardName(inNum)

  boardName = fsObj.GetFolder( GetNthBoardPath(inNum) ).Name

  GetNthBoardName = boardName

End Function



Function GetCurrentBoardName()

  GetCurrentBoardName = GetNthBoardName( GetBoardFromFile() )

End Function



Function GetRandomBoardNum()

  GetRandomBoardNum = GetRandomNum(1, GetNumBoards())

End Function



Function GetRandomSongFromFolder(inFolder)

  Set songsFolder = fsObj.GetFolder(inFolder)
  Set songFiles = songsFolder.Files
  totalSongs = songFiles.Count

  randSongNum = GetRandomNum(1, totalSongs)

  i = 1
  For Each song in songFiles
      If Int(i) = Int(randSongNum) Then
        songPath = song
      End If
      i = i + 1
  Next

  GetRandomSongFromFolder = songPath

End Function



Function GetRandomNum(inFrom, inTo)

  Randomize
  GetRandomNum = Int((inTo - inFrom + 1) * Rnd + inFrom)

End Function