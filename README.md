# Repositório - Painel Execução

Repositório que hospeda o painel de execução orçamentária do Estado de Minas Gerais, com dados históricos desde 2002 até o último ano com exercício financeiro finalizado.

## Instalação e Configuração do Ambiente

Antes de iniciar um novo projeto, é necessário garantir que todos os aplicativos necessários estão devidamente instalados e configurados. Um guia completo de instalação e configuração do ambiente está disponível [aqui](http://dcgf.gitlab.io/config-ambiente.html). Os problemas frequentes relacionados a configuração estão descritos [aqui](http://dcgf.gitlab.io/config-ambiente.html#faq).

## Inicialização do Projeto

Os passos para inicialização de um novo projeto são:


1. Crie uma pasta local e inicialize um novo repositório Git.
Obs. O repositório painel_execucao necessita do Git Large Files, haja vista o tamanho da base.

``` bash
git clone https://github.com/splor-mg/painel_execucao.git
```

## Configurações para uso do make cofin

Antes de executar o projeto, você precisará ter os seguintes programas instalados na sua máquina:

- [Git](https://git-scm.com/downloads)
- [Git Large Files](https://git-lfs.com/)
- [MakeFile](https://www.gnu.org/software/make/) 

## Utilize o comando abaixo para fazer o munge dos dados do pacote execução quando ele for atualizado: 
``` bash
make build_histórico
```

