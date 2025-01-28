class __Enum
{
    static Parse(name)
    {
        if (!this.HasProp(name))
        {
            throw ValueError("The given name is not an enum name")
        }
        return this.%name%
    }

    static Names()
    {
        result := []
        for name, _ in this
        {
            result.Push(name)
        }
        return result
    }

    static __Enum(numOfParams)
    {
        enum := this.OwnProps()
        if (numOfParams == 1)
        {
            return (&k) => Enum2(&k, &_)
        }
        else if (numOfParams == 2)
        {
            return Enum2
        }
        else
        {
            throw ValueError("numOfParams")
        }

        ; Enumerates all static properties, but skips any built in ones
        Enum2(&k, &v)
        {
            result := enum.Call(&k, &v)
            while (result && !(v is Primitive))
            {
                result := enum.Call(&k, &v)
            }
            return result
        }
    }
}