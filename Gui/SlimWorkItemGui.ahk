class SlimWorkItemGui extends WorkItemGuiBase
{
    _dialogHwnd := ""

    __New(manager, dialogHwnd)
    {
        super.__New(manager, "AlwaysOnTop -Caption Border Owner" dialogHwnd, "Work Item Selector")
        this._dialogHwnd := dialogHwnd
    }

    Show()
    {
        pos := this._calculateShowPosition()
        super.Show(Format("x{} y{}", pos.x, pos.y))
    }

    ; #region Abstract methods

    _eventLvDoubleClick(ctrl, lvIndex)
    {
        if (!lvIndex)
        {
            return
        }

        this._openInParent(lvIndex)
    }

    ; #endregion

    _openInParent(lvIndex)
    {
        id := this._lvIndexToId(lvIndex)
        this.Hide()
        navigator := DialogNavigator(this._dialogHwnd)
        navigator.Navigate(this._manager.GetFolderPathOfWorkItem(id))
        this.Destroy()
    }

    _calculateShowPosition()
    {
        ; Create the window so we can get its dimensions
        super.Show("Hide")
        this.GetPos(,, &width, &height)
        mon := std_Monitor.FromWindow(this._dialogHwnd)
        xMiddle := mon.WidthScaled / 2
        yMiddle := mon.HeightScaled / 2
        return {x: mon.AreaScaled.left + (xMiddle - width / 2), y: mon.AreaScaled.top + (yMiddle - height / 2)}
    }
}