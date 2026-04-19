# MEMORY.md — Agente Domótica

## Setup

- HA OS 14.1 en Proxmox VM 100 (pve, 192.168.1.151)
- Acceso: https://ha.joseka.uk
- MCP: hass-mcp con token long-lived
- Inventario completo en DEVICES.md

## Patrones conocidos

- "luces del salón" → `light.bombillas_salon` o `light.leds_salon` según contexto
- "todas las luces" → `light.todas_las_luces`
- "persianas" sin especificar → las 3: estores_salon + persiana_derecha + persiana_izquierda
- "el ventilador" → `fan.ventilador_salon` (el activo del salón)
- "el aire" → `climate.aire_salon`
- "el robot" → scripts de robot_aspirador
- "calefactor" → escenas Broadlink IR (no hay entidad climate)
- "la tele" → `media_player.tele` + `scene.power_tv`

## Integraciones de control IR (Broadlink)

- Aire acondicionado Daikin: `climate.aire_salon`
- TV: `scene.power_tv`
- Calefactor: escenas `scene.*_calefactor`

## Automatizaciones activas

18 automations, 17 habilitadas. Destacadas:
- Luces por presencia: salón, baño, cocina, despacho
- Robot aspirador cuando no hay nadie en casa
- Sistema de notificaciones visual (Google Tasks ↔ HA slots ↔ Pixel 8 Pro)
- Aviso lavadora, baterías bajas

## Voice/Assist pipeline

- Add-ons instalados: Whisper (STT) + Piper (TTS) + openWakeWord
- Stack listo para satélite de voz
