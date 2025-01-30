#Requires AutoHotkey v2.0
#SingleInstance Force

#Include Lib\ExtensionMethods.ahk
#Include Lib\DialogNavigator.ahk
#Include Lib\Enum.ahk
#Include Lib\KnownFolderLocations.ahk
#Include Lib\Monitor.ahk
#Include Lib\OnMessageListener.ahk
#Include Lib\WinApi.ahk

#Include WorkItem.ahk
#Include WorkItemManager.ahk
#Include WorkItemStatus.ahk

#Include Gui\AddEditWorkItemGui.ahk
#Include Gui\ListViewHelper.ahk
#Include Gui\SlimWorkItemGui.ahk
#Include Gui\WorkItemGui.ahk
#Include Gui\WorkItemGuiBase.ahk

ListLines(false)
KeyHistory(0)

WorkItemManagerVersion() => "1.0.0"

; Ini functions can only work with ansi or utf16
FileEncoding("utf-16")

A_IconTip := "Work Item Manager"
A_TrayMenu.Delete()
A_TrayMenu.Add("Öffne Gui", (*) => workGui.Show())
A_TrayMenu.Add("Über", (*) => MsgBox(Format("Work Item Manager`nVersion {}", WorkItemManagerVersion()), "Über"))
A_TrayMenu.Add()
A_TrayMenu.Add("Neu laden", (*) => Reload())
A_TrayMenu.Add("Beenden", (*) => ExitApp())
TraySetIcon("imageres.dll", 8)


manager := WorkItemManager(A_Desktop "\WI")
workGui := WorkItemGui(manager)


; Focus search bar
#HotIf WinActive("ahk_id" workGui.Hwnd)
^f::workGui.FocusSearch()
#HotIf

; Show a slim version of the gui when a save/open dialog is opened
#HotIf WinActive("ahk_class #32770")
#w::
{
    wiSelector := SlimWorkItemGui(manager, WinActive("ahk_class #32770"))
    wiSelector.Show()
}
#HotIf
; Show the full gui when no save/open dialog is opened
#w::workGui.Show()