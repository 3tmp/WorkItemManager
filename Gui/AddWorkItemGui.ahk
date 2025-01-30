class AddWorkItemGui extends AddEditWorkItemGuiBase
{
    __New(parent, resultCallback)
    {
        super.__New(parent, resultCallback)
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

        wi := WorkItem(this._ctrlIdEdit.Text, this._ctrlSprintEdit.Text, this._ctrlTitleEdit.Text, WorkItemStatus.Active)
        callback := this._callback
        callback(wi)
        this.Destroy()
    }
}