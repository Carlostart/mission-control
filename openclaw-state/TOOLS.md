# TOOLS.md - Setup específico

## Infraestructura

### Homelab
| Nodo | IP | Specs | Rol |
|------|-----|-------|-----|
| **joseka** (Node 1) | 192.168.1.49 | Intel Core Ultra 7 165H, 32GB RAM, Proxmox 9.1 | Nodo principal |
| **pve** (Node 2) | 192.168.1.151 | Intel i5-6300HQ, 8GB RAM, Proxmox | Nodo secundario |
| **LXC 101** (Docker host) | 192.168.1.50 | Debian 12, 4GB RAM, 160GB | n8n, MinIO, Portainer UI |
| **LXC 102** (Docker host prod) | 192.168.1.52 | hostname: docker-autodaily | AutoDailyClips, n8n real |
| **LXC 201** (OpenClaw/OpenCode) | 192.168.1.53 | Ubuntu 22.04, 8GB RAM, 250GB | Este LXC — OpenClaw + OpenCode |
| **VM 100** (Home Assistant) | DHCP vía vmbr0 | 4GB RAM, 32GB | HAOS 2026.4.2 |

> ⚠️ No hay acceso SSH directo desde este LXC a joseka/pve/LXC101 — interacción vía APIs/MCP.
> ✅ SSH configurado a LXC 102 (192.168.1.52, root) — usado para deploy AutoDailyClips.

### Servicios accesibles
| Servicio | URL | Notas |
|---------|-----|-------|
| Home Assistant | https://ha.joseka.uk | Acceso vía MCP |
| n8n | http://192.168.1.52:5678 | Workflows de automatización (host real: .52) |
| Portainer | https://192.168.1.50:9443 | Gestión Docker — API key en env `PORTAINER_API_KEY` |
| OpenCode web | http://192.168.1.53:3000 | Agente de código |
| OpenClaw Control UI | https://openclaw.joseka.uk | Esta interfaz |
| MinIO | http://192.168.1.50:9000 | Object storage |

### AutoDailyClips
- **Repo prod**: root@192.168.1.52:/root/LSF/ (git, en sync con master)
- **Repo dev**: `/home/opencode/dev/AutoDailyCompilation/` (worktree en LXC 201)
- **Container prod**: `lsf-autodaily-1` (stack desincronizado con Portainer — pendiente reimportar)
- **Email canal**: autodailyclips@gmail.com
- **Flujo**: Python scripts → n8n → YouTube upload (revisión manual antes de publicar)
- **API real**: `http://192.168.1.52:1110`
- **n8n real**: `http://192.168.1.52:5678`
- **Portainer**: `https://192.168.1.50:9443` — EndpointId Dell=4, Acer=5
- **Deploy correcto** (stack sin GitConfig → Portainer /git/redeploy da 405, NO funciona):
  1. `ssh root@192.168.1.52`
  2. `cd /root/LSF && git stash && git pull`
  3. `docker stop lsf-autodaily-1 && docker rm lsf-autodaily-1`
  4. `docker compose up --build -d`
- **Exec vía Portainer API**: `POST /api/endpoints/4/docker/containers/{id}/exec` → start
- **Logs vía Portainer API**: `GET /api/endpoints/4/docker/containers/{id}/logs?tail=N`
- **Bug Selenium zombie (arreglado 2026-04-18)**: `setup_basic_driver()` sin timeouts → fix con `set_page_load_timeout(30)` + `asyncio.wait_for(timeout=35)` + `finally: driver.quit()`

---

## MCP activos

| MCP | Qué hace | Herramientas clave |
|-----|---------|-------------------|
| **exa** | Búsqueda web semántica | web_search, crawling, código |
| **google_workspace** | Google personal de Carlos | Calendar, Tasks, Drive, Sheets, Docs |
| **home_assistant** | Control domótica | Entidades, automaciones, estados, historial |
| **grep_mcp** | Búsqueda de código en GitHub | Búsqueda por patrón en repos públicos |
| **pymupdf4llm** | Leer PDFs | Convierte PDF a markdown |
| **ref-tools** | Documentación de APIs | Referencia de librerías y SDKs |

---

## Herramientas nativas del sistema

