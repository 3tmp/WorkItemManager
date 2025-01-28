class WorkItem
{
    _id := ""
    _sprint := ""
    _title := ""
    _status := ""

    __New(id, sprint, title, status)
    {
        this._id := id
        this._sprint := sprint
        this._title := title
        this._status := status
    }

    Id => this._id
    Sprint => this._sprint
    Title => this._title
    Status => this._status

    ToString() => Format("WI {}: {} ({})", this._id, this._sprint, this._title)

    Equals(other)
    {
        return this == other ||
        other.__Class == WorkItem.Prototype.__Class &&
        this._id == other._id &&
        this._sprint == other._sprint &&
        this._title == other._title &&
        this._status == other._status
    }
}