function Disable-OutdatedCryptoProtocols
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Enabled","Disabled")]
        [String]
        $Status ,

        [Parameter(Mandatory=$true)]
        [ValidateSet("SSL2","SSL3","TLS1","PCT1","TLS1.2")]
        [String[]]
        $Protocols
    )
    Begin 
    {
        Push-Location;
        Write-Verbose "Setting context to HKLM registry...";
        Set-Location HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols;
    }
    Process
    {
        Write-Verbose "Processing parameters...";
        switch($Status)
        {
            "Enabled"
            {
                Write-Verbose "Enabling Protocol(s)...";
                switch($Protocols)
                {
                    "SSL2" 
                    {  
                        Write-Verbose "Enabling SSL 2.0.";
                        if (-Not (Test-Path '.\SSL 2.0\Server')) 
                        {  
                            New-Item -Path '.\SSL 2.0\' -Name "Client" -Force;
                            New-ItemProperty -Path '.\SSL 2.0\Client\' -Name "Enabled" -Type "DWORD" -Value 1;
                            New-Item -Path '.\SSL 2.0\' -Name "Server" -Force;
                            New-ItemProperty -Path '.\SSL 2.0\Server\' -Name "Enabled" -Type "DWORD" -Value 1;
                        }
                        elseif ((Get-ItemPropertyValue '.\SSL 2.0\Server' -Name Enabled) -eq 0) 
                        {   
                            Set-ItemProperty -Path '.\SSL 2.0\Server' -Name Enabled -Value 1;
                            Set-ItemProperty -Path '.\SSL 2.0\Client' -Name Enabled -Value 1;
                        }    
                    }
                    "SSL3"
                    {
                        Write-Verbose "Enabling SSL 3.0.";
                        if (-Not (Test-Path '.\SSL 3.0\Server')) 
                        {  
                            New-Item -Path '.\SSL 3.0\' -Name "Client" -Force;
                            New-ItemProperty -Path '.\SSL 3.0\Client\' -Name "Enabled" -Type "DWORD" -Value 1;                            
                            New-Item -Path '.\SSL 3.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\SSL 3.0\Server\' -Name "Enabled" -Type "DWORD" -Value 1;
                        }
                        elseif ((Get-ItemPropertyValue '.\SSL 3.0\Server' -Name Enabled) -eq 0) 
                        {   
                            Set-ItemProperty -Path '.\SSL 3.0\Server' -Name Enabled -Value 1;
                            Set-ItemProperty -Path '.\SSL 3.0\Client' -Name Enabled -Value 1;
                        }                    
                    }
                    "TLS1"
                    {
                        Write-Verbose "Enabling TLS 1.0.";
                        if (-Not (Test-Path '.\TLS 1.0\Server')) 
                        {  
                            New-Item -Path '.\TLS 1.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\TLS 1.0\Client\' -Name "Enabled" -Type "DWORD" -Value 1;
                            New-Item -Path '.\TLS 1.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\TLS 1.0\Server\' -Name "Enabled" -Type "DWORD" -Value 1;
                        }
                        elseif ((Get-ItemPropertyValue '.\TLS 1.0\Server' -Name Enabled) -eq 0) 
                        {   
                            Set-ItemProperty -Path '.\TLS 1.0\Client' -Name Enabled -Value 1;
                            Set-ItemProperty -Path '.\TLS 1.0\Server' -Name Enabled -Value 1;
                        }                    
                    }
                    "PCT1"
                    {
                        Write-Verbose "Enabling PCT 1.0.";
                        if (-Not (Test-Path '.\PCT 1.0\Server')) 
                        {   
                            New-Item -Path '.\PCT 1.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\PCT 1.0\Client\' -Name "Enabled" -Type "DWORD" -Value 1;
                            New-Item -Path '.\PCT 1.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\PCT 1.0\Server\' -Name "Enabled" -Type "DWORD" -Value 1;
                        }
                        elseif ((Get-ItemPropertyValue '.\PCT 1.0\Server' -Name Enabled) -eq 0) 
                        {   
                            Set-ItemProperty -Path '.\PCT 1.0\Client' -Name Enabled -Value 1;
                            Set-ItemProperty -Path '.\PCT 1.0\Server' -Name Enabled -Value 1;
                        }                    
                    }
                    "TLS1.2"
                    {
                        Write-Verbose "Enabling TLS 1.2.";
                        if (-Not (Test-Path '.\TLS 1.2\Server')) 
                        {   
                            New-Item -Path '.\TLS 1.2\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\TLS 1.2\Client\' -Name "Enabled" -Type "DWORD" -Value 1;
                            New-Item -Path '.\TLS 1.2\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\TLS 1.2\Server\' -Name "Enabled" -Type "DWORD" -Value 1;
                        }
                        elseif ((Get-ItemPropertyValue '.\TLS 1.2\Server' -Name Enabled) -eq 0) 
                        {   
                            Set-ItemProperty -Path '.\TLS 1.2\Client' -Name Enabled -Value 1;
                            Set-ItemProperty -Path '.\TLS 1.2\Server' -Name Enabled -Value 1;
                        }                    
                    }              
                }
            }
            "Disabled"
            {
                Write-Verbose "Disabling Protocol(s)..."
                switch($Protocols)
                {
                    "SSL2" 
                    {  
                        Write-Verbose "Disabling SSL 2.0.";
                        if (-Not (Test-Path '.\SSL 2.0\Server')) 
                        {   
                            New-Item -Path '.\SSL 2.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\SSL 2.0\Client\' -Name "Enabled" -Type "DWORD" -Value 0;
                            New-Item -Path '.\SSL 2.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\SSL 2.0\Server\' -Name "Enabled" -Type "DWORD" -Value 0;
                        }
                        elseif ((Get-ItemPropertyValue '.\SSL 2.0\Server' -Name Enabled) -eq 1) 
                        {   
                            Set-ItemProperty -Path '.\SSL 2.0\Client' -Name Enabled -Value 0;
                            Set-ItemProperty -Path '.\SSL 2.0\Server' -Name Enabled -Value 0;
                        }    
                    }
                    "SSL3"
                    {
                        Write-Verbose "Disabling SSL 3.0.";
                        if (-Not (Test-Path '.\SSL 3.0\Server')) 
                        {   
                            New-Item -Path '.\SSL 3.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\SSL 3.0\Client\' -Name "Enabled" -Type "DWORD" -Value 0;
                            New-Item -Path '.\SSL 3.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\SSL 3.0\Server\' -Name "Enabled" -Type "DWORD" -Value 0;
                        }
                        elseif ((Get-ItemPropertyValue '.\SSL 3.0\Server' -Name Enabled) -eq 1) 
                        {   
                            Set-ItemProperty -Path '.\SSL 3.0\Client' -Name Enabled -Value 0;
                            Set-ItemProperty -Path '.\SSL 3.0\Server' -Name Enabled -Value 0;
                        }                    
                    }
                    "TLS1"
                    {
                        Write-Verbose "Disabling TLS 1.0.";
                        if (-Not (Test-Path '.\TLS 1.0\Server')) 
                        {   
                            New-Item -Path '.\TLS 1.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\TLS 1.0\Client\' -Name "Enabled" -Type "DWORD" -Value 0;
                            New-Item -Path '.\TLS 1.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\TLS 1.0\Server\' -Name "Enabled" -Type "DWORD" -Value 0;
                        }
                        elseif ((Get-ItemPropertyValue '.\TLS 1.0\Server' -Name Enabled) -eq 1) 
                        {   
                            Set-ItemProperty -Path '.\TLS 1.0\Client' -Name Enabled -Value 0;
                            Set-ItemProperty -Path '.\TLS 1.0\Server' -Name Enabled -Value 0;
                        }                    
                    }
                    "PCT1"
                    {
                        Write-Verbose "Disabling PCT 1.0.";
                        if (-Not (Test-Path '.\PCT 1.0\Server')) 
                        {   
                            New-Item -Path '.\PCT 1.0\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\PCT 1.0\Client\' -Name "Enabled" -Type "DWORD" -Value 0;
                            New-Item -Path '.\PCT 1.0\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\PCT 1.0\Server\' -Name "Enabled" -Type "DWORD" -Value 0;
                        }
                        elseif ((Get-ItemPropertyValue '.\PCT 1.0\Server' -Name Enabled) -eq 1) 
                        {   
                            Set-ItemProperty -Path '.\PCT 1.0\Client' -Name Enabled -Value 0;
                            Set-ItemProperty -Path '.\PCT 1.0\Server' -Name Enabled -Value 0;
                        }                    
                    }
                    "TLS1.2"
                    {
                        Write-Verbose "Disabling TLS 1.2.";
                        if (-Not (Test-Path '.\TLS 1.2\Server')) 
                        {   
                            New-Item -Path '.\TLS 1.2\' -Name "Client" -Force; 
                            New-ItemProperty -Path '.\TLS 1.2\Client\' -Name "Enabled" -Type "DWORD" -Value 0;
                            New-Item -Path '.\TLS 1.2\' -Name "Server" -Force; 
                            New-ItemProperty -Path '.\TLS 1.2\Server\' -Name "Enabled" -Type "DWORD" -Value 0;
                        }
                        elseif ((Get-ItemPropertyValue '.\TLS 1.2\Server' -Name Enabled) -eq 1) 
                        {   
                            Set-ItemProperty -Path '.\TLS 1.2\Client' -Name Enabled -Value 0;
                            Set-ItemProperty -Path '.\TLS 1.2\Server' -Name Enabled -Value 0;
                        }                    
                    }
                }
            }
        }
    }
    End
    {
        Write-Verbose "Removing HKLM registry context...";
        Pop-Location;
    }
}