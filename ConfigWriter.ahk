class ConfigManager
{
    static WriteDefaultConfig(configFile)
    {
        ; General

        ; Currently only "tfs" is supported
        IniWrite("", configFile, "General", "RemoteManager")
        IniWrite("", configFile, "General", "WorkItemFolderPath")

        ; TFS
        IniWrite("", configFile, "TFS", "Url")
        IniWrite("", configFile, "TFS", "ApiKey")
    }
}