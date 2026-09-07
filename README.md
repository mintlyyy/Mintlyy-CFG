# 🗡️ mintlyy-cfg v2 — Spy Main Edition

TF2 config focada em **Spy**, construída em cima do [mastercomfig](https://mastercomfig.com/).

## 📦 O que tem aqui

```
cfg/
└── overrides/          ← ÚNICA pasta que você instala (veja abaixo)
    ├── autoexec.cfg    ← binds, aliases de movimento (null-cancel), HUD, mouse
    ├── modules.cfg     ← gráficos, som e rede (módulos do mastercomfig)
    ├── spy.cfg         ← disfarces rápidos com a arma certa, sapper, etc.
    ├── soldier.cfg
    ├── null.cfg / nonull.cfg   ← liga/desliga null-cancel no console
    └── walkway.cfg     ← treino (digite "walkway" no console)

cfg/config.cfg          ← backup dos SEUS binds (não precisa copiar; é referência)
custom - Copy/          ← backup do seu tf/custom antigo (hitsounds, mastercomfig-base, etc.)
```

## 🛠️ Instalação (correta para mastercomfig)

1. Tenha o **mastercomfig** instalado (baixe o preset *medium* ou *low* em
   [mastercomfig.com](https://mastercomfig.com/) e jogue o `.vpk` em `tf/custom`).
2. Copie a pasta **`cfg/overrides`** deste repo para dentro de **`tf/cfg/`** —
   o resultado final deve ser:
   ```
   Team Fortress 2/tf/cfg/overrides/autoexec.cfg
   Team Fortress 2/tf/cfg/overrides/modules.cfg
   Team Fortress 2/tf/cfg/overrides/spy.cfg
   ...
   ```
   ⚠️ **Não** coloque em `tf/custom/...` — com mastercomfig, configs de usuário
   vivem em `tf/cfg/overrides/`. (A instalação antiga deste repo apontava o
   caminho errado.)
3. Opcional: restaure seus binds copiando o `config.cfg` do repo para `tf/cfg/`
   (só em instalação nova — ele é sobrescrito pelo jogo normalmente).
4. Abra o jogo. Se quiser conferir, abra o console e veja
   `mintlyy-cfg v2 (SPY EDITION) CARREGADA`.

## 🕹️ Comandos no console

| Comando   | O que faz                                      |
|-----------|------------------------------------------------|
| `null`    | liga null-canceling movement                   |
| `nonull`  | desliga null-canceling (movimento padrão)      |
| `walkway` | carrega tr_walkway com settings de treino      |
| `module_levels` | mostra os módulos mastercomfig ativos     |

## ⌨️ Binds de Spy (rodando como Spy)

| Tecla  | Ação                                            |
|--------|-------------------------------------------------|
| `F1`–`F9` | disfarce direto de inimigo já segurando a arma natural (F9 = Engineer, **novo**) |
| `b` / `MOUSE4` | lastdisguise (re-disfarce instantâneo)   |
| `MOUSE5` | saca o sapper (**fix**: antes era um comando inexistente) |
| `1/2/3` | já disfarçado, troca a arma visível do disfarce |
| scroll ↑↓ | pulo (bhop)                                   |

## 📋 Changelog completo

Veja [MELHORIAS.md](MELHORIAS.md) — lista todos os bugs corrigidos e melhorias
da v2 (fps cap certo pro seu monitor de 80Hz, som consertado, rede limpa,
disguise com arma certa, etc.).

## 📌 Recomendados

* [mastercomfig](https://mastercomfig.com/) — obrigatório
* **bxhud-sayo** ([tf2huds.dev/hud/bxhud-sayo](https://tf2huds.dev/hud/bxhud-sayo)) — o HUD que eu uso (BX HUD, edit xcd859 "sayo"). HUD vai em `tf/custom/`, não conflita com esta config

---
*Made by mintlyy — v2 melhorada com foco Spy 🕵️*
