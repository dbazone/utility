

function CreateDirectoriesFromPath ($DirectoryPath, $ServerPath){
 
	$DirectoryParts = $DirectoryPath.Split("/");
 
	$Position = "";
	
	for ($i = 0; $i -lt $DirectoryParts.Length - 1; $i++){
		
		try {

            Write-Host $ServerPath+$Position

			$AbsoluteTemporaryPath = New-Object System.Uri($ServerPath+$Position);
			Write-Host $AbsoluteTemporaryPath 

			$WebRequest = [System.Net.WebRequest]::Create($AbsoluteTemporaryPath);
			$WebRequest.KeepAlive = $false;
			#$WebRequest.Credentials = New-Object System.Net.NetworkCredential($Login, $Password);
			$WebRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory;
			$WebRequest.GetResponse();
			
		} catch [Net.WebException] { 
			Write-Host $_.Exception.Message; continue;
		}
	}

}



