# 🗡️ mintlyy-cfg v2 — O que mudou e por quê

Baseado na sua config antiga + o que você pediu: **monitor 80Hz**, **prioridade máximo FPS** e **só scripts seguros** (nada que controle seu personagem).

---

## 🐛 Bugs reais corrigidos

| # | Bug na cfg antiga | Consequência | Correção |
|---|---|---|---|
| 1 | `alias null "exec nullcancel"` — o arquivo `nullcancel.cfg` **não existia** | O comando `null` no console nunca funcionou | Alias aponta pra `exec overrides/null` (e os aliases agora moram no autoexec) |
| 2 | `fps_max 91` no autoexec **vs** `fpscap=120` no modules.cfg | Os dois brigavam; o 91 vencia por rodar depois. Você jogava a 91 fps num monitor de 80Hz sem headroom | Um único dono: `fpscap=120` no modules.cfg (80Hz × 1.5). Se o PC segurar sempre, mude pra `160` (2× o refresh = pacing perfeito); se oscilar, `75` |
| 3 | `tf_weapon_criticals 1` no autoexec com comentário dizendo que **desativava** críticos | Comentário mentia (valor 1 = ligado) e a linha não faz nada em servidor normal (cvar de servidor) | Removida do autoexec; fica só no `walkway.cfg` (treino local), onde funciona |
| 4 | `bind MOUSE5 +sap` — **`+sap` não existe no TF2** (é alias de script de terceiros que nunca foi definido na sua cfg) | Seu MOUSE5 era um **botão morto** | `bind MOUSE5 slot2` (saca sapper com 1 toque). O script clássico de sap ficou comentado no spy.cfg, se um dia quiser |
| 5 | `r_shadows 0` no autoexec vs `shadows=low` no modules.cfg | Conflito: você pagava (quase nada, mas pagava) a intenção do módulo sem receber nada — sombras 100% off | `shadows=low` (blobby, custo ~zero). Bônus Spy: **a sombra delata Spy inimigo cloaked** |
| 6 | `sv_cheats 1` fixo no autoexec | Inútil em servidor online (é cvar de servidor) e só servia pro walkway | Movido pro `walkway.cfg`, que já tinha |
| 7 | Bloco de som degradando qualidade (`snd_pitchquality 0`, `dsp_slow_cpu 1`, `snd_spatialize_roundrobin 3`...) "pra ganhar FPS" | **Pior pra Spy**: som posicional pior = não ouvir de onde vem decloak/passos. E o ganho de FPS é ~nulo (o custo de som é CPU mínimo) | `sound=high` no modules.cfg — espacialização completa. PC aguenta? `sound=very_high` |
| 8 | `null.cfg` terminava em `clear` | Limpar o console toda vez que trocava de classe | Removido |
| 9 | Null-cancel só ligava via `spy.cfg`/`soldier.cfg` (e o caminho era o bug #1) | Nas outras classes ficava inconsistente | Null-cancel agora é global, definido no autoexec com toggle (`null`/`nonull` no console) |
| 10 | `water=high` no modules.cfg numa config "max FPS" | Água com reflexo 1K — o cenário mais pesado possível, de graça pra zero benefício competitivo | `water=low` |
| 11 | `alias filter "exec filter"` — `filter.cfg` não existe no repo | Comando quebrado no console | Removido |

## 🌐 Rede — limpeza

A cfg antiga empilhava tweaks "de forúm" em cima do mastercomfig. Foram removidos:

- `net_maxcleartime 0.001`, `net_maxpacketdrop 0`, `net_maxfragments 1260`, `net_splitrate 1`, `net_maxroutable 1260` — mexem no pacing de pacotes e **causam choke/perda em conexão real**, não ajudam
- `cl_pred_optimize 2` — fora do recomendado, pode causar erro de predição
- `cl_interp 0; cl_interp_ratio 1` fixos — agora o `snapshot_buffer=auto` escolhe o lerp **por classe** (o Spy recebe o preset próprio do mastercomfig). Se quiser o 15ms manual de volta, está comentado no autoexec (flags de facada registram pior com perda de pacote)
- `rate/cmdrate/updaterate` duplicados — o `bandwidth=6.0Mbps` + `packet_rate=standard` do modules.cfg já entregam o máximo (66 tick, rate 786432)

## 📊 Gráficos — agora 100% pelos módulos

O autoexec antigo tinha ~150 linhas de cvars gráficos que **duplicavam ou contradiziam** o mastercomfig (shadows, lighting, phong, water, effects...). Tudo isso agora é uma lista enxuta e documentada no `modules.cfg`: mesma agressividade FPS da sua intenção original (`lighting=low`, `effects=very_low`, `texture_filter=blocky`, `characters=very_low`...), mas sem conflito e fácil de ajustar.

Mantidos à mão só os que módulo não cobre ou são gosto pessoal: `r_drawtracers_firstperson 0`, `cl_ragdoll_collide 0`, viewmodel/FOV, crosshair (que já estava bom no seu config.cfg).

## 🕵️ Spy — o que ganhou

1. **Disguise com a arma certa** (F1–F9): a arma exibida pelo disfarce segue o slot que você segura. Cada bind já troca pra arma natural da classe:
   - Medic segurando **medigun** (`slot2`), Engineer com **wrench** (`slot3`), resto com primária
   - Já disfarçado, `1/2/3` troca a arma visível sem re-disfarçar
   - Bloco alternativo comentado (disfarce sem trocar sua arma) — é só trocar
2. **Engineer no F9** — faltava na sua cfg antiga (você tinha 8 classes, engineer é dos disfarces mais fortes contra sentry)
3. **MOUSE5 funcionando** (sapper de 1 toque — era botão morto, bug #4)
4. **Ragdolls mantidos** (`ragdolls=medium`) — essencial pra identificar fake do Dead Ringer; seu setup manual virou módulo
5. **Som posicional decente** (`sound=high`) — a maior arma do Spy é ouvir decloak; agora funciona
6. **Tela mais limpa**: `net_graph 0` (F10 alterna) e `cl_showpos 0` por padrão — antes ficavam fixos no HUD

## 🧹 Estrutura

- Tudo que é do usuário agora mora em `cfg/overrides/` (incluindo `null.cfg`, `nonull.cfg`, `walkway.cfg`, que antes ficavam soltos)
- `autoexec.txt` (cópia velha desatualizada) deletado
- `config.cfg` intocado — é o backup dos seus binds, o jogo que gerencia
- README reescrito com o **caminho de instalação correto** do mastercomfig (`tf/cfg/overrides/` — o antigo apontava pra `tf/custom`, onde o mastercomfig não lê)

## ✅ Como testar depois de instalar

1. Console deve mostrar `mintlyy-cfg v2 (SPY EDITION) CARREGADA`
2. `module_levels` — confere se os módulos tão como no modules.cfg
3. Andar apertando W+S junto: se **não travar**, null-cancel tá on (`null`/`nonull` alterna)
4. Spy: F2 (medic com medigun), F9 (engineer com wrench), MOUSE5 (sapper)
5. `walkway` no console pra treinar
