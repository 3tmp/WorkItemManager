class WorkItemGui extends WorkItemGuiBase
{
    __New(manager)
    {
        super.__New(manager,, "Work Item Manager")
    }

    ; #region Abstract methods

    _buildGui()
    {
        this._ctrlNewWIBtn := this.AddButton("xm", "Neues WI")
        this._ctrlNewWIBtn.OnEvent("Click", (ctrl, info) => this._eventNewWiBtnClick(ctrl, info))
        this._ctrlEditWIBtn := this.AddButton("x+10", "WI Bearbeiten")
        this._ctrlEditWIBtn.OnEvent("Click", (ctrl, info) => this._eventEditWiBtnClick(ctrl, info))
    }

    _eventLvDoubleClick(ctrl, lvIndex)
    {
        this._openInExplorer(lvIndex)

        if (!GetKeyState("Shift", "P"))
        {
            this.Hide()
        }
    }

    _eventLvContextMenu(ctrl, lvIndex, isRightClick, x, y)
    {
        m := Menu()
        m.Add("Öffne in Explorer", (*) => this._openInExplorer(lvIndex))
        m.SetIcon("1&", "explorer.exe", 1)
        m.Add("Öffne in Browser", (*) => this._openInBrowser(lvIndex))
        m.SetIcon("2&", "shell32.dll", 14)
        m.Add("Status", generateStatusSub(lvIndex))
        m.Add("Bearbeiten", (*) => this._contextMenuEditItemCallback(lvIndex))
        m.SetIcon("3&", "comres.dll", 7)
        m.Add("Löschen", (*) => this._eventDeleteWorkItem(lvIndex))
        m.SetIcon("4&", "imageres.dll", 51)
        m.Show()

        generateStatusSub(lvIndex)
        {
            s := Menu()
            for status in WorkItemStatus
            {
                s.Add(status, (status, *) => this._setStatus(lvIndex, status))
            }
            return s
        }
    }

    ; #endregion

    _eventNewWiBtnClick(ctrl, info)
    {
        g := AddEditWorkItemGui(this, (status, wi) => (status == "new" ? this._addWorkItem(wi) : ""))
        g.Show()
    }

    _eventEditWiBtnClick(ctrl, info)
    {
        wi := this._getSelectedWorkItem()
        if (!wi)
        {
            MsgBox("Kein Work Item ausgewählt!", "Work Item auswählen", "icon!")
            return
        }
        this._editWorkItemViaGui(wi)
    }

    _eventDeleteWorkItem(lvIndex)
    {
        id := this._lvIndexToId(lvIndex)
        wi := this._manager.GetById(id)

        yesNo := 0x4
        icon := 0x30
        if ("No" == MsgBox(Format("Soll das Work Item {} wirklich gelöscht werden?`n`n`"{}`"", wi.Id, wi.Title), "Work Item löschen", yesNo | icon))
        {
            return
        }
        this._deleteWorkItem(wi)
    }

    _contextMenuEditItemCallback(lvIndex)
    {
        wi := ListViewHelper.WorkItemFromLvIndex(this._ctrlLv, this._manager, lvIndex)
        if (!wi)
        {
            MsgBox("Kein Work Item ausgewählt!", "Work Item auswählen", "icon!")
            return
        }
        this._editWorkItemViaGui(wi)
    }

    _setStatus(lvIndex, status)
    {
        id := this._lvIndexToId(lvIndex)
        this._manager.SetStatus(id, status)
        this._loadLv()
    }

    _editWorkItemViaGui(wi)
    {
        g := AddEditWorkItemGui(this, (status, wi) => status == "edit" ? this._editWorkItem(wi) : "", wi)
        g.Show()
    }

    _editWorkItem(wi)
    {
        this._manager.EditWorkItem(wi)
        this._loadLv()
    }

    _addWorkItem(wi)
    {
        this._manager.AddNewWorkItem(wi)
        this._loadLv()
    }

    _deleteWorkItem(wi)
    {
        this._manager.DeleteWorkItem(wi)
        this._loadLv()
    }

    _openInExplorer(lvIndex)
    {
        id := this._lvIndexToId(lvIndex)
        Run(Format("explorer.exe `"{}`"", this._manager.GetFolderPathOfWorkItem(id)))
    }

    _openInBrowser(lvIndex)
    {
        id := this._lvIndexToId(lvIndex)
        Run(this._manager.GetUrlOfWorkItem(id))
    }
}