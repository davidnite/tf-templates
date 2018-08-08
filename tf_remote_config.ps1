$tfcmd1 = '-backend-config=key='
$tfcmd2 = '.terraform.tfstate'
$path = (Get-Item -Path ".\" -Verbose).FullName
$folders = Get-ChildItem | Where-Object { ($_.PSIsContainer) -and $_.Name -notlike 'modules' } | Foreach-Object {$_.Name}
foreach ($folder in $folders) {
    $directory = $path + "\" + $folder
    cd $directory
    $prm = $tfcmd1 + $folder + $tfcmd2
    terraform remote config -backend=azure -backend-config=resource_group_name=tfState -backend-config=storage_account_name=tfstatesa963852 -backend-config=container_name=tfstate $prm
    cd $path
}