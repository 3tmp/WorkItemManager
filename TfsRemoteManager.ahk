class TfsRemoteManager extends IRemoteManager
{
    _baseUrl := ""
    _apiKey := ""

    __New(configFile)
    {
        if (!FileExist(configFile))
        {
            throw TargetError("The given file does not exist")
        }
        this._baseUrl := IniRead(configFile, "TFS", "Url")
        this._apiKey := IniRead(configFile, "TFS", "ApiKey")
    }

    UrlFromWorkItem(wi)
    {
        if (!IsInteger(wi.Id))
        {
            throw ValueError(Format("Cannot create url for Work Item with id '{}'", wi.Id))
        }
        return Format(this._baseUrl, wi.Id)
    }

    static WriteDefaultConfig(configFile)
    {
        IniWrite("", configFile, "TFS", "Url")
        IniWrite("", configFile, "TFS", "ApiKey")
    }
}