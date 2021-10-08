#include-once
#include <File.au3>
#include <json.au3>
#include <http.au3>



$spath = "Path to config files in ASF"
$first = "http://localhost:1242/Api/Bot/"
$second = "/TwoFactorAuthentication/Token"
Global $array[3]

;read all bot json files
$files = _FileListToArray($spath,"*.json")
If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
	



	
;get all credentials and auth code	
Func credentials($i)
$contents = FileRead($spath & "\"&$files[$i+1])
$object = json_decode($contents)

;Fetch login and pass from json files
$array[0] = json_get($object,'[SteamLogin]')
$array[1] = json_get($object,'[SteamPassword]')

;Fetch auth code from ASF api
$sGet = HttpGet($first&$array[0]&$second)
$response = json_decode($sGet)
$array[2] = json_get($response,'[Result].'&$array[0]&'.Result')
EndFunc

;Main programs start

for $i=1 to 200
	credentials($i)
	Run("Path to steam/Steam.exe" & "-login " & $array[0] & " " & $array[1] & " -applaunch 440  -textmode -novid -nosound -sw -nopreload"  )

	Sleep(5000)
	WinActivate("Steam Guard - Computer Authorization Required")
	WinWaitActive("Steam Guard - Computer Authorization Required")
	Send($array[2])
	Send("{ENTER}")
	Sleep(330000)
	ProcessClose("hl2.exe")
	Sleep(5000)

	ProcessClose("Steam.exe")
	Sleep(3000)

Next











