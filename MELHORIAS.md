# 🗡️ mintlyy-cfg v3 — o que mudou e por quê

Base: **mastercomfig 9.100.1** (verificado direto no código-fonte do release).
Perfil usado pra decidir cada número: **i5-3470 + GT 630 + 8GB DDR3**, **monitor 80Hz**,
internet de **cabo**, **headset estéreo**, main **Spy** com **Dead Ringer + Kunai/Big Earner**,
min viewmodels, disfarce **pelo menu**, sapper no **MOUSE5**.

---

## 🐛 Bugs e armadilhas corrigidos nesta versão

| # | Problema | Consequência | Correção na v3 |
|---|---|---|---|
| 1 | `snd_surround_speakers` estava em **2 (stereo speakers)** num headset | Você perdia parte do **posicionamento** — o pior defeito possível pra um Spy (decloak/passo com direção errada) | `snd_surround_speakers 0` (headphone mode) no `autoexec.cfg` **e** no `game_overrides.cfg`, porque o TF2 tem um bug conhecido de **resetar** isso pra "2 speakers" sozinho |
| 2 | `hud_player_model=on` num **GT 630** | O modelo 3D no canto custa GPU nível "médio" (a doc do mastercomfig diz isso explicitamente) — no seu caso é engasgo de graça | `hud_player_model=off` + aliases `hudmodel_on` / `hudmodel_off` pra você ligar de volta sem editar arquivo |
| 3 | `MOUSE5` (sapper) e `MOUSE4` (re-disfarce) só existiam no `spy.cfg` | Antes de você virar Spy, esses botões ficavam com o bind velho do `config.cfg` (`+sap`, comando inexistente) = **botão morto** | Binds do mouse agora são **globais** no `autoexec.cfg` (e reforçados no `spy.cfg`) |
| 4 | Teclas com binds de plugin/VR/replay que não fazem nada em servidor normal (`sm_thrdperson`, `ds_mark`, `ds_record`, `graphtoggle`, `yellowcycle`, `vr_toggle`, `vr_reset_home_pos`, `replay_togglereplaytips`) + duplicatas (`o`, `i`, `p`, `KP_MINUS`, `PAUSE`) | Teclas mortas e confusão na hora de bindar algo novo | Bloco de **`unbind` explícito**. Isso é obrigatório: o TF2 reaplica o `config.cfg` salvo no boot, então só "não escrever" não libera a tecla |
| 5 | Faltavam **7 dos 9 class configs** (`scout`, `pyro`, `demoman`, `heavyweapons`, `engineer`, `medic`, `sniper`) | Console logava `couldn't exec overrides/x.cfg` a cada troca de classe | Stubs criados (vazios, comentados): console limpo e, se um dia você jogar sério de outra classe, o arquivo já existe |
| 6 | Não existia `game_overrides.cfg` (que o mastercomfig carrega **a cada partida e a cada troca de classe**) | Tudo que o TF2 reseta — speaker config, crosshair, autoreload, decalque na tela — ficava resetado | Arquivo criado com o mínimo seguro: áudio, crosshair, autoreload/fastswitch, limpar decalquess |
| 7 | `cl_smooth` não era garantido em nenhum lugar | O Spy do mastercomfig usa `cl_smooth 0`; se algo sobrescrevesse, seu "feel" mudava sem aviso | Reforçado no `autoexec.cfg` e no `spy.cfg` (via `net_spy`) |
| 8 | Bind `DEL` mexia na mira só de **29 a 32** | Praticamente impossível achar o tamanho que você gosta | Faixa real: **20 a 32** |
| 9 | `hud_saytext_time 5` | Chat inimigo sumia rápido demais (e é onde o time avisa "spy!") | **8 segundos** |
| 10 | Console cheio de cvar gráfica "solta" no autoexec (v1) / tudo duplicado | Conflito entre módulo e cvar manual, e você sem saber quem mandava | Gráfico/som/rede **100% no `modules.cfg`**, e eu deixei documentado **todos os módulos**, um por um |

---

## 🔍 Correções nas anotações erradas da v2 (fato, não opinião)

Eu fui conferir no código do mastercomfig 9.100.1 antes de escrever esta versão:

