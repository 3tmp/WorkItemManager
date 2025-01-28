/**
 * Get the correct folder locations
 * @remarks All values from https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid#constants.
 *          Value is omitted if folder type is virtual
 */
class KnownFolderLocations
{
    /** Account Pictures */
    static AccountPictures => WinApi_SHGetKnownFolderPath("{008ca0b1-55b4-4c56-b8a8-4de4b299d3be}")
    /** Administrative Tools */
    static AdminTools => WinApi_SHGetKnownFolderPath("{724EF170-A42D-4FEF-9F26-B60E846FBA4F}")
    /** AppDataDesktop */
    static AppDataDesktop => WinApi_SHGetKnownFolderPath("{B2C5E279-7ADD-439F-B28C-C41FE1BBF672}")
    /** AppDataDocuments */
    static AppDataDocuments => WinApi_SHGetKnownFolderPath("{7BE16610-1F7F-44AC-BFF0-83E15F2FFCA1}")
    /** AppDataFavorites */
    static AppDataFavorites => WinApi_SHGetKnownFolderPath("{7CFBEFBC-DE1F-45AA-B843-A542AC536CC9}")
    /** AppDataProgramData */
    static AppDataProgramData => WinApi_SHGetKnownFolderPath("{559D40A3-A036-40FA-AF61-84CB430A4D34}")
    /** Application Shortcuts */
    static ApplicationShortcuts => WinApi_SHGetKnownFolderPath("{A3918781-E5F2-4890-B3D9-A7E54332328C}")
    /** Camera Roll */
    static CameraRoll => WinApi_SHGetKnownFolderPath("{AB5FB87B-7CE2-4F83-915D-550846C9537B}")
    /** Temporary Burn Folder */
    static CDBurning => WinApi_SHGetKnownFolderPath("{9E52AB10-F80D-49DF-ACB8-4330F5687855}")
    /** Administrative Tools */
    static CommonAdminTools => WinApi_SHGetKnownFolderPath("{D0384E7D-BAC3-4797-8F14-CBA229B392B5}")
    /** OEM Links */
    static CommonOEMLinks => WinApi_SHGetKnownFolderPath("{C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D}")
    /** Programs */
    static CommonPrograms => WinApi_SHGetKnownFolderPath("{0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8}")
    /** Start Menu */
    static CommonStartMenu => WinApi_SHGetKnownFolderPath("{A4115719-D62E-491D-AA7C-E74B8BE3B067}")
    /** Startup */
    static CommonStartup => WinApi_SHGetKnownFolderPath("{82A5EA35-D9CD-47C5-9629-E15D2F714E6E}")
    /** Templates */
    static CommonTemplates => WinApi_SHGetKnownFolderPath("{B94237E7-57AC-4347-9151-B08C6C32D1F7}")
    /** Contacts */
    static Contacts => WinApi_SHGetKnownFolderPath("{56784854-C6CB-462b-8169-88E350ACB882}")
    /** Cookies */
    static Cookies => WinApi_SHGetKnownFolderPath("{2B0F765D-C0E9-4171-908E-08A611B84FF6}")
    /** Desktop */
    static Desktop => WinApi_SHGetKnownFolderPath("{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}")
    /** DeviceMetadataStore */
    static DeviceMetadataStore => WinApi_SHGetKnownFolderPath("{5CE4A5E9-E4EB-479D-B89F-130C02886155}")
    /** Documents */
    static Documents => WinApi_SHGetKnownFolderPath("{FDD39AD0-238F-46AF-ADB4-6C85480369C7}")
    /** Documents */
    static DocumentsLibrary => WinApi_SHGetKnownFolderPath("{7B0DB17D-9CD2-4A93-9733-46CC89022E7C}")
    /** Downloads */
    static Downloads => WinApi_SHGetKnownFolderPath("{374DE290-123F-4565-9164-39C4925E467B}")
    /** Favorites */
    static Favorites => WinApi_SHGetKnownFolderPath("{1777F761-68AD-4D8A-87BD-30B759FA33DD}")
    /** Fonts */
    static Fonts => WinApi_SHGetKnownFolderPath("{FD228CB7-AE11-4AE3-864C-16F3910AB8FE}")
    /** GameExplorer */
    static GameTasks => WinApi_SHGetKnownFolderPath("{054FAE61-4DD8-4787-80B6-090220C4B700}")
    /** History */
    static History => WinApi_SHGetKnownFolderPath("{D9DC8A3B-B784-432E-A781-5A1130A75963}")
    /** ImplicitAppShortcuts */
    static ImplicitAppShortcuts => WinApi_SHGetKnownFolderPath("{BCB5256F-79F6-4CEE-B725-DC34E402FD46}")
    /** Temporary Internet Files */
    static InternetCache => WinApi_SHGetKnownFolderPath("{352481E8-33BE-4251-BA85-6007CAEDCF9D}")
    /** Libraries */
    static Libraries => WinApi_SHGetKnownFolderPath("{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}")
    /** Links */
    static Links => WinApi_SHGetKnownFolderPath("{bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968}")
    /** Local */
    static LocalAppData => WinApi_SHGetKnownFolderPath("{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}")
    /** LocalLow */
    static LocalAppDataLow => WinApi_SHGetKnownFolderPath("{A520A1A4-1780-4FF6-BD18-167343C5AF16}")
    /** None */
    static LocalizedResourcesDir => WinApi_SHGetKnownFolderPath("{2A00375E-224C-49DE-B8D1-440DF7EF3DDC}")
    /** Music */
    static Music => WinApi_SHGetKnownFolderPath("{4BD8D571-6D19-48D3-BE97-422220080E43}")
    /** Music */
    static MusicLibrary => WinApi_SHGetKnownFolderPath("{2112AB0A-C86A-4FFE-A368-0DE96E47012E}")
    /** Network Shortcuts */
    static NetHood => WinApi_SHGetKnownFolderPath("{C5ABBF53-E17F-4121-8900-86626FC2C973}")
    /** 3D Objects */
    static Objects3D => WinApi_SHGetKnownFolderPath("{31C0DD25-9439-4F12-BF41-7FF4EDA38722}")
    /** Original Images */
    static OriginalImages => WinApi_SHGetKnownFolderPath("{2C36C0AA-5812-4b87-BFD0-4CD0DFB19B39}")
    /** Slide Shows */
    static PhotoAlbums => WinApi_SHGetKnownFolderPath("{69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C}")
    /** Pictures */
    static PicturesLibrary => WinApi_SHGetKnownFolderPath("{A990AE9F-A03B-4E80-94BC-9912D7504104}")
    /** Pictures */
    static Pictures => WinApi_SHGetKnownFolderPath("{33E28130-4E1E-4676-835A-98395C3BC3BB}")
    /** Playlists */
    static Playlists => WinApi_SHGetKnownFolderPath("{DE92C1C7-837F-4F69-A3BB-86E631204A23}")
    /** Printer Shortcuts */
    static PrintHood => WinApi_SHGetKnownFolderPath("{9274BD8D-CFD1-41C3-B35E-B13F55A758F4}")
    /** The user's username (%USERNAME%) */
    static Profile => WinApi_SHGetKnownFolderPath("{5E6C858F-0E22-4760-9AFE-EA3317B67173}")
    /** ProgramData */
    static ProgramData => WinApi_SHGetKnownFolderPath("{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}")
    /** Program Files */
    static ProgramFiles => WinApi_SHGetKnownFolderPath("{905e63b6-c1bf-494e-b29c-65b732d3d21a}")
    /** Program Files */
    static ProgramFilesX64 => WinApi_SHGetKnownFolderPath("{6D809377-6AF0-444b-8957-A3773F02200E}")
    /** Program Files */
    static ProgramFilesX86 => WinApi_SHGetKnownFolderPath("{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}")
    /** Common Files */
    static ProgramFilesCommon => WinApi_SHGetKnownFolderPath("{F7F1ED05-9F6D-47A2-AAAE-29D317C6F066}")
    /** Common Files */
    static ProgramFilesCommonX64 => WinApi_SHGetKnownFolderPath("{6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D}")
    /** Common Files */
    static ProgramFilesCommonX86 => WinApi_SHGetKnownFolderPath("{DE974D24-D9C6-4D3E-BF91-F4455120B917}")
    /** Programs */
    static Programs => WinApi_SHGetKnownFolderPath("{A77F5D77-2E2B-44C3-A6A2-ABA601054A51}")
    /** Public */
    static Public => WinApi_SHGetKnownFolderPath("{DFDF76A2-C82A-4D63-906A-5644AC457385}")
    /** Public Desktop */
    static PublicDesktop => WinApi_SHGetKnownFolderPath("{C4AA340D-F20F-4863-AFEF-F87EF2E6BA25}")
    /** Public Documents */
    static PublicDocuments => WinApi_SHGetKnownFolderPath("{ED4824AF-DCE4-45A8-81E2-FC7965083634}")
    /** Public Downloads */
    static PublicDownloads => WinApi_SHGetKnownFolderPath("{3D644C9B-1FB8-4f30-9B45-F670235F79C0}")
    /** GameExplorer */
    static PublicGameTasks => WinApi_SHGetKnownFolderPath("{DEBF2536-E1A8-4c59-B6A2-414586476AEA}")
    /** Libraries */
    static PublicLibraries => WinApi_SHGetKnownFolderPath("{48DAF80B-E6CF-4F4E-B800-0E69D84EE384}")
    /** Public Music */
    static PublicMusic => WinApi_SHGetKnownFolderPath("{3214FAB5-9757-4298-BB61-92A9DEAA44FF}")
    /** Public Pictures */
    static PublicPictures => WinApi_SHGetKnownFolderPath("{B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5}")
    /** Ringtones */
    static PublicRingtones => WinApi_SHGetKnownFolderPath("{E555AB60-153B-4D17-9F04-A5FE99FC15EC}")
    /** Public Account Pictures */
    static PublicUserTiles => WinApi_SHGetKnownFolderPath("{0482af6c-08f1-4c34-8c90-e17ec98b1e17}")
    /** Public Videos */
    static PublicVideos => WinApi_SHGetKnownFolderPath("{2400183A-6185-49FB-A2D8-4A392A602BA3}")
    /** Quick Launch */
    static QuickLaunch => WinApi_SHGetKnownFolderPath("{52a4f021-7b75-48a9-9f6b-4b87a210bc8f}")
    /** Recent Items */
    static Recent => WinApi_SHGetKnownFolderPath("{AE50C081-EBD2-438A-8655-8A092E34987A}")
    /** Recorded TV */
    static RecordedTVLibrary => WinApi_SHGetKnownFolderPath("{1A6FDBA2-F42D-4358-A798-B74D745926C5}")
    /** Resources */
    static ResourceDir => WinApi_SHGetKnownFolderPath("{8AD10C31-2ADB-4296-A8F7-E4701232C972}")
    /** Ringtones */
    static Ringtones => WinApi_SHGetKnownFolderPath("{C870044B-F49E-4126-A9C3-B52A1FF411E8}")
    /** Roaming */
    static RoamingAppData => WinApi_SHGetKnownFolderPath("{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}")
    /** RoamedTileImages */
    static RoamedTileImages => WinApi_SHGetKnownFolderPath("{AAA8D5A5-F1D6-4259-BAA8-78E7EF60835E}")
    /** RoamingTiles */
    static RoamingTiles => WinApi_SHGetKnownFolderPath("{00BCFC5A-ED94-4e48-96A1-3F6217F21990}")
    /** Sample Music */
    static SampleMusic => WinApi_SHGetKnownFolderPath("{B250C668-F57D-4EE1-A63C-290EE7D1AA1F}")
    /** Sample Pictures */
    static SamplePictures => WinApi_SHGetKnownFolderPath("{C4900540-2379-4C75-844B-64E6FAF8716B}")
    /** Sample Playlists */
    static SamplePlaylists => WinApi_SHGetKnownFolderPath("{15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5}")
    /** Sample Videos */
    static SampleVideos => WinApi_SHGetKnownFolderPath("{859EAD94-2E85-48AD-A71A-0969CB56A6CD}")
    /** Saved Games */
    static SavedGames => WinApi_SHGetKnownFolderPath("{4C5C32FF-BB9D-43b0-B5B4-2D72E54EAAA4}")
    /** Saved Pictures */
    static SavedPictures => WinApi_SHGetKnownFolderPath("{3B193882-D3AD-4eab-965A-69829D1FB59F}")
    /** Saved Pictures Library */
    static SavedPicturesLibrary => WinApi_SHGetKnownFolderPath("{E25B5812-BE88-4bd9-94B0-29233477B6C3}")
    /** Searches */
    static SavedSearches => WinApi_SHGetKnownFolderPath("{7d1d3a04-debb-4115-95cf-2f29da2920da}")
    /** Screenshots */
    static Screenshots => WinApi_SHGetKnownFolderPath("{b7bede81-df94-4682-a7d8-57a52620b86f}")
    /** History */
    static SearchHistory => WinApi_SHGetKnownFolderPath("{0D4C3DB6-03A3-462F-A0E6-08924C41B5D4}")
    /** Templates */
    static SearchTemplates => WinApi_SHGetKnownFolderPath("{7E636BFE-DFA9-4D5E-B456-D7B39851D8A9}")
    /** SendTo */
    static SendTo => WinApi_SHGetKnownFolderPath("{8983036C-27C0-404B-8F08-102D10DCFD74}")
    /** Gadgets */
    static SidebarDefaultParts => WinApi_SHGetKnownFolderPath("{7B396E54-9EC5-4300-BE0A-2482EBAE1A26}")
    /** Gadgets */
    static SidebarParts => WinApi_SHGetKnownFolderPath("{A75D362E-50FC-4fb7-AC2C-A8BEAA314493}")
    /** OneDrive */
    static SkyDrive => WinApi_SHGetKnownFolderPath("{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}")
    /** Camera Roll */
    static SkyDriveCameraRoll => WinApi_SHGetKnownFolderPath("{767E6811-49CB-4273-87C2-20F355E1085B}")
    /** Documents */
    static SkyDriveDocuments => WinApi_SHGetKnownFolderPath("{24D89E24-2F19-4534-9DDE-6A6671FBB8FE}")
    /** Pictures */
    static SkyDrivePictures => WinApi_SHGetKnownFolderPath("{339719B5-8C47-4894-94C2-D8F77ADD44A6}")
    /** Start Menu */
    static StartMenu => WinApi_SHGetKnownFolderPath("{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}")
    /** Startup */
    static Startup => WinApi_SHGetKnownFolderPath("{B97D20BB-F46A-4C97-BA10-5E3608430854}")
    /** System32 */
    static System => WinApi_SHGetKnownFolderPath("{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}")
    /** System32 */
    static SystemX86 => WinApi_SHGetKnownFolderPath("{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}")
    /** Templates */
    static Templates => WinApi_SHGetKnownFolderPath("{A63293E8-664E-48DB-A079-DF759E0509F7}")
    /** User Pinned */
    static UserPinned => WinApi_SHGetKnownFolderPath("{9E3995AB-1F9C-4F13-B827-48B24B6C7174}")
    /** Users */
    static UserProfiles => WinApi_SHGetKnownFolderPath("{0762D272-C50A-4BB0-A382-697DCD729B80}")
    /** Programs */
    static UserProgramFiles => WinApi_SHGetKnownFolderPath("{5CD7AEE2-2219-4A67-B85D-6C9CE15660CB}")
    /** Programs */
    static UserProgramFilesCommon => WinApi_SHGetKnownFolderPath("{BCBD3057-CA5C-4622-B42D-BC56DB0AE516}")
    /** Videos */
    static Videos => WinApi_SHGetKnownFolderPath("{18989B1D-99B5-455B-841C-AB7C74E4DDFC}")
    /** Videos */
    static VideosLibrary => WinApi_SHGetKnownFolderPath("{491E922F-5643-4AF4-A7EB-4E7A138D8174}")
    /** Windows */
    static Windows => WinApi_SHGetKnownFolderPath("{F38BF404-1D43-42F2-9305-67DE0B28FC23}")
}