/**
 * Returns true if the given hwnd is a child window of the given parent hwnd
 * @param {integer} hwndParent A handle to the parent window
 * @param {integer} hwndChild A handle to the child window
 * @returns {bool} true, if the child is a child of the parent, false otherwise
 */
WinApi_IsChild(hwndParent, hwndChild)
{
    return DllCall("User32.dll\IsChild", "Ptr", hwndParent, "Ptr", hwndChild)
}

/**
 * Retrieves the full path of a known folder identified by the folder's KNOWNFOLDERID.
 * @param {string} FOLDERID A GUID that specifies the KNOWNFOLDERID
 * @param {integer} KF_FLAG Flags that specify special retrieval options. This value can be 0; otherwise, one or more of the KNOWN_FOLDER_FLAG values.
 * @returns {string} The known folder
 * @throws {OSError} If the folder path could not be retrieved
 * @remarks For the KNOWN_FOLDER_FLAG see https://learn.microsoft.com/en-us/windows/desktop/api/shlobj_core/ne-shlobj_core-known_folder_flag
 */
WinApi_SHGetKnownFolderPath(FOLDERID, KF_FLAG := 0)
{
    static S_OK := 0

    CLSID := Buffer(16)
    DllCall("ole32.dll\CLSIDFromString", "WStr", FOLDERID, "Ptr", CLSID)

    if (S_OK != DllCall("shell32.dll\SHGetKnownFolderPath", "Ptr", CLSID, "UInt", KF_FLAG, "Ptr", 0, "PtrP", &ppath := 0))
    {
        throw OSError(,, "SHGetKnownFolderPath")
    }
    path := ppath ? StrGet(ppath, "UTF-16") : ""
    DllCall("ole32.dll\CoTaskMemFree", "Ptr", ppath)

    return path
}