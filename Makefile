help:
	@echo -- HeliumOS ISO --
	@echo Requires: lorax
	@echo make fetch - Fetch upstream iso
	@echo make patch - Patch upstream iso to produce final iso
	@echo make create - Fetch if needed, then patch
fetch:
	rm -f upstream.iso
	curl -o upstream.iso -J -L https://download.cf.centos.org/10-stream/BaseOS/x86_64/iso/CentOS-Stream-10-latest-x86_64-boot.iso
patch:
	rm -f new.iso
	mkksiso --ks heliumos.ks upstream.iso new.iso --volid heliumos-boot	
	mv new.iso HeliumOS-10-latest-x86_64-boot.iso	
create:
	if [ -e upstream.iso ] ; then echo "Upstream iso present" ; else make fetch ; fi
	make patch
