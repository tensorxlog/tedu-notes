;#SingleInstance Force
;if not A_IsAdmin
;	Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
RunAsTask() ; self elevate

;;;;;;;;;;;;;;;; Capslock related shortcuts ;;;;;;;;;;;;;;;;
#Persistent
SetCapsLockState, AlwaysOff

Capslock & h::Left
Capslock & l::Right
Capslock & k::Up
Capslock & j::Down
Capslock & ,::Home
Capslock & .::End
Capslock & u::Send ^{Home}
Capslock & n::Send ^{End}
Capslock & i::Send +^{Home}
Capslock & o::Send +^{End}
Capslock & g::Enter
;Capslock::Esc

NumpadEnter::run, C:\Users\the_d\Desktop\sleep.bat

;;;;;;;;;;;;;;;; Windows snapping ;;;;;;;;;;;;;;;;
Capslock & q::WinClose, A
Capslock & Enter::activateapp("WindowsTerminal.exe", "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.16.10262.0_x64__8wekyb3d8bbwe\wt.exe", 2061, 0, 1387, 1398)
Capslock & f::activateexplorer()
Capslock & b::activateapp("gvim.exe", "C:\Program Files (x86)\Vim\vim90\gvim.exe")
Capslock & \::activateapp("ubuntu.exe", "C:\Program Files\WindowsApps\CanonicalGroupLimited.Ubuntu_2204.1.6.0_x64__79rhkp1fndgsc\ubuntu.exe", 1096, 59, 1338, 1288)
#e::activateexplorer()
+#d::Run powershell -Command "C:'\Program Files (x86)\Internet Download Manager\IDMan.exe' /d $(Get-Clipboard)"
Capslock & Space::F11

#IfWinActive ahk_exe gvim.exe
{
~Esc::
SwitchIME(0x00000804)
return
}
#If

#IfWinActive ahk_exe chrome.exe
^+v::^+i
^+i::^+v

