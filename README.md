This is an unofficial image of the [Cloudpilot PalmOS Emulator](https://cloudpilot-emu.github.io/).
It is based on the official nginx base image and is built directly from the [official Github repository](https://github.com/cloudpilot-emu/cloudpilot) with no modifications made to the source.

Example usage: `docker run -p 8080:80 nimdarotartsi/cloudpilot`

Using the network proxy on a self-hosted instance of Cloudpilot will not work out of the
box and requires additional configuration to the proxy server. Please check out the
[documentation](https://github.com/cloudpilot-emu/cloudpilot/blob/master/doc/networking.md#running-cloutpilot-locally-or-on-another-domain)
for more details.

On Docker Hub at https://hub.docker.com/r/nimdarotartsi/cloudpilot
