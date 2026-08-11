#MTB Gem MTBUK V1 10aug2026
/* generated gem script to append the size of each 
subfolder in the target directory to its name.
Currently set to the current directory, 
but you can change the $TargetDirectory variable
to any path you want.
*/

#$TargetDirectory = "C:\Path\To\Your\Folder"
#$TargetDirectory = $PSScriptRoot
$TargetDirectory = ".\"

Get-ChildItem -Path $TargetDirectory -Directory | ForEach-Object {
    $Folder = $_
    $OriginalName = $Folder.Name
    
    # Calculate total size of all files inside the subfolder
    $SizeBytes = (Get-ChildItem -Path $Folder.FullName -Recurse -File -ErrorAction SilentlyContinue | 
                  Measure-Object -Property Length -Sum).Sum
                  
    if ($null -ne $SizeBytes) {
        # Format size into MB or GB
        if ($SizeBytes -ge 1GB) {
            $FormattedSize = "{0:N2}GB" -f ($SizeBytes / 1GB)
        } else {
            $FormattedSize = "{0:N2}MB" -f ($SizeBytes / 1MB)
        }

        # Handle updating existing names formatted as 'nnnnn_size.ext' or 'nnnnn_size'
        # Regular Expression breaks the name down:
        # ^(?<Base>.*?)(?:_[^_]+)?(?<Ext>\.[^.]+)?$
        if ($OriginalName -match '^(?<Base>.*?)(?:_[^_]+)?(?<Ext>\.[^.]+)?$') {
            $BaseName  = $Matches['Base']
            $Extension = $Matches['Ext'] # Will be empty string if no extension exists
            
            # Construct updated name: BaseName + _size + Extension
            $NewName = "${BaseName}_${FormattedSize}${Extension}"
            
            # Rename if the name actually changed
            if ($NewName -ne $OriginalName) {
                Rename-Item -Path $Folder.FullName -NewName $NewName -ErrorAction SilentlyContinue
            }
        }
    }
}