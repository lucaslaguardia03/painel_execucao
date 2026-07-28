E:
cd \QlikView\dcgf\painel_execucao

git checkout . && git pull
make build_ano_corrente && qv /r painel_execucao.qvw 2> painel_execucao.log
type painel_execucao.log >> logs\log.Rout
del painel_execucao.log