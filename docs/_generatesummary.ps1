function Get-MDSummary {
    param (
        [string]$file
    )

    $md = ConvertFrom-Markdown $file
    $tokens = $md.Tokens | Where-Object { $_.HeaderChar -eq '#' -and $_.Level -le 2 }
    $tokens | ForEach-Object {
        $title = $_.Inline

        if ($_.Level -eq 1) {
            Write-Output "* [$title]($file)"
        }
        else {
            $anchor = $title -replace "\s", "-"
            $anchor = [System.Web.HttpUtility]::UrlEncode($anchor)
            Write-Output "    * [$title]($file#$anchor)"
        }
    }

}


Get-ChildItem chapter*.md | `
    Select-Object -Property Name, @{Name = 'index'; Expression = { [convert]::ToInt16( (Select-String -Pattern '\d+' -InputObject $_.Name).Matches.value) } } | `
    Sort-Object -Property index |`
    ForEach-Object {
    Get-MDSummary -file $_.Name 
} | Set-Clipboard