# os-agent

宿主机侧 D-Bus 代理服务，服务于 **Muthur Command OS**。  
它通过系统 D-Bus（`io.muthurcommand.os`）向 Supervisor 暴露需要特权的宿主机能力，避免让 Supervisor 以不受限的宿主机模式运行。

## 发布产物

- Debian 安装包（用于 Supervised 安装）：见[最新发布](https://github.com/muthur-command/os-agent/releases/latest)
- 在 MCOS 镜像中：由 `operating-system` 构建流程预装
- D-Bus 服务名：**`io.muthurcommand.os`**
- 根对象路径：**`/io/muthurcommand/os`**

## 安装 / 升级

对于 **Muthur Command OS**，无需手动安装（已预装）。

对于 **Muthur Command Supervised（Debian）**：

```shell
sudo dpkg -i os-agent_<version>_linux_<arch>.deb
```

## 验证

```bash
busctl introspect --system io.muthurcommand.os /io/muthurcommand/os
```

若命令返回 introspection 信息，则服务可用。

## 卸载

```shell
sudo dpkg -r os-agent
```

## 开发

本地编译：

```shell
go build -ldflags "-X main.version=<dev-version>"
```

快速 D-Bus 检查：

```shell
gdbus introspect --system --dest io.muthurcommand.os --object-path /io/muthurcommand/os
gdbus call --system --dest io.muthurcommand.os --object-path /io/muthurcommand/os/Boards/Yellow --method org.freedesktop.DBus.Properties.Set io.muthurcommand.os.Boards.Yellow PowerLED "<false>"
```

## 来源

- **上游：** [home-assistant/os-agent](https://github.com/home-assistant/os-agent)
- **本仓库：** 面向 Muthur Command OS 宿主机集成与 Supervisor 兼容持续维护
- **许可证：** Apache-2.0（保留上游版权），见 [`LICENSE`](./LICENSE)
