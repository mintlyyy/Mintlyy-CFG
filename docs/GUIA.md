# 🕵️ GUIA — mintlyy-cfg v3 (Spy Main, i5-3470 + GT 630, 80Hz)

Tudo o que eu não coloquei dentro dos `.cfg` porque depende do Windows, do Steam
ou do seu gosto. Ordem: instalação → sistema → mouse → rede → som → Spy → problemas.

---

## 1. Como os arquivos se encaixam (ordem real de carregamento)

Isso é o que o `cfg/autoexec.cfg` que vem dentro do `mastercomfig-base.vpk` (9.100.1) executa:

```
comfig/define_presets.cfg → overrides/pre_init.cfg → comfig/comfig.cfg
  → overrides/setup_hook.cfg → preset (low/medium/...) → overrides/modules.cfg
  → run_modules → overrides/autoexec.cfg → comfig/finalize.cfg
```

E a cada **troca de classe**: `cfg/<classe>.cfg` → `overrides/<classe>.cfg`
E a cada **entrada em partida**: `comfig/game_overrides.cfg` → `overrides/game_overrides.cfg`

**Conclusão prática:** `modules.cfg` = gráficos/som/rede/HUD · `autoexec.cfg` = binds e
preferências (e ele **vence** os módulos, porque roda depois) · `game_overrides.cfg` =
o que o TF2 reseta sozinho · `spy.cfg` = só Spy.

---

## 2. Launch options (Steam → TF2 → Propriedades)

**Use estas (doc oficial do mastercomfig):**

```
-novid -nojoy -nosteamcontroller -nohltv -particles 1
```

| Opção | O que faz |
|---|---|
| `-novid` | pula o logo da Valve (boot mais rápido) |
| `-nojoy` | não inicia sistema de joystick (menos memória) |
| `-nosteamcontroller` | evita conflito de input do controle |
| `-nohltv` | não hospeda SourceTV |
| `-particles 1` | limita a 512 beams — alívio real de GPU no GT 630 |

**Opcionais que valem pro seu caso:**

* `-freq 80` → força 80Hz se o TF2 não detectar seu monitor direito.
* `-w 1600 -h 900` → só se quiser fixar resolução (o normal é usar as opções de vídeo).
* `-dxlevel 90` → **só no primeiro boot, depois remova**. Baixa o nível de shader
  (mais FPS, visual mais simples). Sem isso, o TF2 escolhe sozinho pelo seu GT 630.
* `-console` → abre o console já no boot (útil enquanto testa).

Referência completa: https://docs.comfig.app/latest/customization/launch_options/

---

## 3. Windows / NVIDIA (GT 630 = Kepler, driver 391.35 é o último)

**Painel de Controle NVIDIA → Gerenciar configurações 3D → Programa: hl2.exe / tf_win64.exe**

| Opção | Valor | Por quê |
|---|---|---|
| Modo de gerenciamento de energia | **Preferir desempenho máximo** | evita o clock baixo em menu/tab |
| Filtragem de textura — Qualidade | **Alto desempenho** | filtro bilinear barato |
| Otimização de thread | **Ativado** | aproveita os 4 núcleos do i5-3470 |
| V-Sync | **Desligado** | VSync = input lag de mouse (o módulo já está `vsync=off`) |
| Triplo buffer | Desligado | idem |

**Windows:**

* Propriedades de `hl2.exe` → Compatibilidade → **Desativar otimizações de tela cheia**.
* Jogue em **tela cheia** (não janela sem borda) — menos overhead de composição.
* Feche navegador/Discord overlay no fundo: em 4 núcleos, cada processo conta.
* Se quiser frametime ainda mais estável que o cap interno do TF2, use **RTSS**
  (MSI Afterburner) com limitador em 120 e `fpscap=unlimited` no `modules.cfg`.

---

## 4. Resolução e o botão de emergência de FPS

O GT 630 é seu gargalo. Ordem de ganho, do maior pro menor:

1. **Resolução**: 1920x1080 → **1600x900** (~30% menos pixels) → 1280x720.
   Não muda nada na sua sensibilidade (é `cm/360`, não pixel).
2. **`mat_viewportscale 0.75`** no console: o jogo renderiza 75% e estica.
   Ganho grande, preço = imagem borrada. Dá pra bindar:
   `bind "KP_PLUS" "toggle mat_viewportscale 1 0.75"`
