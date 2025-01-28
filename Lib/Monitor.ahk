/** Provides lots of methods for display monitors. */
class std_Monitor
{
    __New(hMonitor)
    {
        this._hMonitor := hMonitor
        this._monInfo := ""
        this._dpi := ""
    }

    /**
     * Get the monitor WinApi handle
     * @type {Integer} A handle to the monitor
     */
    Handle => this._hMonitor

    /**
     * Get the width of the monitor in device pixel
     * @type {Integer} The width of the monitor
     */
    Width
    {
        get
        {
            area := this._getMonitorInfo().rcMonitor
            return std_Monitor._calcLength(area.left, area.right)
        }
    }

    /**
     * Get the width of the monitor in scaled pixel
     * @type {Integer} The width of the monitor
     * @remarks Same as the `Width`, but the values are divided by the `Scale`
     */
    WidthScaled => std_Monitor._scaleValue(this.Width, this.Scale)

    /**
     * Get the height of the monitor in device pixel
     * @type {Integer} The height of the monitor
     */
    Height
    {
        get
        {
            area := this._getMonitorInfo().rcMonitor
            return std_Monitor._calcLength(area.top, area.bottom)
        }
    }

    /**
     * Get the height of the monitor in scaled pixel
     * @type {Integer} The height of the monitor
     * @remarks Same as the `Height`, but the values are divided by the `Scale`
     */
    HeightScaled => std_Monitor._scaleValue(this.Height, this.Scale)

    /**
     * Get the whole monitor area in device pixels
     * @type {Object} An object with the keys "top", "left", "right", "bottom"
     */
    Area => this._getMonitorInfo().rcMonitor.Clone()

    /**
     * Get the whole monitor area in scaled pixels
     * @type {Object} An object with the keys "top", "left", "right", "bottom"
     * @remarks Same as the `Area`, but the values are divided by the `Scale`
     */
    AreaScaled => std_Monitor._scaleArea(this.Area, this.Scale)

    /**
     * Get the working area of the monitor in device pixels. That is the monitor area without the taskbar or any other toolbar.
     * @type {Object} An object with the keys "top", "left", "right", "bottom"
     */
    WorkArea => this._getMonitorInfo().rcWork.Clone()

    /**
     * Get the working area of the monitor in scaled pixels. That is the monitor area without the taskbar or any other toolbar.
     * @type {Object} An object with the keys "top", "left", "right", "bottom"
     * @remarks Same as the `WorkArea`, but the values are divided by the `Scale`
     */
    WorkAreaScaled => std_Monitor._scaleArea(this.WorkArea, this.Scale)

    /**
     * Determines if this is the primary monitor
     * @type {Bool} true if this is the primary monitor, false otherwise
     */
    IsPrimary => this._getMonitorInfo().dwFlags & 1

    /**
     * Get the name of the monitor
     * @type {String} The internal name of the monitor
     */
    Name => this._getMonitorInfo().szDevice

    /**
     * Get the dpi of the monitor. E.g. 96 (100% scaling), 120 (125% scaling), 144 (150% scaling), etc.
     * @type {Integer} The monitor dpi
     */
    Dpi
    {
        get
        {
            if (this._dpi == "")
            {
                oldContext := std__SetThreadDpiAwarenessContext(-4)
                this._dpi := std__GetDpiForMonitor(this._hMonitor, 0)
                std__SetThreadDpiAwarenessContext(oldContext)
            }
            return this._dpi
        }
    }

    /**
     * Get the scaling factor of the monitor, that is the DPI divided by the standard DPI (96)
     * @type {Float} Monitor scale
     */
    Scale => this.Dpi / 96

    /**
     * Get the primary monitor
     * @type {std_Monitor} The primary monitor
     */
    static Primary => std_Monitor(std__MonitorFromWindow(0, 1))

    /**
     * The monitor that the specified window is on
     * @param {std_AWindow | Integer} win The window
     * @returns {std_Monitor} The monitor that the window is on
     */
    static FromWindow(win)
    {
        hMonitor := std__MonitorFromWindow(win, 0)
        return std_Monitor(hMonitor)
    }

