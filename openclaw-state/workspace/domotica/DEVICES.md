# DEVICES.md — Inventario completo de Home Assistant

## Infraestructura

- **HA OS**: 14.1 en Proxmox VM 100 (nodo "pve", 192.168.1.151)
- **Acceso**: https://ha.joseka.uk (Cloudflare Tunnel)
- **MCP**: hass-mcp configurado con token de larga duración

---

## 💡 Luces

### Grupos / Virtuales
| Entidad | Nombre | Notas |
|---------|--------|-------|
| `light.todas_las_luces` | Todas las Luces | Grupo global — usar para on/off masivo |
| `light.leds_salon` | LEDs Salón | Grupo de los segmentos WLED |
| `light.bombillas_salon` | Bombillas Salón | Grupo de las 4 bombillas del salón |
| `light.lamparas_terraza` | Lámparas Terraza | Grupo terraza |

### Salón
| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `light.bombilla_salon_derecha_1` | Bombilla Salón Derecha 1 | on/off, brillo, color |
| `light.bombilla_salon_derecha_2` | Bombilla Salón Derecha 2 | on/off, brillo, color |
| `light.bombilla_salon_izquierda_1` | Bombilla Salón Izquierda 1 | on/off, brillo, color |
| `light.bombilla_salon_izquierda_2` | Bombilla Salón Izquierda 2 | on/off, brillo, color |
| `light.leds_salon_principal` | LEDs Salón Principal | WLED, 1016 LEDs, efectos, brillo, color, animaciones |
| `light.leds_salon_segmento_1` | LEDs Salón Segmento 1 | WLED segmento |
| `light.leds_salon_segmento_2` | LEDs Salón Segmento 2 | WLED segmento |
| `light.luz_ventilador_salon` | Luz Ventilador Salón | Integrada en ventilador |

### Baño
| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `light.luz_bano` | Luz Baño | on/off |
| `light.luces_espejo_bano` | Luces Espejo Baño | on/off |

### Cocina
| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `light.luz_cocina` | Luz Cocina | on/off |

### Despacho
| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `light.ventilador_despacho_main_light` | Luz Ventilador Despacho | Integrada en ventilador |

### Terraza
| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `light.lampara_terraza_izquierda` | Lámpara Terraza Izquierda | on/off |
| `light.lampara_terraza_derecha` | Lámpara Terraza Derecha | on/off |

### PC / RGB (actualmente unavailable cuando el PC está apagado)
| Entidad | Notas |
|---------|-------|
| `light.pc_rgbs` | RGB PC Gaming — solo disponible con PC encendido |
| `light.msi_mag_b550_torpedo_ms_7c91` | Placa base MSI |
| `light.g502_lightspeed_wireless_gaming_mouse` | Ratón G502 |
| `light.evga_geforce_rtx_3090_xc3_ultra` | GPU RTX 3090 |
| `light.skyloong_gk104_pro` | Teclado Skyloong |

---

## 🪟 Persianas / Cubiertas

| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `cover.estores_salon` | Estores Salón | open/close/set_cover_position (0-100) |
| `cover.persiana_derecha` | Persiana Derecha | open/close/set_cover_position |
| `cover.persiana_izquierda` | Persiana Izquierda | open/close/set_cover_position |

> Controladas por ESPHome. position 0 = cerrado, 100 = abierto.

---

## ❄️ Clima

| Entidad | Nombre | Capacidades |
|---------|--------|-------------|
| `climate.aire_salon` | Aire Salón | Daikin via Broadlink IR. Modos: heat_cool, dry, cool, fan_only, heat. Temp: 18-30°C. Velocidades: auto, night, low, lowMedium, medium, mediumHigh, high, powerful |
| `climate.aire_salon_old` | Aire Salón (old) | ⚠️ unavailable — ignorar |

> Calefactor controlado via escenas IR (no entidad climate): ver sección Escenas.

---

## 🌀 Ventiladores

