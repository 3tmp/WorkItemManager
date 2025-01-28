class __ExtensionMethods
{
    static __New()
    {
        defProp := Object.Prototype.DefineProp

        ; #region Any, String, Number

        defProp(Array.Prototype, "Equals", {Call: (this, other) => this == other})
        defProp(Array.Prototype, "ToString", {Call: (this) => this.__Class})

        ; String
        defProp(String.Prototype, "Equals", {Call: (this, other, caseSense := 1) => Type(other) == "String" ? StrCompare(this, other, caseSense) == 0 : false})
        defProp(String.Prototype, "ToString", {Call: (this) => this})

        ; Number
        defProp(Number.Prototype, "ToString", {Call: (this) => String(this)})

        ; #endregion

        ; #region Array

        defProp(Array.Prototype, "Sort", {Call: (this, callback) => _arraySort(this, callback, 1, this.Length)})
        defProp(Array.Prototype, "Contains", {Call: (this, item) => _arrayIndexOf(this, item) != -1})
        defProp(Array.Prototype, "Remove", {Call: (this, item) => _arrayRemove(this, item)})
        defProp(Array.Prototype, "Clear", {Call: (this) => ((len := this.Length) ? this.RemoveAt(1, len) : "")})

        _arraySort(arr, callback, left, right)
        {
            if (arr.Length > 1)
            {
                centerIdx := _arrayPartition(arr, callback, left, right)
                if (left < centerIdx - 1)
                {
                    _arraySort(arr, callback, left, centerIdx - 1)
                }
                if (centerIdx < right)
                {
                    _arraySort(arr, callback, centerIdx, right)
                }
            }
        }

        _arrayPartition(arr, callback, left, right)
        {
            pivot := arr[Floor(left + (right - left) / 2)]
            , i := left
            , j := right

            while (i <= j)
            {
                ; arr[i] < pivot
                while (callback(arr[i], pivot) < 0)
                {
                    i++
                }
                ; arr[j] > pivot
                while (callback(arr[j], pivot) > 0)
                {
                    j--
                }
                if (i <= j)
                {
                    _arraySwap(arr, i, j)
                    , i++
                    , j--
                }
            }

            return i
        }

        _arraySwap(arr, index1, index2)
        {
            tmp := arr[index1]
            arr[index1] := arr[index2]
            arr[index2] := tmp
        }

        _arrayIndexOf(arr, item)
        {
            for _item in arr
            {
                if (item.Equals(_item))
                {
                    return A_Index
                }
            }
            return -1
        }

        _arrayRemove(arr, item)
        {
            index := _arrayIndexOf(arr, item)
            if (index != -1)
            {
                return !!arr.RemoveAt(index)
            }
            return false
        }

        ; #endregion

        ; #region Gui

        ; Gui.ListView
        defProp(Gui.ListView.Prototype, "SelectedIndex", {Get: (this) => this.GetNext()})

        defProp(Gui.ListView.Prototype, "__Enum", {Call: (this, numOfParams) => _guiLvEnum(this, numOfParams)})

        ; Gui.Edit
        defProp(Gui.Edit.Prototype, "Placeholder", {Set: (this, value) => _guiSend(this, EM_SETCUEBANNER := 0x1501, true, StrPtr(value))})

        defProp(Gui.Edit.Prototype, "TextLength", {Get: (this) => _guiSend(this, WM_GETTEXTLENGTH := 0x000E, 0, 0)})

        defProp(Gui.Edit.Prototype, "CaretPosition", {Set: (this, pos) => _guiCaretPos(this, pos)})

        _guiSend(ctrl, msg, wParam?, lParam?) => SendMessage(msg, wParam?, lParam?, ctrl)

        _guiLvEnum(this, numOfParams)
        {
            if (numOfParams != 1 && numOfParams != 2)
            {
                throw ValueError("numOfParams")
            }

            columns := this.GetCount("Col")
            rows := this.GetCount()
            current := 0

            return numOfParams == 1 ? (&v) => enum2(&_, &v) : enum2

            enum2(&k, &v)
            {
                current++
                if (current > rows)
                {
                    return false
                }

                k := current
                v := {Columns: columns,
                      GetText: (thisObj, column) => this.GetText(current, column),
                      GetAllText: (thisObj) => getAll(this, columns, current),
                      __Enum: (thisObj, numOfParams) => getAll(this, columns, current).__Enum(numOfParams)}
                return true

                static getAll(lv, columns, index)
                {
                    result := []
                    loop columns
                    {
                        result.Push(lv.GetText(index, A_Index))
                    }
                    return result
                }
            }
        }

        _guiCaretPos(this, pos)
        {
            pos := pos = "end" ? this.TextLength : pos = "start" ? 0 : pos
            return _guiSend(this, EM_SETSEL := 0xB1, pos, pos)
        }

        ; #endregion
    }
}