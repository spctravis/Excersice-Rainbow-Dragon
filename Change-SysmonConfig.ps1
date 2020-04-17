$session | foreach { Invoke-Command -Session $_ -ScriptBlock {

    #Gets the yml file and changes the ElasticIP
    $ymlfilePath = 'C:\Program Files\winlogbeats\winlogbeat.yml'
    $ymlfile = Get-Content $ymlfilePath
    
    $pattern =   'hosts\: \[\"10.0.0.200\:5045\"\]'

    $newpattern = 'hosts: ["10.0.0.200:5044"]'

    $ymlfile = $ymlfile | ForEach-Object { $_ -replace $pattern, $newpattern}
    $ymlfile | Out-File -Encoding ascii -FilePath $ymlfilePath -Force
      
   start-Service winlogbeat -Force

    } #end scriptblock

    } #end Foreach