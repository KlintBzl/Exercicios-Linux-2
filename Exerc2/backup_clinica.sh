#!/bin/bash

# Diretórios
ORIGEM="/home/klint/Área de Trabalho/Trabalhos/Exerc2/clinica/dados"
DESTINO="/home/klint/Área de Trabalho/Trabalhos/Exerc2/hd_externo/backups"
LOG="/home/klint/Área de Trabalho/Trabalhos/Exerc2/backup_clinica.log"

# Data atual
DATA=$(date +"%Y-%m-%d")

# Nome do backup
ARQUIVO="backup_$DATA.tar.gz"

echo "Iniciando backup..."

# Verificar se o diretório de destino existe
if [ ! -d "$DESTINO" ]; then
    mkdir -p "$DESTINO"
fi

# Criar backup compactado
tar -czf "$DESTINO/$ARQUIVO" "$ORIGEM"

# Verificar se o backup foi criado com sucesso
if [ $? -eq 0 ]; then

    STATUS="SUCESSO"

    # Tamanho do arquivo
    TAMANHO=$(du -h "$DESTINO/$ARQUIVO" | awk '{print $1}')

else

    STATUS="ERRO"

    TAMANHO="0"

fi

# Remover backups com mais de 30 dias
find "$DESTINO" -type f -name "*.tar.gz" -mtime +30 -delete

# Registrar log
echo "[$(date +"%d/%m/%Y %H:%M:%S")] Backup: $ARQUIVO | Tamanho: $TAMANHO | Status: $STATUS" >> "$LOG"

# Exibir resumo no terminal
echo "=============================="
echo "Backup concluído"
echo "Arquivo: $ARQUIVO"
echo "Destino: $DESTINO"
echo "Tamanho: $TAMANHO"
echo "Status: $STATUS"
echo "=============================="

