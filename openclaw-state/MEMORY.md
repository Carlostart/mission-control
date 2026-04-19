# MEMORY.md - Memoria a largo plazo

_Memoria curada de Pichita. Se actualiza automáticamente cuando algo vale la pena recordar._

## Setup

- Workspace en `/home/openclaw/workspace/main/`
- Workspace anterior: `/home/opencode/second-brain/openclaw_workspace/` (mantener para OpenCode)
- OpenClaw y OpenCode son sistemas independientes
- Knowledge base de OpenCode: `/home/opencode/second-brain/knowledge/`

## Gestión de memoria

- MEMORY.md: actualización automática cuando algo es relevante para futuras sesiones
- `memory/YYYY-MM-DD.md`: diario de sesiones — qué se habló, qué se hizo, qué se decidió

## Sobre Carlos

- Desarrollador de software .NET, horario 9-18h
- Vive solo en Málaga, piso propio
- Stack personal: Python principalmente, agnóstico al lenguaje con IA
- Editores: VSCode (principal), JetBrains (preferido)
- Fitness sin rutina fija — entrena por motivación
- Inversiones pasivas en índices y crypto (aspiracional)
- AutoDailyClips desmonetizado por "contenido reutilizado" según YouTube

## Preferencias de interacción

- Español, informal, andaluz OK
- Visual, bullets, sin párrafos largos
- Solo detalles relevantes — el resto cuando la conversación lo pida
- Sin confirmaciones innecesarias — actuar primero
- Sin adulación

## Modelos disponibles en OpenClaw

Todos habilitados para subagentes desde 2026-04-18.

### GitHub Copilot (suscripción activa de Carlos)
| Modelo | Multiplicador | Ctx | Velocidad | Mejor para |
|--------|--------------|-----|-----------|------------|
| `github-copilot/claude-sonnet-4-6` | 1x | 200k | Media-alta | **DEFAULT** — reasoning sólido, completions fiables |
| `github-copilot/claude-opus-4-6` | 3x | 200k | Lenta | Tareas complejas máxima calidad Anthropic |
| `github-copilot/gpt-5.4` | 1x | 1050k | Media | Reasoning complejo, coding avanzado, contextos largos |
| `github-copilot/gpt-5.4-mini` | 0.33x | 400k | Rápida | Subagentes ligeros, tareas simples |
| `github-copilot/gpt-4o` | 0x | 128k | Rápida | Sin coste premium, multimodal |
| `github-copilot/gpt-4.1` | 0x | 128k | Rápida | Sin coste premium, coding general |

⚠️ Claude Sonnet 4.6 se depreca el 1 mayo 2026.
⚠️ Claude Opus 4.7 disponible a 7.5x (promo hasta 30 abril 2026) — no configurado aún.

### OpenAI Codex (cuenta mrcarloscrack@gmail.com, ChatGPT Plus, auth 2026-04-18)
| Modelo | Ctx | Velocidad | Precio API | Mejor para |
|--------|-----|-----------|-----------|------------|
| `openai-codex/gpt-5.4` | 1050k | Media | $2.50/$15 por 1M tokens | Coding intensivo, contextos muy largos, agentes |
| `openai-codex/gpt-5.4-pro` | 1050k | Lenta | Premium | Máxima capacidad OpenAI |

Nota: vía GitHub Copilot el coste es por multiplicador (sin pagar por token directo). Vía Codex el coste es por tokens consumidos de la cuenta ChatGPT Plus.

## Decisiones técnicas

- Homelab: 2 portátiles Proxmox (joseka + pve), LXCs para todo
- Automatización: n8n orquestador, Python para scripts
- AutoDailyClips: flujo automatizado, revisión manual antes de publicar
- D&D en pausa, continuará en el futuro
