function Get-MDSummary {
    param (
        [string]$file
    )

    $md = ConvertFrom-Markdown $file
    $tokens = $md.Tokens | Where-Object { $_.Level -in (1, 2) } | Select-Object -Property Inline, Level
    $tokens | ForEach-Object {
        $title = $_.Inline.Content.ToString().Substring($_.Span)

        if ($_.Level -eq 1) {
            Write-Output "* [$title]($file)"
        }
        else {
            $anchor = $title -replace "\s", "-"
            $anchor = $anchor -replace "\.", ""
            $anchor = [uri]::EscapeUriString($anchor)
            Write-Output "    * [$title]($file#$anchor)"
        }
    }

}


Get-ChildItem chapter*.md | `
    Select-Object -Property Name, @{Name = 'index'; Expression = { [convert]::ToInt16( (Select-String -Pattern '\d+' -InputObject $_.Name).Matches.value) } } | `
    Sort-Object -Property index |`
    ForEach-Object {
    Get-MDSummary -file $_.Name 
} | Set-Clipboard | Write-Output '结果已经复制到剪贴板'