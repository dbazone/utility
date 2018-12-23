
function upload_ftp_files_subfolders ($folder){

$local_dir = $ArtifactsLocation +'/' + $folder

$files = Get-ChildItem $local_dir  -recurse
foreach($item in $files){
    $relpath = ($item.FullName).SubString(($local_dir).Length)
    $relpath = $relpath.Replace('\', '/')
    
    if ($item.Attributes -eq "Directory" ){    #create sub directiory
        CreateDirectoriesFromPath $relpath'/'  $ftp_folder_build_root$folder'/'
    }
    else
    {    #upload the file
    $uri = New-Object System.Uri( $ftp_folder_build_root + $folder  + $relpath)
	$webclient.UploadFile($uri,$item.FullName)
	Write-Host Uploaded $uri ..}
}}