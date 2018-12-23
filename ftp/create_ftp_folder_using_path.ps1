

function CreateDirectoriesFromPath ($DirectoryPath, $ServerPath){
 
	$DirectoryParts = $DirectoryPath.Split("/");
 
	$Position = "";
	
	for ($i = 0; $i -lt $DirectoryParts.Length - 1; $i++){
		
		try {

            $Position += $DirectoryParts[$i] + "/";	

			$AbsoluteTemporaryPath = New-Object System.Uri($ServerPath+$Position);
			Write-Host Creating Folder $AbsoluteTemporaryPath ....;

			$WebRequest = [System.Net.WebRequest]::Create($AbsoluteTemporaryPath);
			$WebRequest.KeepAlive = $false;
			#$WebRequest.Credentials = New-Object System.Net.NetworkCredential($Login, $Password);
			$WebRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory;

            #Write-Host ListDir
            #$WebRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory;

            $response = $WebRequest.GetResponse();
            Write-Host Created Folder $AbsoluteTemporaryPath ....;

            #print message from FTP server
            $responseStream = $response.GetResponseStream(); 
            $sr = new-object System.IO.StreamReader $responseStream;
            $result = $sr.ReadToEnd()
            Write-Host $result;

			
            $response.Close();

		} catch [Net.WebException] { 
            
            if ($_.Exception.Message -eq 'The remote server returned an error: (550) File unavailable (e.g., file not found, no access).')
            { Write-Host  Folder Already Exists on FTP Server-> $AbsoluteTemporaryPath; }
            else
    			{ Write-Host  Error; Write-Host $_.Exception.Message; }

            continue;
		}
	}

}



