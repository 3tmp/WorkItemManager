class RemoteManagerFactory
{
    /**
     * Creates a new remote manager
     * @param {"tfs"} managerId The identifier of the remote manager
     * @param {ConfigurationManager} configManager
     * @returns {IRemoteManager}
     */
    static CreateManager(managerId, configManager)
    {
        if (managerId = "tfs")
        {
            return TfsRemoteManager(configManager.TfsUrl, configManager.TfsApiKey)
        }
        else
        {
            throw ValueError(Format("Unknown remote manager id '{}'", managerId))
        }
    }
}