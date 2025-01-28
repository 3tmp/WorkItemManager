/** A class that wraps the `OnMessage()` function. As soon as the object gets destroyed, it stops listening */
class std_OnMessageListener
{
    __New(msg, callback)
    {
        if (!Type(msg) == "Integer")
        {
            throw TypeError("Msg has to be an integer")
        }
        this._msg := msg
        this._callback := callback
        OnMessage(this._msg, this._callback, 1)
    }

    __Delete()
    {
        OnMessage(this._msg, this._callback, 0)
        this._callback := unset
    }
}