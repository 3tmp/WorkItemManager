class TfsRemoteManager extends IRemoteManager
{
    _baseUrl := ""
    _apiKey := ""

    __New(url, apiKey)
    {
        this._baseUrl := url
        this._apiKey := apiKey
    }

    UrlFromWorkItem(wi)
    {
        if (!IsInteger(wi.Id))
        {
            throw ValueError(Format("Cannot create url for Work Item with id '{}'", wi.Id))
        }
        return Format(this._baseUrl, wi.Id)
    }
}