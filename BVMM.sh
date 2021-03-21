#!/bin/bash

ISODIR="/mnt/uwu/isos"
VMDIRECTORY="/mnt/uwu/drives"
cd $VMDIRECTORY
cat .template.sh && clear || echo "Template was not located, Downloading..." && wget "https://raw.githubusercontent.com/Kimitzuni/BVMM/master/.template.sh"
echo "Bash Virtual Machine Manager"
echo ""
echo "[ 1 ] Start VM"
echo "[ 2 ] Create VM"
echo "[ 3 ] Exit"
echo ""
read choice

[[ -z $choice ]] && echo "Select an option"
if [[ $choice == "1" ]]; then
	echo ""
	echo "Available Virtual Machines"
	echo ""
	ls *.sh | sed 's/.sh//g' | sed 's/BVMM//g' | sed 's/ //g'
	echo ""
	read vm
	"./$vm.sh" || echo "This VM could not be found, are you sure you typed it correctly? You don't need to put the .sh extension if you put it." || echo "HOW?!"
fi

if [[ $choice == "2" ]]; then
	echo ""
	
	echo "Virtual Machine Name"
	read vmname
	
	echo "ISO Name"
	read isoloc
	
	echo "Amount of RAM (MiB)"
	read ram

	echo "# of cores"
	read cores

	echo "Save to"
	read save
	savefile=$save".sh"

	echo "#!/bin/bash" >> $savefile
	echo "" >> $savefile
	echo "VMNAME=\"$vmname\"" >> $savefile
	echo "VMLOCATION=\"$VMDIRECTORY\"" >> $savefile
	echo "VMDRIVE=\"\$VMLOCATION/\$VMNAME.qcow2\"" >> $savefile
	echo "CPU=\"Nehalem-v2\"" >> $savefile
	echo "CPUFLAGS=\"-hypervisor,+vmx\"" >> $savefile
	echo "CPUVENDOR=\"GenuineIntel\"" >> $savefile
	echo "MACHINE=\"q35\"" >> $savefile
	echo "ACCEL=\"kvm\"" >> $savefile
	echo "VGA=\"qxl\"" >> $savefile
	echo "CDROM=\"$ISODIR/$isoloc\"" >> $savefile
	echo "USBINPUT=\"tablet\"" >> $savefile
	echo "MEMORY=\"$ram\"" >> $savefile
	echo "CORES=\"$cores,cores=$cores\"" >> $savefile
	echo ""
	echo "$(cat .template.sh)" >> $savefile
	echo ""
	chmod +x $savefile
	echo "Saved"
fi
