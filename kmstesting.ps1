# SLMGR docs
# https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn502540(v=ws.11)



$Search = @("3F0YBH2","CR1ZLP2","457NJH2","CQ3XLP2","457NJH2","BJ21MP2","CQ2XLP2","533X0G2","CQFYLP2")
#"43DBXM2"
#"H4GCH12"

# /skms cinkms01.dinslaw.com:1688
# /dlv
# /ato
# /ckms This option removes the specified KMS host name, address, and port information from the registry and restores KMS auto-discovery behavior.

$win7list =  get-content "M:\scripts\win7list.txt"

foreach ($computer in $win7list) { slmgr.vbs $computer /ckms }

$win7list =  get-content "M:\scripts\win7list.txt"

foreach ($computer in $win7list)