This repo contains links to my recent vibe-coding projects and demo's. They may break or fail, use at your own risk.
# append_size.ps1

This repository contains a PowerShell script that appends the size of each subfolder to its folder name.

## Usage

1. Open PowerShell in the repository folder.
2. Run:

```powershell
.\append_size.ps1
```

3. The script will rename each immediate subfolder in the current directory to include its size in MB/GB.

## Notes

- The script targets the current directory by default.
- You can change `$TargetDirectory` inside the script to point to another folder.