3. `modules.cfg` **seção 6** (degraus agressivos prontos, um por linha).
4. Baixar textura: `texture_quality=low` (já está) e `texture_filter=blocky` (já está).

Meça sempre com **`bench`** (liga fps + net_graph + showpos) e depois **`unbench`**.
Frametime estável > FPS alto: 120 travado é melhor que 150 pulando.

---

## 5. Mouse — a tabela de cm/360

Fórmula do TF2/Source: `cm/360 = (360 / (sensibilidade × DPI × 0.022)) × 2.54`

Sua config hoje: **sens 2.5 @ 1600 DPI = ~10,4 cm/360**.

| Sensibilidade (1600 DPI) | cm/360 | Perfil |
|---|---|---|
| 2.5 (atual) | **10,4 cm** | muito rápido — flick de 180º no pulso, mas errinho de revolver aparece |
| 2.0 | 13,0 cm | ainda rápido |
| 1.7 | 15,3 cm | começo do "range de Spy" |
| 1.5 | 17,3 cm | meio do range — bom pra facada + tiro |
| 1.3 | 20,0 cm | precisão e consistência |
| 1.0 | 26,0 cm | estilo "aim de Sniper" (exige espaço de mouse) |

Spy não vive de mira, vive de **posição** — mas o revolver de 40 de dano paga as contas.
Se quiser testar: mude no console (`sensitivity 1.7`), jogue 2 partidas, e só então edite
o `autoexec.cfg`. Não mexa em `m_pitch` / `m_yaw`: são o "espelho" do seu mouse e sair do
padrão atrapalha memória muscular e incomoda em qualquer config futura.

---

## 6. Rede e interp (por que 15ms pra Spy)

* `packet_rate=standard` = 66 pacotes/s (o máximo que servidores TF2 mandam).
* `snapshot_buffer=auto` aplica **por classe**. Pra Spy: `net_spy` =
  **`cl_interp_ratio 1` (15ms de lerp)** + **`cl_smooth 0`**.
* Lerp menor = você vê o inimigo mais perto da posição real no servidor = facada e
  tiro registram "na hora". O preço é mais sensibilidade a **perda de pacote**.
* Se um dia levar facada que não registra e a sua **internet de cabo** estiver
  oscilando, use `net_spy_safe` (30ms). Pra voltar: `net_spy_fast`.

**Como ler o `net_graph` (F10 = liga):**

| Campo | Bom | Ruim quer dizer |
|---|---|---|
| `ping` | estável, < 60ms | subindo e descendo = Wi-Fi/rota ruim |
| `choke` | **0** | você manda mais pacote do que a conexão aceita (com 66/66 fica 0) |
| `loss` | **0** | perda real: aqui o lerp maior (`net_spy_safe`) ajuda |
| `fps` | ≥ 80 sempre | se cai em fight, use a seção 6 do modules.cfg |

---

## 7. Som — a arma do Spy

O que a v3 faz:

1. `snd_surround_speakers 0` = **headphone mode** (a sua cfg antiga estava em 2 = caixas).
2. `sound=high` no módulo = espacialização e posicionamento completos
   (sua cfg antiga usava `snd_pitchquality 0` + `dsp_slow_cpu 1` = módulo `sound=low`, som achatado).
3. `snd_surround_speakers 0` é reaplicado a **cada partida** (`game_overrides.cfg`),
   porque o TF2 tem bug de resetar isso pra "2 speakers".
4. `snd_mute_losefocus 0` = você continua ouvindo o jogo quando perde o foco (alt-tab).

**Checklist de áudio no Windows:**

* Painel de Som → Fone → "Configurar alto-falantes" = **Estéreo** (não 5.1/7.1) se o
  fone é estéreo puro. Config errada do Windows bagunça a espacialização do jogo.
* **Windows Sonic / Dolby / 7.1 virtual do fabricante**: experimente ligado e desligado.
  O jogo já espacializa; processamento dobrado pode "lavar" a direção.
* "Áudio mono" desligado no Windows (isso sim destrói direção de som).
* Teste prático: no `walkway`, ande em volta de um bot e feche os olhos — você deve
  conseguir apontar de onde vem o tiro. É esse reflexo que salva de Sniper e Spy.

---

## 8. Spy — o que a config te dá e como usar

### Disfarce: a arma mostrada é o SEU slot

