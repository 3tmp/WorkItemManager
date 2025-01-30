class AddEditWorkItemGui extends Gui
{
    /** @type {WorkItem | Void} */
    _wi := ""
    /** @type {Func} */
    _callback := ""

    /**
     * @param {Gui} parent 
     * @param {('new'|'edit'|'cancel', WorkItem?) => Void} resultCallback The result of the operation
     * @param {WorkItem} wi [optional] The WorkItem to edit
     */
    __New(parent, resultCallback, wi?)
    {
        super.__New("owner" parent.Hwnd, IsSet(wi) ? "Work Item bearbeiten" : "Neues Work Item")
        this._callback := resultCallback
        this._wi := wi ?? ""

        this.OnEvent("Escape", (*) => this._cancel())

        this.AddText(, "Id")
        this._ctrlIdEdit := this.AddEdit("Number w300", IsSet(wi) ? wi.Id : "")
        if (IsSet(wi))
        {
            ; Prevent the user from editing the id when in edit mode
            this._ctrlIdEdit.Enabled := false
        }
        this.AddText(, "Titel")
        this._ctrlTitleEdit := this.AddEdit("w300", IsSet(wi) ? wi.Title : "")
        this.AddText(, "Sprint")   
        this._ctrlSprintEdit := this.AddEdit("w300", IsSet(wi) ? wi.Sprint : "")
        this.AddText(, "Status")
        this._ctrlStatusDdl := this.AddDropDownList("w300 Choose" _statusToIndex(IsSet(wi) ? (wi.Status) : WorkItemStatus.Active), WorkItemStatus.Names())

        this._ctrlOkBtn := this.AddButton("Default", "Ok")
        this._ctrlOkBtn.OnEvent("Click", (ctrl, info) => this._okBtnClick(ctrl, info))

        _statusToIndex(status)
        {
            for name in WorkItemStatus
            {
                if (name = status)
                {
                    return A_Index
                }
            }
            return 1
        }
    }

    Destroy()
    {
        this._callback := ""
        super.Destroy()
    }

    _cancel()
    {
        callback := this._callback
        callback("cancel", "")
        this.Destroy()
    }

    _okBtnClick(ctrl, info)
    {
        sprint := this._ctrlSprintEdit.Text
        if (this._ctrlTitleEdit.Text == "" || (sprint !== "" && !RegExMatch(sprint, "^\d{4}\.\d{2}$")))
        {
            MsgBox("Falsche Werte", "Error", "iconx")
            return
        }
        if (this._ctrlIdEdit.Text == "")
        {
            yesNo := 0x4
            icon := 0x30
            if (MsgBox("WorkItem ohne Id erstellen?", "Achtung", yesNo | icon) == "No")
            {
                return
            }
        }

        this.Hide()
        status := WorkItemStatus.Parse(this._ctrlStatusDdl.Text)
        wi := WorkItem(this._ctrlIdEdit.Text, this._ctrlSprintEdit.Text, this._ctrlTitleEdit.Text, status)
        callback := this._callback
        callback(this._wi ? "edit" : "new", wi)
        this.Destroy()
    }
}