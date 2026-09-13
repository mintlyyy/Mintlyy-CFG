# 🗡️ mintlyy-cfg v3 — Spy Main Edition

Config de Team Fortress 2 feita pro **mintlyy**: main **Spy** (Dead Ringer + Kunai/Big Earner),
construída em cima do [mastercomfig](https://comfig.app/) e sob medida pro hardware e pro gosto dele.

| Alvo | Valor |
|---|---|
| CPU / GPU / RAM | **i5-3470 / GT 630 / 8GB DDR3** (o gargalo é a GPU) |
| Monitor | **80Hz** |
| Internet | cabo, ping baixo e estável |
| Áudio | **headset/fone** (som posicional importa: decloak, passo, recarga) |
| Prioridade | **máximo FPS com frametime estável**, sem perder o que ganha jogo de Spy |
| Viewmodel | min viewmodels (`tf_use_min_viewmodels 1`) |
| Disfarce | pelo **menu com atalho** (MOUSE3 / tecla 4) — sem F1–F9 por padrão |
| Sapper | `MOUSE5` |

> 📖 Guia completo de tuning (launch options, NVIDIA, cm/360, interp, dicas de Spy):
> **[docs/GUIA.md](docs/GUIA.md)** · Changelog do que mudou e por quê: **[MELHORIAS.md](MELHORIAS.md)**

---

## 📦 O que tem aqui

```
cfg/overrides/          ← ÚNICA COISA QUE VOCÊ INSTALA (vai pra tf/cfg/overrides/)
├── autoexec.cfg        ← binds, mouse, toggles, aliases, limpeza de tecla morta
├── modules.cfg         ← gráficos + som + rede + HUD (todos os módulos, explícitos)
├── game_overrides.cfg  ← o que o TF2 reseta por partida (áudio, crosshair, decals)
├── spy.cfg             ← classe Spy: menu de disfarce, sapper, DR, rede do Spy
├── spy_fkeys.cfg       ← OPCIONAL: disfarce direto em F1..F9 (console: spyfkeys)
├── walkway.cfg         ← treino de facada (console: walkway)
├── null.cfg / nonull.cfg ← toggle do null-canceling movement
└── scout/soldier/pyro/demoman/heavyweapons/engineer/medic/sniper.cfg
                        ← vazios de propósito (evita erro "couldn't exec" no console)

install.bat / install.sh ← instalam tudo na pasta certa (com backup automático)
docs/GUIA.md            ← o guia de tuning e de Spy
MELHORIAS.md            ← changelog v1 → v3 e o porquê de cada mudança
backup/                 ← suas configs antigas do jogo (referência histórica)
custom-backup/          ← seus mods/huds antigos (o que estava em "custom - Copy")
```

---

## 🛠️ Instalação (3 passos)

### 1. mastercomfig (obrigatório)

Baixe pelo app oficial: **https://comfig.app/app** → escolha o preset **Low**
(o certo pro GT 630) → extraia o conteúdo em `Team Fortress 2/tf/custom/`.

> ⚠️ **Achado importante:** no seu `tf/custom/` só existia o `mastercomfig-base.vpk`
> baixado direto do GitHub. Esse arquivo é só o *core*: ele roda `preset=custom`,
> ou seja, **nenhum preset aplicado**. Confira no console com `preset_level` —
> se responder `preset=custom`, é isso. O pacote do site traz o preset junto.

### 2. esta config

**Windows:** dê dois cliques em `install.bat` (ele acha o TF2 sozinho, faz backup do
`overrides` antigo e copia tudo).

**Manual / Linux / macOS:**

```
Team Fortress 2/tf/cfg/overrides/autoexec.cfg
Team Fortress 2/tf/cfg/overrides/modules.cfg
Team Fortress 2/tf/cfg/overrides/spy.cfg
...
```

❌ **Não** coloque em `tf/custom/` — com mastercomfig, config de usuário vive em `tf/cfg/overrides/`.
❌ **Não** copie `backup/config.cfg` por cima da sua config atual: é um retrato antigo do seu jogo.

### 3. Launch options (Steam → botão direito no TF2 → Propriedades)

```
-novid -nojoy -nosteamcontroller -nohltv -particles 1
```

Detalhes, opções extras (`-freq 80`, `-dxlevel`), ajustes de NVIDIA e Windows:
**[docs/GUIA.md](docs/GUIA.md)**.

---

## ✅ Como saber que funcionou (console `~`)

```
mintlyy-cfg v3 (SPY MAIN) CARREGADA     ← aparece no boot
preset_level                            ← deve dizer preset=low (NÃO custom)
module_levels                           ← lista todos os módulos ativos
```

Teste rápido em jogo: ande apertando **W e S juntos** (não deve travar = null-cancel on),
aperte **MOUSE3** (abre o kit de disfarce) e **MOUSE5** (saca o sapper).

---

## ⌨️ Teclas

| Tecla | Ação |
|---|---|
| `MOUSE3` / `4` | abre o **menu de disfarce** (kit de Spy) |
| `MOUSE4` / `b` | **re-disfarce** do último (o jeito rápido no meio da luta) |
| `MOUSE5` | saca o **sapper** |
| `CAPSLOCK` | chamada de voz **"Spy!"** (aponte pro alvo e chame a classe) |
| `1` / `2` / `3` | revolver / sapper / faca — **já disfarçado, troca a arma do disfarce** |
| `q` | troca entre revolver e faca (lastinv) |
| `MOUSE2` | `+attack2` → com **Dead Ringer = feign death** |
| `MOUSE1` | ataque |
| `MWHEELUP` / `MWHEELDOWN` / `SPACE` | pulo (bhop no scroll) |
| `r` | recarrega **e limpa os decalques** (sangue na tela) |
| `k` | killbind (⚠️ `kill` **não** dispara o Dead Ringer — pra isso, MOUSE2) |
| `g` | taunt |
| `F10` | liga/desliga `net_graph` (fps/ping/choke) |
| `F11` | liga/desliga `cl_showpos` |
| `F12` | screenshot |
| `END` | esconde a arma (viewmodel) |
| `PGUP` / `PGDN` | FOV do viewmodel / liga-desliga min viewmodels |
| `DEL` | tamanho da mira (20 → 32) |
| `E` / `Z` `X` `C` / `V` | MEDIC! / menus de voz / push-to-talk |
| `TAB`, `,`, `.`, `m`, `Q`, `n` | placar, trocar classe, trocar time, loadout, lastinv, quickswitch |

Teclas **libertadas** (eram binds de plugin de servidor/VR/replay que não faziam nada):
`F1`–`F9`, `F11`, `[`, `INS`, `↑`, `↓`, `-`, `o`, `i`, `p`, `KP_MINUS`, `PAUSE`.
Como essas teclas vinham salvas no seu `config.cfg`, o autoexec dá `unbind` explícito nelas —
se não fizesse isso, elas continuariam "coladas".

---

## 🕹️ Comandos no console

| Comando | O que faz |
|---|---|
| `bench` / `unbench` | mostra/esconde fps + net_graph + showpos (medir desempenho) |
| `walkway` | carrega treino de facada em servidor local |
| `spyfkeys` | ativa disfarce direto em `F1`..`F9` (opcional) |
| `cleardecals` | limpa sangue/marca de tiro da tela na hora |
| `null` / `nonull` | liga/desliga null-canceling movement |
| `hudmodel_on` / `hudmodel_off` | modelo 3D no HUD (custa GPU no GT 630) |
| `net_spy_fast` / `net_spy_safe` | interp do Spy: 15ms (padrão) / 30ms (mais seguro) |
| `module_levels` / `preset_level` | mostra os módulos e o preset ativos |
| `sound_level`, `lod_level`, `shadows_level`... | mostra o valor de um módulo específico |
| `run_modules` | reaplica os módulos (depois de editar o modules.cfg em jogo) |
| `apply_overrides` | reaplica TUDO (módulos + autoexec) sem reiniciar o jogo |
| `restore_config` / `restore_preset` | volta tudo pro mastercomfig puro |

Dá pra trocar módulo **na hora**, sem editar arquivo: `sound_very_high`, `lod_medium`,
`shadows_off`, `hud_player_model_on`... e depois `run_modules` pra fixar.

---

## 🎯 Onde mexer pra cada coisa

| Quero... | Vá em |
|---|---|
| mais FPS | `modules.cfg`, seção **6** (tem as opções agressivas comentadas) |
| som com direção melhor | `modules.cfg` → `sound=very_high` |
| inimigo mais nítido de longe | `modules.cfg` → `texture_quality=medium` |
| ver meu disfarce no HUD | console: `hudmodel_on` (você paga FPS) |
| mudar sensibilidade/mira | `autoexec.cfg` → seção 2 e toggles da seção 4 |
| mudar binds | `autoexec.cfg` → seção 3 |
| disfarce direto em tecla | `spy_fkeys.cfg` (ou console: `spyfkeys`) |
| facada não registrando | console: `net_spy_safe` (30ms) e olhe o `net_graph` (choke/loss) |

---

## 🙏 Recomendados

* [mastercomfig](https://comfig.app/) — obrigatório (preset **Low** pro seu PC)
* **bxhud-sayo** ([tf2huds.dev/hud/bxhud-sayo](https://tf2huds.dev/hud/bxhud-sayo)) — o HUD que você usa (vai em `tf/custom/`)

---
*Made by mintlyy · v3 (Spy Main) — afinada com i5-3470/GT 630, 80Hz, DR+Kunai* 🕵️