| Você está segurando | O disfarce mostra |
|---|---|
| slot1 — revolver | arma **primária** da classe (rocket, minigun, scatter...) |
| slot2 — sapper | arma **secundária** (medigun, sticky, shotgun) |
| slot3 — faca | arma **corpo a corpo** (wrench, kukri, bat) |

→ Disfarce de **Medic com medigun**: segure o **sapper** e dispare o disfarce.
→ Disfarce de **Engineer com wrench**: segure a **faca** e disfarce.
→ Já disfarçado, **1/2/3** troca a arma do disfarce sem refazer o disfarce.
→ `-2` no console (`disguise 2 -2`) = disfarce de **aliado**: bom pra andar no meio do
  time inimigo em flanco e enganar sniper/Sentry de longe.

### Dead Ringer (sua loadout)

* **MOUSE2 = feign death.** O `kill` (k) **não** ativa o DR — morte real é morte real.
* Depois do feign você fica invisível e pode andar: o relógio recarrega conforme o dano
  que você recebe, então às vezes vale **deixar levar tiro** pra voltar pro combate antes.
* `ragdolls=medium` no `modules.cfg` é o que te permite ver **corpo falso** de DR inimigo
  (ragdoll com física, no chão, da "morte" que apareceu no killfeed). Não desligue.
* Kills com **Kunai** te dão vida acima do normal; com **Big Earner** você ganha
  velocidade e relógio. O DR + esses dois = jogo de "matar, sumir, voltar".

### Disfarces que colam (dica de comunidade, não regra)

* Prefira classes que fazem sentido estando **atrás**: Demoman, Soldier, Scout, Sniper.
* **Pyro** é a classe que mais "checa" Spy; disfarce de Pyro costuma denunciar você.
* Engenheiro longe da base, ou Medic correndo pra frente = também chamam atenção.
* Ande olhando pra onde a "classe" olharia: Sniper disfarçado mirando o céu = suspeito.

### Facada

* Facada é **posição**, não mira. Entre pelas costas **andando**, nunca de frente.
* `net_spy` (15ms) é o ajuste que faz a facada registrar mais rápido; se ficar "no-reg",
  cheque `choke`/`loss` no net_graph e teste `net_spy_safe`.
* Depois de matar, saia da rota: você tem revolver fraco e 125 de vida.

---

## 9. Problemas comuns

| Sintoma | O que fazer |
|---|---|
| Console não abre | launch option `-console`; ou o módulo `console=off` foi ativado (rode `console_on`) |
| `MOUSE3` não abre o disfarce | no console: `bind MOUSE3` (deve responder `slot4`); se não, `bind MOUSE3 slot4` |
| `MOUSE5` não saca nada | console: `bind MOUSE5` (deve responder `slot2`); senão, `bind MOUSE5 slot2` |
| FPS caiu de repente | `bench` pra medir; `module_levels` pra ver se algum módulo mudou; `hudmodel_off` |
| Som sem direção | `snd_surround_speakers` (deve ser 0); ver a seção 7 |
| Facada não registra | `net_graph` → `choke`/`loss`; teste `net_spy_safe` |
| Quero tudo de volta ao mastercomfig puro | `restore_preset` (módulos) ou `restore_config` (tudo) |
| Editei o cfg em jogo | `run_modules` (só módulos) ou `apply_overrides` (tudo, sem reiniciar) |
| Quero saber o que está ativo | `module_levels`, `preset_level`, `version_comfig`, e `sound_level`, `lod_level`, `shadows_level`... (um módulo por vez) |

---

## 10. Cola de módulos (console, sem editar arquivo)

Qualquer nível pode ser aplicado na hora — digite e depois `run_modules`:

```
lod=low|medium|high        lighting=low|medium|high|very_low
shading=low|medium|high    shadows=off|low|medium|high
effects=very_low|low|...   water=very_low|low|medium|high
texture_quality=low|medium|high|very_high|ultra
texture_filter=blocky|trilinear|aniso2x|...|aniso16x
sound=low|medium|high|very_high|ultra
ragdolls=off|medium|high   fpscap=120|160|90|75|unlimited
hud_player_model=on|off    outlines=off|low|medium|high|ultra
killstreaks=off|low|high   match_hud=on|off
```

`restore_preset` volta tudo pros valores do preset que você baixou (low).
