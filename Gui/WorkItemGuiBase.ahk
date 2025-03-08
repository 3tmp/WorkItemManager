class WorkItemGuiBase extends Gui
{
    /** @type {WorkItemManager} */
    _manager := ""
    /** @type {std_OnMessageListener} */
    __keyDownListener := ""

    __New(manager, options?, title?)
    {
        super.__New(options?, title?)
        this._manager := manager

        this.OnEvent("Escape", (*) => this.Hide())

        this.__keyDownListener := std_OnMessageListener(WM_KEYDOWN := 0x100, (wParam, lParam, msg, hwnd) => this.__onWM_KEYDOWN(wParam, lParam, msg, hwnd))

        this.__buildGui()
    }

    Destroy()
    {
        this.__keyDownListener := ""
        super.Destroy()
    }

    FocusSearch() => this._ctrlSearchEdit.Focus()

    Show(options?)
    {
        super.Show(options?)
        this.FocusSearch()
    }

    __buildGui()
    {
        this._ctrlSearchEdit := this.AddEdit("w545")
        this._ctrlSearchEdit.Placeholder := "Suche nach Work Items..."
        this._ctrlSearchEdit.OnEvent("Change", (ctrl, info) => this.__eventSearchBarChange(ctrl, info))

        ; -LV0x10 -> No header reorder
        this._ctrlLv := this.AddListView("w545 r30 -LV0x10 -Multi", ListViewHelper.Headers)
        this._ctrlLv.OnEvent("ContextMenu", (ctrl, lvIndex, isRightClick, x, y) => this.__eventLvContextMenu(ctrl, lvIndex, isRightClick, x, y))
        this._ctrlLv.OnEvent("DoubleClick", (ctrl, lvIndex) => this._eventLvDoubleClick(ctrl, lvIndex))
        this._loadLv()

        this._buildGui()
    }

    _lvIndexToId(lvIndex) => ListViewHelper.LvIndexToId(this._ctrlLv, lvIndex)

    _loadLv() => ListViewHelper.LoadListView(this._ctrlLv, this._manager)

    _selectIndex(lvIndex) => ListViewHelper.SelectIndex(this._ctrlLv, lvIndex)

    _getSelectedWorkItem() => ListViewHelper.WorkItemFromLvIndex(this._ctrlLv, this._manager, this._ctrlLv.SelectedIndex)

    ; #region Abstract methods

    _buildGui()
    {
    }

    _eventLvDoubleClick(ctrl, lvIndex)
    {
    }

    _eventLvContextMenu(ctrl, lvIndex, isRightClick, x, y)
    {
    }

    ; #endregion

    __eventLvContextMenu(ctrl, lvIndex, isRightClick, x, y)
    {
        if (!lvIndex)
        {
            return
        }

        this._eventLvContextMenu(ctrl, lvIndex, isRightClick, x, y)
    }

    __eventSearchBarChange(ctrl, info) => ListViewHelper.Filter(this._ctrlLv, this._manager, ctrl.Value)

    __onWM_KEYDOWN(wParam, lParam, msg, hwnd)
    {
        try
        {
            if (this.Hwnd != hwnd && !WinApi_IsChild(this.Hwnd, hwnd))
            {
                return
            }
        }
        catch
        {
            ; Catch "Gui has no window" error
            return
        }

        switch key := GetKeyName(Format("vk{:x}", wParam))
        {
            case "Enter", "Up", "Down":
                this.__processNavigationKey(key)

            case "AppsKey":
                ; Prevent the key propagation to the Edit control

            default:
                if (!this._ctrlSearchEdit.Focused)
                {
                    ; The returned key has the name that ahk internally uses, so we can use the
                    ; name and send the key to the control. Not very performant, but good enough
                    ControlSend("{" key "}", this._ctrlSearchEdit.Hwnd)
                    ; Set back the focus to the edit control
                    this._ctrlSearchEdit.Focus()
                    this._ctrlSearchEdit.CaretPosition := "end"
                }
        }
    }

    __processNavigationKey(key)
    {
        if (key = "Enter")
        {
            this.__ensureRowSelected()
            this._eventLvDoubleClick(this._ctrlLv, this._ctrlLv.SelectedIndex)
            return
        }
        ; If the control has already keyboard focus, we do not need to handle the keys ourself
        if (!this._ctrlLv.Focused)
        {
            this._ctrlLv.Focus()
            if (key = "Up")
            {
                this.__selectPrevIndex()
            }
            else if (key = "Down")
            {
                this.__selectNextIndex()
            }
        }
    }

    __ensureRowSelected()
    {
        if (this._ctrlLv.SelectedIndex)
        {
            return
        }
        this.__selectNextIndex()
    }

    __selectNextIndex()
    {
        selectedIndex := this._ctrlLv.SelectedIndex
        count := this._ctrlLv.GetCount()

        ; Very unlikly, but we can't select a row, because there are none
        if (count == 0)
        {
            return
        }

        ; We are at the end, do nothing
        if (selectedIndex == count)
        {
            return
        }

        this._selectIndex(selectedIndex + 1)
    }

    __selectPrevIndex()
    {
        selectedIndex := this._ctrlLv.SelectedIndex
        count := this._ctrlLv.GetCount()

        ; Very unlikly, but we can't select a row, because there are none
        if (count == 0 || !selectedIndex)
        {
            return
        }

        ; No item is selected, select the first one
        if (selectedIndex == 0)
        {
            this._selectIndex(1)
        }

        ; We are at the begin, do nothing
        if (selectedIndex == 1)
        {
            return
        }

        this._selectIndex(selectedIndex - 1)
    }
}