    /**
     * Get a list of all monitors connected to this PC.
     * @returns {std_IList<std_Monitor>} A list of `std_Monitor` of all monitors
     */
    static GetMonitors() => std__EnumDisplayMonitors().Map((mon) => std_Monitor(mon.hMonitor))

    _getMonitorInfo()
    {
        if (!this._monInfo)
        {
            oldContext := std__SetThreadDpiAwarenessContext(-4)
            MONITORINFOEX := std__GetMonitorInfo(this._hMonitor)
            this._monInfo := std__MONITORINFOEXToObject(MONITORINFOEX)
            std__SetThreadDpiAwarenessContext(oldContext)
        }
        return this._monInfo
    }

    static _scaleArea(area, factor)
    {
        return {top:    Round(area.top    / factor)
              , left:   Round(area.left   / factor)
              , right:  Round(area.right  / factor)
              , bottom: Round(area.bottom / factor)}
    }

    static _scaleValue(value, factor) => Round(value / factor)

    static _calcLength(x1, x2)
    {
        if (x1 >= 0)
        {
            return x2 - x1
        }
        if (x1 < 0 && x2 >= 0)
        {
            return Abs(x1) + x2
        }
        else
        {
            return Abs(x1) - Abs(x2)
        }
    }
}

/**
 * Set the DPI awareness for the current thread to the provided value.
 * @param {Integer} dpiContext The new DPI_AWARENESS_CONTEXT for the current thread
 * @returns {Integer} The old DPI_AWARENESS_CONTEXT for the thread. If the dpiContext is invalid,
 *          the thread will not be updated and the return value will be zero.
 *          You can use this value to restore the old DPI_AWARENESS_CONTEXT after overriding it with a predefined value.
 */
std__SetThreadDpiAwarenessContext(dpiContext)
{
    return DllCall("user32\SetThreadDpiAwarenessContext", "int", dpiContext)
}

/**
 * Queries the dots per inch (dpi) of a display.
 * @param {Integer} hMonitor Handle of the monitor being queried.
 * @param {Integer} dpiType One of the following values:
 * - MDT_EFFECTIVE_DPI (0)
 * - MDT_ANGULAR_DPI   (1)
 * - MDT_RAW_DPI       (2)
 * @returns {Integer} The dpi for this monitor
 * @throws {OSError} If the funciton failed
 */
