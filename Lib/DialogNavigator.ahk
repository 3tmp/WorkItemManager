class DialogNavigator
{
    __New(window)
    {
        this._dialog := window
    }

    /**
     * Returns the full path of the current window. Used for fallback
     * @returns {string} The full path
     */
    _getCurrentPath()
    {
        text := this._getPath()

        if (!InStr(text, "\"))
        {
            text := DialogNavigator._getPathFromLocalizedName(text)
        }
        if (!text)
        {
            throw Error("Could not get the current path from the dialog window.")
        }

        return text
    }

    /**
     * Checks if the given path is the same as the current path
     */
    static _shouldNavigate(current, target) => current != target

    /**
     * It might be possible that the adress bar only shows something like "Desktop"
     * (localized) and this relies on the language object to have a this value and compare it
     * @param {string} name The name to check
     * @returns {string} If found, the full path gets returned, "" on failure
     */
    static _getPathFromLocalizedName(name)
    {
        switch name, false
        {
            case "Desktop":
                return KnownFolderLocations.Desktop
            case "Documents", "Dokumente":
                return KnownFolderLocations.Documents
            case "Pictures", "Bilder":
                return KnownFolderLocations.Pictures
            case "Downloads":
                return KnownFolderLocations.Downloads
            case "Videos":
                return KnownFolderLocations.Videos
            case "Music", "Musik":
                return KnownFolderLocations.Music
            case "3D Objects", "3D Objekte":
                return KnownFolderLocations.Objects3D
            default:
                return ""
        }
    }

    Navigate(path)
    {
        if (!WinActive(this._dialog))
        {
            return
        }

        if (!DialogNavigator._shouldNavigate(this._getCurrentPath(), path))
        {
            return
        }

        ; Get a handle to the "Edit1" control
        edit1 := DialogNavigator._findControlByClassNN(this._dialog, "Edit1")

        ; Get the current text of the Edit1 box
        currentText := ControlGetText(edit1)

        ; Navigate
        ControlSetText(path, edit1)
        ControlFocus(edit1)
        ControlSend("{Enter}", edit1)
        ControlSetText(currentText, edit1)
    }

    _getPath(classNN := "ToolbarWindow324")
    {
        try text := std__GetWindowText(DialogNavigator._findControlByClassNN(this._dialog, classNN))
        catch
        {
            return ""
        }
        ; In case "Symbolleiste: "Adressleiste"" gets returned
        if (InStr(text, "`"") && classNN == "ToolbarWindow324")
        {
            return this._getPath("ToolbarWindow323")
        }
        ; Cut the "Adress: " part in any language
        return RegExReplace(text, "^\w*: ")
    }

    static _findControlByClassNN(parentHwnd, classNN)
    {
        dhw := DetectHiddenWindows(1)
        try hwnd := ControlGetHwnd(classNN, parentHwnd)
        DetectHiddenWindows(dhw)
        if (IsSet(hwnd) && hwnd)
        {
            return hwnd
        }
    }
}

/**
 * Returns the title of the given window
 * @param {Integer} hwnd A handle to the window
 * @returns {String} The title of the window
 */
std__GetWindowText(hwnd)
{
    ; GetWindowTextLength returns the length of the text without the terminating null character.
    ; Add +1 to include the terminating null character
    size := DllCall("user32\GetWindowTextLength", "uint", hwnd) + 1
    VarSetStrCapacity(&title, size * 2)
    DllCall("user32\GetWindowText", "ptr", hwnd, "str", title, "int", size)
    return title
}