| O que a v2 dizia | O que é de verdade |
|---|---|
| "`net_maxpacketdrop 0`, `net_splitrate 1`, `cl_pred_optimize 2` são tweaks de fórum que causam choke — removidos" | O **próprio mastercomfig** define exatamente isso no `comfig.cfg` (`net_maxpacketdrop 0`, `net_splitrate 1`, `cl_pred_optimize 2`, `cl_smoothtime .01`, `cl_timeout 60`), e o `packet_size=large` põe `net_maxfragments/net_maxroutable 1260`. Tirar do *seu* autoexec foi certo (era duplicata), mas a justificativa de "tweak perigoso" está **errada**: são valores canônicos do mastercomfig |
| "`snapshot_buffer=auto` aplica o preset do Spy (mais seguro)" | O alias real é `alias net_spy "snapshot_buffer_off;cl_smooth 0"` → **`cl_interp_ratio 1` = 15ms de lerp + cl_smooth 0**. É o ajuste mais *rápido* que o mastercomfig recomenda pro Spy (o comentário no fonte dele diz literalmente: "backstab requires more sensitive timing") |
| "`shadows=low` ajuda a revelar Spy cloaked" | Blob shadow é barata e ajuda a perceber **movimento atrás de cobertura/payload** — não conte com ela pra achar Spy invisível. Mantive `shadows=low` porque o custo é ~zero, e sim, `shadows=off` é ~1-2 fps que eu **não** recomendo trocar por informação de movimento |
| "O `snapshot_buffer=auto` já dá o ideal, nada mais é preciso" | Verdade, e por isso o `spy.cfg` **reafirma** `net_spy` e o `autoexec.cfg` tem `net_spy_fast` / `net_spy_safe` pra você alternar em jogo |
| `sound=high` "tela mais limpa: net_graph 0" etc. | Mantido e confirmado: o módulo `sound=high` liga `snd_pitchquality 1`, `dsp_slow_cpu 0`, `dsp_spatial 40`. A sua cfg antiga estava em `snd_pitchquality 0` + `dsp_slow_cpu 1` = **módulo `sound=low`** — som achatado |

---

## 🕵️ Spy — o que a v3 acrescenta

1. **Disfarce pelo menu com atalho** (sua escolha): `MOUSE3` e a tecla `4` abrem o kit,
   `CAPSLOCK` chama "Spy!", `MOUSE4`/`b` repetem o último disfarce.
2. **`spy_fkeys.cfg`** continua existindo (disfarce direto `F1`..`F9` com a arma certa
   saindo já no slot natural da classe), mas **fora do caminho** — você só ativa se quiser:
   console → `spyfkeys`.
3. **Tabela dos "3 segredos do disfarce"** dentro do `spy.cfg`: qual slot faz o disfarce
   segurar medigun / wrench / minigun, o que o `1/2/3` faz já disfarçado, e como usar
   disfarce de aliado (`-2`).
4. **Dead Ringer documentado de verdade** no `spy.cfg`: `MOUSE2` = feign, `kill` **não**
   ativa o DR, e por que `ragdolls=medium` é o que te deixa ver **corpo falso** de DR inimigo
   (por isso NÃO desliguei ragdolls, mesmo caçando FPS).
5. **Rede do Spy**: `net_spy` reafirmado no `spy.cfg` + toggles `net_spy_fast` (15ms) /
   `net_spy_safe` (30ms) pro dia em que a internet estiver ruim e a facada "não registrar".
6. **Áudio em modo fone** (o item nº 1 da tabela de bugs) — o ganho mais concreto pra Spy
   de toda a v3.

---

## ⚙️ Gráficos e desempenho (i5-3470 + GT 630)

Tudo no `modules.cfg`, com comentário em cada linha. Resumo das decisões:

