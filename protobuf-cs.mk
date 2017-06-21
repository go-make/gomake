# support for accessing your go microservices from C# :)
# you have to manually include this, it's not part of the default gotools.mk

GRPC_CSHARP_PLUGIN_Darwin_x86_64:=tools/macosx_x64/grpc_csharp_plugin
GRPC_CSHARP_PLUGIN_Linux_x86_64:=tools/linux_x64/grpc_csharp_plugin
GRPC_CSHARP_PLUGIN_ZIPBIN:=$(GRPC_CSHARP_PLUGIN_$(shell uname -s)_$(shell uname -m))

GRPC_CSHARP_PLUGIN:=$(GOPATH)/bin/grpc_csharp_plugin
GRPC_CSHARP_TOOLS:=$(GOPATH)/bin/grpc_csharp_tools.zip

$(GRPC_CSHARP_PLUGIN): $(GRPC_CSHARP_TOOLS)
	unzip -p $< $(GRPC_CSHARP_PLUGIN_ZIPBIN) > $@
	chmod +x $@

$(GRPC_CSHARP_TOOLS): $(PROTOC)
	curl -sL https://www.nuget.org/api/v2/package/Grpc.Tools/ > $@

%.pb.cs: %.proto
	$(call PROMPT,Generating $@)
	$(call STRIP_GOGO,$<) | $(PROTOC) \
		-I$(dir $<) \
		-I$(GOPATH)/src \
		$(PROTOC_FLAGS) \
		--csharp_out $(dir $<) \
		--grpc_out $(dir $<) \
		--proto_path=/dev \
		/dev/stdin \
		--plugin=protoc-gen-grpc=$(GOPATH)/bin/grpc_csharp_plugin
	mv $(dir $<)/Stdin.cs $@
	[ -f $(dir $<)/StdinGrpc.cs ] && mv $(dir $<)/StdinGrpc.cs $(<:.proto=)_grpc.pb.cs || true