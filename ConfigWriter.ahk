class ConfigurationManager
{
    __New(configfile)
    {
        if (!FileExist(configfile))
        {
            this._writeDefaultConfig()
        }
        this._configFile := configfile
    }

    WorkItemPath => this._get("General", "WorkItemFolderPath", A_Desktop "\WI")

    RemoteManager => this._get("General", "RemoteManager", "tfs")

    TfsUrl => this._get("TFS", "Url", "")

    TfsApiKey => this._get("TFS", "ApiKey", "")

    _get(section, key, defaultValue)
    {
        result := IniRead(this._configFile, section, key)
        if (!result)
        {
            this._write(defaultValue, section, key)
            result := defaultValue
        }
        return result
    }

    _write(value, section, key)
    {
        IniWrite(value, this._configFile, section, key)
    }

    _writeDefaultConfig()
    {
        ; General

        ; Currently only "tfs" is supported
        this._write("tfs", "General", "RemoteManager")
        this._write(A_Desktop "\WI", "General", "WorkItemFolderPath")

        ; TFS
        this._write("", "TFS", "Url")
        this._write("", "TFS", "ApiKey")
    }
}