| Herramienta | Disponible | Notas |
|-------------|-----------|-------|
| `ssh` | ✅ | Acceso configurado a LXC 102 (root@192.168.1.52) para deploy AutoDailyClips |
| `ffmpeg` | ✅ | Procesamiento de vídeo/audio |
| `python3` | ✅ | v3.10.12 |
| `node` | ✅ | v22.22.2 |
| `browser` | ❌ | Sin binario de Chrome/Chromium en este LXC |
| `docker` | ✅ | v29.4.0 — requiere `--security-opt apparmor=unconfined` o usar docker-compose con `security_opt: [apparmor=unconfined]` |
| `yt-dlp` | ❌ | No instalado |
| `trash` | ❌ | No instalado — usar `rm` con precaución |

---

## Skills de OpenClaw disponibles (relevantes)

| Skill | Para qué sirve |
|-------|---------------|
| `weather` | Tiempo via wttr.in / Open-Meteo |
| `video-frames` | Extraer frames/clips de vídeos con ffmpeg |
| `healthcheck` | Auditoría de seguridad del sistema |
| `taskflow` | Tareas duraderas multi-step |
| `node-connect` | Diagnóstico de pairing de nodos |
| `skill-creator` | Crear/editar skills |
| `opencode-bridge` | Delegar tareas dev/código a OpenCode via ACP (en `skills/opencode-bridge/`) |
| `opencode-controller` | Control avanzado de sesiones OpenCode (en `skills/opencode-controller/`) |

## Agentes del sistema

| Agente | ID | Workspace | Para qué delegar |
|--------|-----|-----------|-----------------|
| **Pichita** (yo) | `main` | `/home/openclaw/workspace/main/` | Orquestador, canal principal |
| **Domo** | `domotica` | `/home/openclaw/workspace/domotica/` | Domótica HA — luces, persianas, clima, robot |
| **OpenCode** | — | `/home/opencode/second-brain/` | Dev, código, research técnico (via opencode-bridge) |

## Pendiente instalar / configurar

> Estos elementos están planificados pero NO disponibles aún. No afirmar que funcionan.

| Elemento | Estado | Bloque del plan |
|----------|--------|----------------|
| Docker en LXC 201 | ✅ v29.4.0 | Fix AppArmor: `/etc/systemd/system/docker.service.d/override.conf` con `Environment=container=docker` |
| Git worktrees | ✅ | Directorio base `/home/opencode/dev/` |
| Plugin opencode-mission-control | ⚠️ Instalado, NO activo | Experimental (40 descargas/mes) — no activado en config |
| Plugin opencode-devcontainers | ⚠️ Instalado, NO activo | Experimental — no activado en config |
| Mission Control dashboard | ❌ Pendiente | Bloque 3 |
| claude-mem | ❌ Pendiente | Bloque 4 - Memoria IA |
| SwarmVault | ❌ Pendiente | Bloque 4 - Memoria IA |
| Obsidian | ❌ Pendiente | Bloque 4 - Memoria IA |

---

## Canales activos

| Canal | Estado | Notas |
|-------|--------|-------|
| **Telegram** | ✅ | Canal móvil principal (@Carlostart, ID 253008002) |
| **Control UI (webchat)** | ✅ | https://openclaw.joseka.uk |

---

## Modelos configurados

Todos habilitados para subagentes desde 2026-04-18.

**Regla de providers**: Modelos Claude → `github-copilot/`, Modelos GPT → `openai/`

| Modelo | Multiplicador | Ctx | Velocidad | Uso |
|--------|--------------|-----|-----------|-----|
| `github-copilot/claude-sonnet-4-6` | 1x | 200k | Media-alta | **DEFAULT** |
| `github-copilot/claude-opus-4-6` | 3x | 200k | Lenta | Máxima calidad Anthropic |
| `openai/gpt-5.4` | 1x | 1050k | Media | Reasoning, coding avanzado |
| `openai/gpt-5.4-mini` | 0.33x | 400k | Rápida | Subagentes ligeros |
| `github-copilot/gpt-4o` | 0x | 128k | Rápida | Sin coste, multimodal |
| `github-copilot/gpt-4.1` | 0x | 128k | Rápida | Sin coste, coding general |

⚠️ Claude Sonnet 4.6 deprecado el 1 mayo 2026.
⚠️ Claude Opus 4.7 disponible a 7.5x promo hasta 30 abril 2026.
