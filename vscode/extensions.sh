#!/bin/zsh

extensions=(
  abusaidm.html-snippets
  alefragnani.rtf
  apollographql.vscode-apollo
  austin.code-gnu-global
  bajdzis.vscode-database
  bdavs.expect
  Biscrat.kagex-vscode
  Biscrat.tjs-vscode
  bradgashler.htmltagwrap
  bradymholt.pgformatter
  bungcip.better-toml
  burkeholland.simple-react-snippets
  christian-kohler.npm-intellisense
  christian-kohler.path-intellisense
  chrmarti.regex
  ckolkman.vscode-postgres
  DavidAnson.vscode-markdownlint
  dbaeumer.jshint
  dbaeumer.vscode-eslint
  donjayamanne.githistory
  DotJoshJohnson.xml
  dsznajder.es7-react-js-snippets
  eamodio.gitlens
  ecmel.vscode-html-css
  EditorConfig.EditorConfig
  eg2.vscode-npm-script
  esbenp.prettier-vscode
  fabiospampinato.vscode-diff
  felixfbecker.php-debug
  felixfbecker.php-intellisense
  felixfbecker.php-pack
  firefox-devtools.vscode-firefox-debug
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  formulahendry.docker-explorer
  foxundermoon.shell-format
  GitHub.vscode-pull-request-github
  goessner.mdmath
  golang.go
  GrapeCity.gc-excelviewer
  hdg.live-html-previewer
  hediet.vscode-drawio
  hnw.vscode-auto-open-markdown-preview
  HookyQR.beautify
  IBM.output-colorizer
  jakob101.RelativePath
  James-Yu.latex-workshop
  jasonnutter.search-node-modules
  jebbs.plantuml
  joaompinto.vscode-graphviz
  leizongmin.node-module-intellisense
  lihui.vs-color-picker
  marp-team.marp-vscode
  mechatroner.rainbow-csv
  mhutchie.git-graph
  Mikael.Angular-BeastCode
  mkaufman.HTMLHint
  mrmlnc.vscode-apache
  ms-azuretools.vscode-docker
  MS-CEINTL.vscode-language-pack-ja
  ms-dotnettools.csharp
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-mssql.mssql
  ms-python.anaconda-extension-pack
  ms-python.python
  ms-python.vscode-pylance
  ms-toolsai.jupyter
  ms-toolsai.jupyter-renderers
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  ms-vscode-remote.remote-wsl
  ms-vscode-remote.vscode-remote-extensionpack
  ms-vscode.cmake-tools
  ms-vscode.cpptools
  ms-vscode.powershell
  ms-vscode.vscode-typescript-tslint-plugin
  ms-vsliveshare.vsliveshare
  ms-vsliveshare.vsliveshare-audio
  ms-vsts.team
  msjsdiag.debugger-for-chrome
  mtxr.sqltools
  mutantdino.resourcemonitor
  mxschmitt.postscript
  naumovs.color-highlight
  nodesource.vscode-for-node-js-development-pack
  NuclleaR.vscode-extension-auto-import
  oderwat.indent-rainbow
  pflannery.vscode-versionlens
  redhat.java
  redhat.vscode-commons
  redhat.vscode-yaml
  RomanPeshkov.vscode-text-tables
  rust-lang.rust
  saikou9901.evilinspector
  shardulm94.trailing-spaces
  slevesque.vscode-zipexplorer
  steoates.autoimport
  TabNine.tabnine-vscode
  TeamHub.teamhub
  Tobiah.language-pde
  twxs.cmake
  uctakeoff.vscode-counter
  VisualStudioExptTeam.vscodeintellicode
  vsciot-vscode.vscode-arduino
  vscjava.vscode-java-debug
  vscjava.vscode-java-dependency
  vscjava.vscode-java-pack
  vscjava.vscode-java-test
  vscjava.vscode-maven
  waderyan.nodejs-extension-pack
  WallabyJs.quokka-vscode
  wix.vscode-import-cost
  wraith13.wandbox-vscode
  xabikos.JavaScriptSnippets
  yzhang.markdown-all-in-one
  zgm.cuesheet
  zh9528.file-size
  Zignd.html-css-class-completion
)

if type code &>/dev/null; then
  for extension in ${extensions[@]}; do
    code --install-extension ${extension}
  done
else
  VSCODE_PATH_COMMAND="Shell Command: Install 'code' command in PATH"
  echo 'Skipped install vscode extension.'
  echo "Require run \"${VSCODE_PATH_COMMAND}\" in vscode!"
fi