| Entidad | Nombre | Estado | Notas |
|---------|--------|--------|-------|
| `fan.ventilador_salon` | Ventilador Salón | Activo | on/off, set_percentage (velocidad) |
| `fan.ventilador_despacho_main_fan` | Ventilador Despacho | Activo | on/off, set_percentage |
| `fan.ventilador_salon_2` | Ventilador Salón 2 | ⚠️ unavailable | |
| `fan.ventilador_salon_old` | Ventilador Salón Old | ⚠️ unavailable | |
| `fan.ventilador_despacho` | Ventilador Despacho | ⚠️ unavailable | |

---

## 📺 Media Players

| Entidad | Nombre | Estado |
|---------|--------|--------|
| `media_player.tele` | Tele | off — control via Broadlink IR |
| `media_player.salon` | Salón | idle |
| `media_player.peasotele` | PeasoTele | ⚠️ unavailable |
| `media_player.salon_2` | Salón 2 | ⚠️ unavailable |

> TV: también controlable via `scene.power_tv` (Broadlink IR)

---

## 🤖 Robot Aspirador

Controlado por scripts (no entidad vacuum directa):

| Script | Función |
|--------|---------|
| `script.robot_aspirador_start` | Iniciar limpieza |
| `script.robot_aspirador_stop` | Detener |
| `script.robot_aspirador_return_to_base` | Volver a base |
| `script.robot_aspirador_pause` | Pausar (⚠️ unavailable) |

Helper: `input_boolean.robot_aspirador_activado_hoy` — indica si ya ha limpiado hoy.

---

## 🎭 Escenas

| Entidad | Función |
|---------|---------|
| `scene.estado_inicial` | Restaurar estado inicial del piso |
| `scene.power_calefactor` | Toggle encendido calefactor (Broadlink IR) |
| `scene.temporizador_calefactor` | Temporizador calefactor |
| `scene.cambiar_modo_calefactor` | Cambiar modo calefactor |
| `scene.oscilar_calefactor` | Toggle oscilación calefactor |
| `scene.subir_temperatura_calefactor` | Subir temperatura calefactor |
| `scene.bajar_temperatura_calefactor` | Bajar temperatura calefactor |
| `scene.power_tv` | Toggle TV (Broadlink IR) |

---

## 🔘 Helpers (Input Boolean)

| Entidad | Nombre | Función |
|---------|--------|---------|
| `input_boolean.automatizacion_luces_salon` | Automatización Luces Salón | Habilita/deshabilita auto de luces |
| `input_boolean.modo_cine` | Modo Cine | Activa modo cine (atenúa luces) |
| `input_boolean.tele` | Tele | Estado lógico de la TV |
| `input_boolean.robot_aspirador_activado_hoy` | Robot Activado Hoy | Evita doble limpieza |
| `input_boolean.kiosk_mode` | Modo Kiosk | Control de pantalla kiosk |

---

## 🔔 Sistema de Notificaciones

- Lista Google Tasks → `todo.notificaciones` → 10 slots (`input_text.notif_slot_1..10`)
- Las notificaciones se envían al Pixel 8 Pro con botón "✅ Completar"
- Se muestran en dashboard `/lovelace/notificaciones`

---

## 📡 Sensores clave

| Entidad | Tipo |
|---------|------|
| `binary_sensor.presencia_bano_presence` | Presencia baño (mmWave) |
| `sensor.presencia_bano_illuminance` | Iluminancia baño |
| `sensor.ambiental_bano_temperature` | Temperatura baño |
| `sensor.ambiental_bano_humidity` | Humedad baño |
| `person.carlos` | Presencia de Carlos |

---

## ⚠️ Entidades unavailable (ignorar)

Estas entidades solo funcionan con el PC de escritorio encendido:
- `light.pc_rgbs`, `light.msi_mag_b550_torpedo_ms_7c91`, `light.g502_lightspeed_wireless_gaming_mouse`, `light.evga_geforce_rtx_3090_xc3_ultra`, `light.skyloong_gk104_pro`

Entidades old/legacy (no usar):
- `climate.aire_salon_old`, `fan.ventilador_salon_2`, `fan.ventilador_salon_old`, `fan.ventilador_despacho`, `media_player.peasotele`, `media_player.salon_2`
