
' // - Include 'Functions' file - //
    Set fsObj = CreateObject("Scripting.FileSystemObject")
    thisFolderPath = fsObj.GetParentFolderName(WScript.ScriptFullName)
    Set thisFolder = fsObj.GetFolder(thisFolderPath)
    Set utilsFile = fsObj.OpenTextFile(thisFolder & "\Utils.vbs", 1)
    ExecuteGlobal utilsFile.ReadAll
    utilsFile.Close
' // ----------------------------- //




Dim oldSavedNum
Dim newSavedNum
Dim boardNum

' Get new board num
Set boardNumFile = fsObj.OpenTextFile(thisFolder & "\BoardNum.txt", 1)
oldSavedNum = boardNumFile.ReadAll()
Set boardNumFile = Nothing
newSavedNum = oldSavedNum + 1
boardNum = newSavedNum Mod GetNumBoards()

' Set new board num
Set boardNumFile = fsObj.OpenTextFile(thisFolder & "\BoardNum.txt", 2)
boardNumFile.Write(newSavedNum)
boardNumFile.Close
Set boardNumFile = Nothing


' Get board name
i = 0
For Each boardFolder in GetBoardFoldersList()
    If IsBoardFolder(boardFolder) Then
        If Int(i) = Int(boardNum) Then
            boardName = boardFolder.Name
        End If
        i = i + 1
    End If
Next


' Show new board name on popup
CreateObject("WScript.Shell").Popup "Board set to: '" & boardName & "'.", 1, "Board Mate"