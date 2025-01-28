class ListViewHelper
{
    static Headers => ["Index", "Id", "Title", "Sprint", "Status"]

    /**
     * Returns a comparator for objects of type `{Index, WI}`
     * @type {(a, b) => Integer}
     */
    static WiComparator
    {
        get
        {
            return comparator
            comparator(a, b)
            {
                wiA := a.Wi
                wiB := b.WI
                statusA := wiA.Status
                statusB := wiB.Status

                if (statusA == statusB)
                {
                    return wiA.Id < wiB.Id ? -1 : wiA.Id > wiB.Id ? 1 : 0
                }
                if (statusA == WorkItemStatus.Closed)
                {
                    return 1
                }
                if (statusB == WorkItemStatus.Closed)
                {
                    return -1
                }
                if (statusA == WorkItemStatus.Open)
                {
                    return -1
                }
                if (statusB == WorkItemStatus.Open)
                {
                    return 1
                }
                return 0
            }
        }
    }

    static IndexOfHeader(header)
    {
        for item in ListViewHelper.Headers
        {
            if (item == header)
            {
                return A_Index
            }
        }
    }

    static LoadListView(lv, manager)
    {
        itemsByIndex := ListViewHelper._getAllWorkItemsForLv(manager)
        ListViewHelper._loadLv(lv, itemsByIndex)
        ListViewHelper._modifyCol(lv)
    }

    static Filter(lv, manager, str)
    {
        if (str == "")
        {
            return ListViewHelper._loadLv(lv, ListViewHelper._getAllWorkItemsForLv(manager))
        }

        matches := []
        for index, row in lv
        {
            internalIndex := 0
            ; Column 1 is just our internal index and 5 is status, skip them
            for column in row
            {
                if (A_Index == 1)
                {
                    internalIndex := column
                    continue
                }
                if (A_Index == 5)
                {
                    continue
                }

                if (InStr(column, str))
                {
                    matches.Push({Index: internalIndex, WI: manager.WorkItems[internalIndex]})
                    break
                }
            }
        }

        ListViewHelper._loadLv(lv, matches)
    }

    static LvIndexToId(lv, lvIndex) => lv.GetText(lv.SelectedIndex, ListViewHelper.IndexOfHeader("Id"))

    static SelectIndex(lv, lvIndex) => lv.Modify(lvIndex, "Select Focus Vis")

    static WorkItemFromLvIndex(lv, manager, lvIndex)
    {
        id := ListViewHelper.LvIndexToId(lv, lvIndex)
        try wi := manager.GetById(id)
        catch
        {
            return ""
        }
        return wi
    }

    static _loadLv(lv, items)
    {
        lv.Delete()
        for item in items
        {
            wi := item.WI
            lv.Add(, item.Index, wi.Id, wi.Title, wi.Sprint, wi.Status)
        }
    }

    static _modifyCol(lv)
    {
        lv.ModifyCol(1, "0")
        lv.ModifyCol(2, "60")
        lv.ModifyCol(3, "320")
        lv.ModifyCol(4, "AutoHdr")
        lv.ModifyCol(5, "AutoHdr")
    }

    static _getAllWorkItemsForLv(manager)
    {
        result := []
        for wi in manager
        {
            result.Push({Index: A_Index, WI: wi})
        }

        ; Sort the list
        result.Sort(ListViewHelper.WiComparator)

        return result
    }
}