std__GetDpiForMonitor(hMonitor, dpiType)
{
    if (0 != DllCall("SHCore\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX := 0, "uint*", &dpiY := 0))
    {
        throw OSError(,, "GetDpiForMonitor")
    }
    return dpiX
}

/**
 * Retrieves information about a display monitor.
 * @param {Integer} hMonitor A handle to the display monitor of interest.
 * @returns {Buffer} A Buffer that holds a MONITORINFOEX struct. Pass this struct to `std__MONITORINFOEXToObject` to convert to an object.
 * @throws {OSError} If the function failed
 */
std__GetMonitorInfo(hMonitor)
{
    ; MONITORINFO struct is 40 bytes. 64 for the name of the monitor
    MONITORINFOEX := Buffer(40 + 64, 0)
    NumPut("uint", MONITORINFOEX.Size, MONITORINFOEX)
    if (!DllCall("user32\GetMonitorInfo", "ptr", hMonitor, "ptr", MONITORINFOEX))
    {
        throw OSError(,, "GetMonitorInfo")
    }
    return MONITORINFOEX
}

/**
 * Converts a MONITORINFOEX Buffer or pointer to an object
 * @param {Buffer | Integer} MONITORINFOEX A MONITORINFOEX struct
 * @returns {Object} An object with the keys "rcMonitor" (a RECT object), "rcWork" (a RECT object), "dwFlags", "szDevice"
 */
std__MONITORINFOEXToObject(MONITORINFOEX)
{
    ptr := MONITORINFOEX is Buffer ? MONITORINFOEX.Ptr : MONITORINFOEX

    return {rcMonitor: std__RectPtrToObject(ptr + 4)
          , rcWork: std__RectPtrToObject(ptr + 20)
          , dwFlags: NumGet(ptr, 36, "uint")
          , szDevice: StrGet(ptr + 40, 32)}
}

/**
 * Reads the values from the RECT struct pointer and converts it to an AutoHotkey object
 * @param {Integer} pRect A pointer to the RECT struct
 * @returns {Object} An object with the keys "left", "top", "right", "bottom" 
 */
std__RectPtrToObject(pRect)
{
    return {left:   NumGet(pRect,  0, "int")
          , top:    NumGet(pRect,  4, "int")
          , right:  NumGet(pRect,  8, "int")
          , bottom: NumGet(pRect, 12, "int")}
}

/**
 * Enumerates all monitors that are connected to the PC
 * @param {Integer} hdc [optional] A handle to a display device context that defines the visible region of interest.
 * @param {Integer} lprcClip [optional] A pointer to a RECT structure that specifies a clipping rectangle.
 *        The region of interest is the intersection of the clipping rectangle with the visible region specified by hdc.
 * @param {(hMonitor, hDC, pRECT) => Bool} callback [optional] If given the callback gets called for every monitor with three params: hMonitor, hDC, pRECT (as RECT object)
 *        If the callback returns false, the enumeration gets stopped, if true gets returned, the enumeration continues
 * @returns {Integer | Array}  If a callback gets passed, the function returns the result of the `EnumDisplayMonitors` WinApi function,
 *          otherwise a list of information about all monitors as objects with the keys:
 * - "hMonitor": A handle to the monitor
 * - "hDC": A handle to the device context
 * - "rect": The coordinates of the monitor as object with the keys "left", "top", "right", "bottom"
 * @remarks For further information see https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumdisplaymonitors
 *          and https://learn.microsoft.com/en-us/windows/win32/api/winuser/nc-winuser-monitorenumproc
 */
std__EnumDisplayMonitors(hdc := 0, lprcClip := 0, callback?)
{
    if (IsSet(callback))
    {
        enumProc := CallbackCreate(MonitorEnumProcCustom, "Fast", MonitorEnumProcCustom.MinParams)
    }
    else
    {
        enumProc := CallbackCreate(MonitorEnumProc, "Fast", MonitorEnumProc.MinParams)
        monitors := []
    }
    result := DllCall("user32\EnumDisplayMonitors", "ptr", hdc, "ptr", lprcClip, "ptr", enumProc, "ptr", 0, "int")
    CallbackFree(enumProc)

    MonitorEnumProc(hMonitor, hDC, pRECT, _)
    {
        monitors.Push({hMonitor: hMonitor, hDC: hDC, rect: std__RectPtrToObject(pRECT)})
        return true
    }

    MonitorEnumProcCustom(hMonitor, hDC, pRECT, _)
    {
        return callback(hMonitor, hDc, std__RectPtrToObject(pRECT))
    }

    return IsSet(callback) ? result : monitors
}

/**
 * Retrieves a handle to the display monitor that has the largest area of intersection with the bounding rectangle of a specified window.
 * @param {Integer} hwnd A handle to the window
 * @param {Integer} dwFlags One of the following values:
 * - MONITOR_DEFAULTTONEAREST (0x2): Returns a handle to the display monitor that is nearest to the window.
 * - MONITOR_DEFAULTTONULL    (0x0): Returns NULL.
 * - MONITOR_DEFAULTTOPRIMARY (0x1): Returns a handle to the primary display monitor.
 * @returns {Integer} If the window intersects one or more display monitor rectangles,
 *          the return value is an HMONITOR handle to the display monitor that has the largest area of intersection with the window.
 *          If the window does not intersect a display monitor, the return value depends on the value of dwFlags.
 */
std__MonitorFromWindow(hwnd, dwFlags)
{
    return DllCall("user32\MonitorFromWindow", "ptr", hwnd, "int", dwFlags, "ptr")
}