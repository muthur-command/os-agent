# os-agent

中文文档: [`README.zh-CN.md`](./README.zh-CN.md)

Host-side D-Bus agent for **Muthur Command OS**.  
It exposes privileged host capabilities to Supervisor over system D-Bus
(`io.muthurcommand.os`) without running Supervisor with unrestricted host access.

## Release Artifacts

- Debian package (for Supervised installs): from [latest release](https://github.com/muthur-command/os-agent/releases/latest)
- In MCOS images: preinstalled by the `operating-system` build pipeline
- D-Bus service name: **`io.muthurcommand.os`**
- Root object path: **`/io/muthurcommand/os`**

## Install / Upgrade

For **Muthur Command OS**, no manual action is required (preinstalled).

For **Muthur Command Supervised (Debian)**:

```shell
sudo dpkg -i os-agent_<version>_linux_<arch>.deb
```

## Verify

```bash
busctl introspect --system io.muthurcommand.os /io/muthurcommand/os
```

If the command returns introspection data, the service is reachable.

## Uninstall

```shell
sudo dpkg -r os-agent
```

## Development

Build locally:

```shell
go build -ldflags "-X main.version=<dev-version>"
```

Quick D-Bus checks:

```shell
gdbus introspect --system --dest io.muthurcommand.os --object-path /io/muthurcommand/os
gdbus call --system --dest io.muthurcommand.os --object-path /io/muthurcommand/os/Boards/Yellow --method org.freedesktop.DBus.Properties.Set io.muthurcommand.os.Boards.Yellow PowerLED "<false>"
```

## Origin

- **Upstream:** [home-assistant/os-agent](https://github.com/home-assistant/os-agent)
- **In this repo:** maintained for Muthur Command OS host integration and Supervisor compatibility
- **License:** Apache-2.0 (retain upstream copyright); see [`LICENSE`](./LICENSE)
