wget "https://public-dtc.s3.us-west-002.backblazeb2.com/repo/dtcbsure-bdr/agent_install.msi" -outFile $env:windir\temp\agent_install.msi
msiexec $env:windir\temp\agent_install.msi /qn /norestart