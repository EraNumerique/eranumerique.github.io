# Get the current directory (timetracker) as the base path
$baseDir = Get-Location

# Initialize an empty array to store the formatted content
$output = @()

# Define common text file extensions (you can expand this list if needed)
$textFileExtensions = @(".html", ".json", ".md", ".js", ".css", ".txt")

# Recursively get all files in the directory
Get-ChildItem -Recurse -File | ForEach-Object {
    # Get the relative path from the timetracker directory
    $relativePath = $_.FullName.Substring($baseDir.Path.Length + 1).Replace('\', '/')
    
    # Check if the file has a text file extension
    if ($textFileExtensions -contains $_.Extension) {
        # Read the file content
        $content = Get-Content -Path $_.FullName -Raw -Encoding UTF8
        
        # Format the content with the relative path as tags
        $formattedContent = "<$relativePath>`n$content`n</$relativePath>"
        
        # Add to the output array
        $output += $formattedContent
    }
}

# Join all formatted content with newlines and copy to clipboard
$output -join "`n" | Set-Clipboard

# Optional: Confirm success
Write-Host "Content has been copied to the clipboard."