#include <File.au3>
#include <json.au3>
$spath = "Path to config files in ASF"
$files = _FileListToArray($spath,"*.json")
If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
    
$contents = FileRead($spath & "\"&$files[$i])
$object = json_decode($contents)
$username = json_get($object,'[SteamLogin]')
$password = json_get($object,'[SteamPassword]')
getCode($username,$password)
	
Func getCode($username,$password)
	MsgBox($MB_SYSTEMMODAL,"",$username &@CRLF& $password)
	Return
	
