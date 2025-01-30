class WorkItemManager
{
    static _iniName := "_Info.ini"
    static _iniSectionMain := "WI"

    _remoteManager := ""
    _folderPath := ""
    _items := []

    __New(folderPath, remoteManager)
    {
        folderPath := RTrim(folderPath, "\")

        if (!DirExist(folderPath))
        {
            throw ValueError(Format("The path '{}' does not exist.", folderPath))
        }

        this._remoteManager := remoteManager
        this._folderPath := folderPath
        loop files this._folderPath "\*", "D"
        {
            this._items.Push(this._loadWI(A_LoopFileFullPath))
        }
    }

    /**
     * @type {Array<WorkItem>}
     */
    WorkItems => this._items

    GetById(id) => this._getById(id)

    GetFolderPathOfWorkItem(wiOrId) => this._folderPath "\" this._getWi(wiOrId).Id

    AddNewWorkItem(wi)
    {
        if (!(wi is WorkItem))
        {
            throw TypeError("wi")
        }
        if (this._items.Contains(wi))
        {
            return
        }
        this._items.Push(wi)
        DirCreate(this._folderPath "\" wi.Id)
        this._writeWI(wi)
    }

    DeleteWorkItem(wi)
    {
        if (!(wi is WorkItem))
        {
            throw TypeError("wi")
        }
        if (!this._items.Contains(wi))
        {
            throw ValueError("Unknown Work Item")
        }
        this._items.Remove(wi)
        DirDelete(this._folderPath "\" wi.Id, true)
    }

    EditWorkItem(wi)
    {
        if (!(wi is WorkItem))
        {
            throw TypeError("wi")
        }
        ; Editing only works when we already have an item with the same id
        index := this._getIndexOfId(wi.Id)
        if (!index)
        {
            throw ValueError("Unknown Work Item")
        }

        this._items[index] := wi
        this._writeWI(wi)
    }

    SetStatus(wiOrId, status)
    {
        newStatus := WorkItemStatus.Parse(status)
        index := this._getIndexOfWi(wiOrId)
        oldWi := this._items[index]
        newWi := WorkItem(oldWi.Id, oldWi.Sprint, oldWi.Title, newStatus)
        this._items[index] := newWi
        this.EditWorkItem(newWi)
        return newWi
    }

    _loadWI(dirPath)
    {
        SplitPath(dirPath, &folderName)

        file := dirPath "\" WorkItemManager._iniName
        if (!FileExist(file))
        {
            throw ValueError(Format("The file '{}' does not exist.", file))
        }
        id := IniRead(file, WorkItemManager._iniSectionMain, "id")
        if (id != folderName)
        {
            throw ValueError(Format("The id '{}' does not match its folder path '{}'", id, dirPath))
        }
        sprint := IniRead(file, WorkItemManager._iniSectionMain, "sprint", "")
        title := IniRead(file, WorkItemManager._iniSectionMain, "title")
        status := IniRead(file, WorkItemManager._iniSectionMain, "status")
        try status := WorkItemStatus.Parse(status)
        catch
        {
            throw ValueError(Format("The status '{}' of item '{}' is invalid.", status, file))
        }
        return WorkItem(id, sprint, title, status)
    }

    _writeWI(wi)
    {
        file := this._folderPath "\" wi.Id "\" WorkItemManager._iniName
        IniWrite(wi.Id, file, WorkItemManager._iniSectionMain, "id")
        IniWrite(wi.Sprint, file, WorkItemManager._iniSectionMain, "sprint")
        IniWrite(wi.Title, file, WorkItemManager._iniSectionMain, "title")
        IniWrite(wi.Status, file, WorkItemManager._iniSectionMain, "status")
    }

    _getWi(wiOrId) => this._getById(wiOrId is WorkItem ? wiOrId.Id : wiOrId)

    _getIndexOfWi(wiOrId) => this._getIndexOfId(wiOrId is WorkItem ? wiOrId.Id : wiOrId)

    _getById(id) => this._items[this._getIndexOfId(id)]

    _getIndexOfId(id)
    {
        for wi in this._items
        {
            if (wi.Id == id)
            {
                return A_Index
            }
        }
        throw ValueError(Format("No Work Item with id '{}' exists.", id)) 
    }

    __Enum(NumberOfVars) => this._items.__Enum(NumberOfVars)
}