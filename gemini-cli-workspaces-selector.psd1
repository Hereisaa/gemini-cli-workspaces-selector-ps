@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'gemini-cli-workspaces-selector.psm1'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PowerShell Host Name
    PowerShellVersion = '5.1'

    # ID used to uniquely identify this module
    GUID = 'c8e1a12a-8d7d-4b8c-9e2a-7e1d1a1d1a1d'

    # Author of this module
    Author = 'hereisaa'

    # Company or vendor of this module
    CompanyName = 'Unknown'

    # Copyright statement for this module
    Copyright = '(c) 2026 Gemini CLI Workspaces Selector Contributors. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'A powerful workspace selector and launcher for Gemini CLI.'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('ws', 'gws')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()

    # List of all modules packaged with this module
    ModuleList = @()

    # List of all files packaged with this module
    FileList = @()

    # Private data to pass to the module specified in RootModule. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('Gemini', 'CLI', 'Workspace', 'Selector', 'PowerShell')
            # A URL to the license for this module.
            LicenseUri = 'https://opensource.org/licenses/MIT'
            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/hereisaa/gemini-cli-workspaces-selector'
        }
    }
}
