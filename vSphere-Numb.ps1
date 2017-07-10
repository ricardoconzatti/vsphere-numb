######################################################################
# Created By @RicardoConzatti | January 2017
# www.Solutions4Crowds.com.br
######################################################################
cls
$vCenter = read-host "vCenter Server (FQDN or IP)"
Connect-VIServer $vCenter | Out-Null
cls

$MyDC = Get-Datacenter | Select -ExpandProperty Name
$NumDCTotal = 0
$NumClusterTotal = 0
$NumVDSTotal = 0

if ($MyDC.count -eq 0) { ### DATA CENTER ###
	write-host "`n# There is no Data Center"
}
else {
	while ($MyDC.count -ne $NumDCTotal) {
		if ($MyDC.count -eq 1) {
			$VMDC = Get-VM -Location $MyDC # Number VM
			$ESXiDC = Get-VMHost -Location $MyDC # Number ESXi
			#$RPool = $RPool.count - 1 # Number Resource Pool
			$RPoolDC = Get-Datacenter -Name $MyDC | Get-ResourcePool # Number Resource Pool
			$FolderVMDC = Get-Folder -Type VM -Location $MyDC # Number Folder VM
			$MyCluster = Get-Cluster -Location $MyDC | Select -ExpandProperty Name # Number Cluster
			$VDS = Get-VDSwitch -Location $MyDC | Select -ExpandProperty Name # Number VDS
			$DS = Get-Datastore -Location $MyDC | Select -ExpandProperty Name # Number Datastore
			$MyrealDC = $MyDC
			$NumCluster = $MyCluster.count
			$NumVDS = $VDS.count
			if ($VDS.count -eq 0) {
				$VDSmsg = "VDS: 0 (There is no VDS)"
			}
			if ($VDS.count -eq 1) {
				$PG = Get-VDPortgroup -VDSwitch $VDS | Select -ExpandProperty Name # Number Port Group
				$PGtotal = $PG
			}
			if ($VDS.count -gt 1) {
				while ($VDS.count -ne $NumVDSTotal) {
					$PG = Get-VDPortgroup -VDSwitch $VDS[$NumVDSTotal] | Select -ExpandProperty Name # Number Port Group
					$PGtotal = $PGtemp + $PG
					$PGtemp = $PGtotal
					$NumVDSTotal++;
				}
			}
		}
		if ($MyDC.count -gt 1) {
			$VMDC = Get-VM -Location $MyDC[$NumDCTotal] # Number VM
			$ESXiDC = Get-VMHost -Location $MyDC[$NumDCTotal] # Number ESXi
			#$RPoolDC = $RPoolDC.count - 1 # Number Resource Pool
			$RPoolDC = Get-Datacenter -Name $MyDC[$NumDCTotal] | Get-ResourcePool # Number Resource Pool
			$FolderVMDC = Get-Folder -Type VM -Location $MyDC[$NumDCTotal] # Number Folder VM
			$MyCluster = Get-Cluster -Location $MyDC[$NumDCTotal] | Select -ExpandProperty Name # Number Cluster
			$VDS = Get-VDSwitch -Location $MyDC[$NumDCTotal] | Select -ExpandProperty Name # Number VDS
			$DS = Get-Datastore -Location $MyDC[$NumDCTotal] | Select -ExpandProperty Name # Number Datastore
			$MyrealDC = $MyDC[$NumDCTotal]
			$NumVDS = $VDS.count
			if ($VDS.count -eq 0) {
				$VDSmsg = "VDS: 0 (There is no VDS)"
			}
			if ($VDS.count -eq 1) {
				$PG = Get-VDPortgroup -VDSwitch $VDS | Select -ExpandProperty Name # Number Port Group
				$PGtotal = $PG
			}
			if ($VDS.count -gt 1) {
				while ($VDS.count -ne $NumVDSTotal) {
					$PG = Get-VDPortgroup -VDSwitch $VDS[$NumVDSTotal] | Select -ExpandProperty Name # Number Port Group
					$PGtotal = $PGtemp + $PG
					$PGtemp = $PGtotal
					$NumVDSTotal++;
				}
			}
		}
		write-host "===========================================`n"
		write-host "DATA CENTER "$MyrealDC
		write-host "`n==========================================="
		if ($ESXiDC.count -eq 0 -And $MyCluster.count -eq 0) {
			write-host "`n# Data center is empty"
		}
		else {
			write-host "Cluster:" $MyCluster.count # Number Cluster
			if ($VDS.count -eq 0) {
				$VDSmsg
			}
			else {
				write-host "VDS:" $VDS.count # Number VDS
				$PGtotal2 = $PGtotal.count - $VDS.count
				write-host "Port Group:" $PGtotal2 # Number Port Group
			}
			write-host "Datastore:" $DS.count # Number Datastore
			$FolderVMDC = $FolderVMDC.count - 1
			write-host "Folder VM:" $FolderVMDC # Number Folder VM
			$RPoolDC = $RPoolDC.count - $NumCluster
			write-host "Resource Pool:" $RPoolDC # Number Resource Pool
			write-host "ESXi Host:" $ESXiDC.count # Number ESXi
			write-host "Virtual Machine:" $VMDC.count # Number VM
			if ($MyCluster.count -eq 0) { ### CLUSTER ###
				write-host "`n# Cluster"$MyCluster"is empty"
			}
			if ($MyCluster.count -eq 1) {
				$ESXi = Get-Cluster -Name $MyCluster | Get-VMHost # Number ESXi
				if ($ESXi.count -eq 0) { ### CLUSTER ###
					write-host "`n# There is no ESXi Host Cluster"
				}
				else {
					$RPool = Get-Cluster -Name $MyCluster | Get-ResourcePool # Number Resource Pool
					$VM = Get-Cluster -Name $MyCluster | Get-VM # Number VM
					write-host "`n# CLUSTER"$MyCluster
					$RPool = $RPool.count - 1
					write-host "Resource Pool:"$RPool # Number Resource Pool
					write-host "ESXi host:"$ESXi.count # Number ESXi
					write-host "Virtual Machine:"$VM.count # Number VM
				}
			}
			else {
				$NumClusterTotal = 0
				while ($MyCluster.count -ne $NumClusterTotal) {
					$ESXi = Get-Cluster -Name $MyCluster[$NumClusterTotal] | Get-VMHost # Number ESXi
					if ($ESXi.count -eq 0) { ### CLUSTER ###
						write-host "`n# Cluster"$MyCluster[$NumClusterTotal]"is empty"
					}
					else {
						$RPool = Get-Cluster -Name $MyCluster[$NumClusterTotal] | Get-ResourcePool # Number Resource Pool
						$VM = Get-Cluster -Name $MyCluster[$NumClusterTotal] | Get-VM # Number VM
						write-host "`n# CLUSTER"$MyCluster[$NumClusterTotal]
						$RPool = $RPool.count - 1
						write-host "Resource Pool:"$RPool # Number Resource Pool
						write-host "ESXi host:"$ESXi.count # Number ESXi
						write-host "Virtual Machine:"$VM.count # Number VM
					}
					$NumClusterTotal++;
				}
			}
		}
		$NumDCTotal++;
		write-host "`n`n"
	}
}