#IfWinActive ahk_exe explorer.exe
Capslock & r::F2
Capslock & `;::Send !{Up}
Capslock & '::Send !{Down}
Capslock & [::Send !{Left}
Capslock & ]::Send !{Right}

#IfWinActive ahk_exe UnrealEditor.exe
Capslock & a::Send !k
Capslock & d::Send !h
Capslock & s::Send !g
Capslock & w::Send !j


SwitchIME(dwLayout){ ;dwLayout: value of the "HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" key
	HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
	ControlGetFocus,ctl,A
	SendMessage,0x50,0,HKL,%ctl%,A
}

activateapp(appexe, appdir, x, y, w, h, waittime=0){
	if WinExist("ahk_exe" appexe) {
		WinActivate, ahk_exe %appexe%
		;WinGetPos, x, y, w, h, ahk_exe %appexe%
		;MsgBox %x%, %y%, %w%, %h%
	} else {
		run, %appdir%
		WinWait, ahk_exe %appexe%,, 3
		if ErrorLevel {
			MsgBox, WinWait timed out.
			return
		} else {
			if (waittime > 0) {
				MsgBox, App has started. Click to close this dialog.
				Sleep %waittime%
			}
			WinActivate, ahk_exe %appexe%
			WinMove, A, , %x%, %y%, %w%, %h%
		}
	}
}

activateexplorer() {
	if WinExist("ahk_exe explorer.exe ahk_class CabinetWClass") {
		WinActivate, ahk_exe explorer.exe ahk_class CabinetWClass
		;WinGetPos, x, y, w, h, ahk_exe explorer.exe ahk_class CabinetWClass
		;MsgBox %x%, %y%, %w%, %h%
	} else {
		run, C:\Windows\explorer.exe
		WinWaitActive, ahk_exe explorer.exe ahk_class CabinetWClass,, 3
		if ErrorLevel {
			MsgBox, WinWait timed out.
			return
		} else {
			WinMove, A, , -8, 443, 1516, 955
		}
	}
}

activateDevDocs() {
if WinExist("DevDocs API Documentation")
    WinActivate
}

startapp(appexe, appdir, x, y, w, h, waittime=0){
	run, %appdir%
		WinWait, ahk_exe %appexe%,, 3
		if ErrorLevel {
			MsgBox, WinWait timed out.
			return
		} else {
			if (waittime > 0) {
				MsgBox, App has started. Click to close this dialog.
				Sleep %waittime%
			}
			WinActivate, ahk_exe %appexe%
			WinMove, A, , %x%, %y%, %w%, %h%
		}
}



/*
 _      _    _               __ __      _      _                      _         _                        
| |__  | |_ | |_  _ __  _   / // /__ _ | |__  | | __ ___   ___  _ __ (_) _ __  | |_     ___   _ __  __ _ 
| '_ \ | __|| __|| '_ \(_) / // // _` || '_ \ | |/ // __| / __|| '__|| || '_ \ | __|   / _ \ | '__|/ _` |
| | | || |_ | |_ | |_) |_ / // /| (_| || | | ||   < \__ \| (__ | |   | || |_) || |_  _| (_) || |  | (_| |
|_| |_| \__| \__|| .__/(_)_//_/  \__,_||_| |_||_|\_\|___/ \___||_|   |_|| .__/  \__|(_)\___/ |_|   \__, |
                 |_|                                                    |_|                        |___/ 
RunAsTask() - Auto-elevates script without UAC prompt |  http://ahkscript.org/boards/viewtopic.php?t=4334        
_________________________________________________________________________________________________________
*/
 
RunAsTask() {                         ;  By SKAN,  http://goo.gl/yG6A1F,  CD:19/Aug/2014 | MD:24/Apr/2020

  Local CmdLine, TaskName, TaskExists, XML, TaskSchd, TaskRoot, RunAsTask
  Local TASK_CREATE := 0x2,  TASK_LOGON_INTERACTIVE_TOKEN := 3 

  Try TaskSchd  := ComObjCreate( "Schedule.Service" ),    TaskSchd.Connect()
    , TaskRoot  := TaskSchd.GetFolder( "\" )
  Catch
      Return "", ErrorLevel := 1    
  
  CmdLine       := ( A_IsCompiled ? "" : """"  A_AhkPath """" )  A_Space  ( """" A_ScriptFullpath """"  )
  TaskName      := "[RunAsTask] " A_ScriptName " @" SubStr( "000000000"  DllCall( "NTDLL\RtlComputeCrc32"
                   , "Int",0, "WStr",CmdLine, "UInt",StrLen( CmdLine ) * 2, "UInt" ), -9 )

  Try RunAsTask := TaskRoot.GetTask( TaskName )
  TaskExists    := ! A_LastError 


  If ( not A_IsAdmin and TaskExists )      { 

    RunAsTask.Run( "" )
    ExitApp

  }

  If ( not A_IsAdmin and not TaskExists )  { 

    Run *RunAs %CmdLine%, %A_ScriptDir%, UseErrorLevel
    ExitApp

  }

  If ( A_IsAdmin and not TaskExists )      {  

    XML := "
    ( LTrim Join
      <?xml version=""1.0"" ?><Task xmlns=""http://schemas.microsoft.com/windows/2004/02/mit/task""><Regi
      strationInfo /><Triggers /><Principals><Principal id=""Author""><LogonType>InteractiveToken</LogonT
      ype><RunLevel>HighestAvailable</RunLevel></Principal></Principals><Settings><MultipleInstancesPolic
      y>Parallel</MultipleInstancesPolicy><DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries><
      StopIfGoingOnBatteries>false</StopIfGoingOnBatteries><AllowHardTerminate>false</AllowHardTerminate>
      <StartWhenAvailable>false</StartWhenAvailable><RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAva
      ilable><IdleSettings><StopOnIdleEnd>true</StopOnIdleEnd><RestartOnIdle>false</RestartOnIdle></IdleS
      ettings><AllowStartOnDemand>true</AllowStartOnDemand><Enabled>true</Enabled><Hidden>false</Hidden><
      RunOnlyIfIdle>false</RunOnlyIfIdle><DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteApp
      Session><UseUnifiedSchedulingEngine>false</UseUnifiedSchedulingEngine><WakeToRun>false</WakeToRun><
      ExecutionTimeLimit>PT0S</ExecutionTimeLimit></Settings><Actions Context=""Author""><Exec>
      <Command>""" ( A_IsCompiled ? A_ScriptFullpath : A_AhkPath ) """</Command>
      <Arguments>" ( !A_IsCompiled ? """" A_ScriptFullpath  """" : "" )   "</Arguments>
      <WorkingDirectory>" A_ScriptDir "</WorkingDirectory></Exec></Actions></Task>
    )"    

    TaskRoot.RegisterTask( TaskName, XML, TASK_CREATE, "", "", TASK_LOGON_INTERACTIVE_TOKEN )

  }         

Return TaskName, ErrorLevel := 0
} ; _____________________________________________________________________________________________________
