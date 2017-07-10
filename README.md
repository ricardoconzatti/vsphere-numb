# vSphere-Numb

Este script pode ser útil para verificar os números do seu ambiente VMware vSphere. O script utiliza o vSphere PowerCLI para se conectar ao vCenter Server e executar diversas ações. O script executa apenas GET, mas de qualquer forma recomendo que seja feito uma analise e entendimento do código antes de executar em ambiente de produção.

 - **Ações que o Script executa (números)**
	 - Data Center
	 - Cluster
	 - VDS (não funciona com VSS)
	 - Port Group
	 - Datastore
	 - Folder
	 - Resource Pool
	 - Host ESXi
	 - Máquina virtual
	 - Cluster
	 - Resource Pool
	 - Host ESXi
	 - Máquina virtual
 - **Compatibilidade**
	 - vSphere (ESXi e vCenter)
		 - Testado nas versões 5.1, 5.5, 6.0 e 6.5
	 - PowerCLI
		 - Recomendo a versão 6 ou superior
 - **Pré-requisitos**
	 - vCenter Server (Windows ou Appliance) versão 5 ou superior
		 - Garantir que o vCenter esteja acessivel pela rede
	 - VMware vSphere PowerCLI versão 6 ou superior

[Mais informações](http://solutions4crowds.com.br/script-vsphere-numb)