| Módulo | Valor | Por quê |
|---|---|---|
| `lod`, `shading`, `lighting` | `low` / `low` / `low` | os 3 maiores ganhos de GPU no GT 630 (sem bumpmap/specular/luz dinâmica) |
| `effects` | `very_low` | partículas quase zero — alívio grande de **CPU** também (i5 de 4 núcleos) |
| `3dsky`, `props`, `ropes`, `anti_aliasing` | `off` / `low` / `off` / `off` | fillrate: é o que o GT 630 sofre |
| `texture_quality` | `low` | menos VRAM → menos stutter (a doc do mastercomfig marca textura como uso médio de GPU) |
| `ragdolls` | **`medium`** | mantido **de propósito**: é como você identifica fake de Dead Ringer |
| `shadows` | **`low`** | blob shadow ~grátis, e informação de movimento atrás de cobertura |
| `sound` | **`high`** | espacialização completa. `very_high` (imediato) está comentado no arquivo |
| `water` | `low` | a sua cfg antiga estava em `high` = reflexo 1024 de graça |
| `fpscap` | `120` | 1.5x do seu 80Hz. Guia de quando usar 160 / 90 / 75 está comentado no arquivo |
| `hud_player_model` | `off` | item nº 2 da tabela de bugs |
| `outlines`, `hud_avatars`, `killstreaks`, `hud_achievement`, `hud_contracts` | `off` / `off` / `low` / `off` / `hide` | informação de HUD sob controle, sem custo |

Se algum dia faltar FPS, a **seção 6 do `modules.cfg`** tem os degraus seguintes
(`lighting=very_low`, `water=very_low`, `shadows=off`, `sound=medium`...), um por linha.

---

## ➕ Coisas novas que não existiam antes

* `game_overrides.cfg` — roda por partida/troca de classe (o arquivo certo pra áudio e crosshair).
* `spy_fkeys.cfg` — disfarce direto `F1`..`F9`, opcional.
* Aliases: `bench` / `unbench` (medir fps+frametime), `net_spy_fast` / `net_spy_safe`,
  `hudmodel_on` / `hudmodel_off`, `spyfkeys`, `cleardecals`.
* `docs/GUIA.md` — launch options, NVIDIA/Windows, tabela de **cm/360**, interp explicado,
  dicas de Spy por classe de disfarce e resolução de problemas.
* `install.bat` (Windows) e `install.sh` (Linux/macOS) — instalam com **backup automático**
  do `overrides` antigo e avisam se o mastercomfig não estiver em `tf/custom`.
* Repositório organizado: `backup/` (suas configs antigas do jogo) e `custom-backup/`
  (o antigo `custom - Copy`, com seus mods). Arquivo `hud` (1 byte, lixo) deletado.

---

## 🚫 O que eu NÃO mudei (de propósito)

* **Sua sensibilidade (2.5 @ 1600 DPI)** e sua mira. Só documentei: isso dá **~10,4 cm/360**,
  que é muito rápido até pra Spy — no `GUIA.md` tem a tabela de cm/360 e a sugestão de
  testar 1.7 (~15,3 cm) ou 1.3 (~20 cm) se quiser mais consistência de revolver.
  Quem decide é você, e é uma linha só pra mudar.
* **Seus hitsounds, números de dano e mods** (`custom-backup/`: noscreams, compviewmodels,
  No_MM_Music, nocritsoundbackstab...) — não são parte da cfg e não quis tocar no seu gosto.
* **Sua loadout e seu estilo** (DR + Kunai/Big Earner): só documentei as implicações.
* `tf_use_min_viewmodels 1`, `sprays=keep`, seus binds de chat/voz e a tecla `k` de killbind.

---

## ✅ Checklist de teste (5 minutos)

1. Abrir o jogo → console mostra `mintlyy-cfg v3 (SPY MAIN) CARREGADA`.
2. Console: `preset_level` (baixe o preset **low** se disser `preset=custom`) e `module_levels`.
3. Entrar numa partida e colar no console: **`snd_surround_speakers`** → tem que responder **0**.
4. Andar com **W + S** apertados: não pode travar (null-cancel). Console: `null` / `nonull` alterna.
5. Spy: **MOUSE3** abre o kit de disfarce · **MOUSE5** saca sapper · **CAPSLOCK** chama "Spy!".
6. Console: `bench` → jogue 2 minutos olhando fps/frametime → `unbench`.
7. Se algo parecer errado: `apply_overrides` (reaplica tudo sem reiniciar o jogo).
