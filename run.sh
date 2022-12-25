#!/bin/bash

# DESAFIO DE PROJETO N°1 - Formação Linux Fundamentals
#
# Infraestrutura como Código: Script de Criação
# de Estrutura de Usuários, Diretórios e Permissões
#
# Criador:  Gerson Luis Leite
# Data:     24/12/2022
# Versão:   1.0

echo ""
echo "##########################"
echo "#     CRIANDO GRUPOS     #"
echo "##########################"

groups=("GRP_ADM" "GRP_VEN" "GRP_SEC")
groups_number=${#groups[@]}

for group in $(seq 0 $[groups_number-1]);
do
    groupadd ${groups[group]} && echo "-> Grupo ${groups[group]} criado";
done

echo ""
echo "##########################"
echo "#    CRIANDO USUÁRIOS    #"
echo "##########################"

##########################
###  USUÁRIOS GRP_ADM  ###
users_adm=("carlos" "maria" "joao")
users_adm_number=${#users_adm[@]}

for user in $(seq 0 $[users_adm_number-1]);
do
    password="dio.$[$RANDOM%100]"
    useradd ${users_adm[user]} -G GRP_ADM -m -s /bin/bash -p $(openssl passwd $password) && echo "-> Usuário ${users_adm[user]} criado - Senha: $password"
    passwd ${users_adm[user]} --expire > /dev/null && echo "-- Usuário adicionado ao grupo GRP_ADM"
    echo ""
done

##########################
###  USUÁRIOS GRP_VEN  ###
users_ven=("debora" "sebastiana" "roberto")
users_ven_number=${#users_ven[@]}

for user in $(seq 0 $[users_ven_number-1]);
do
    password="dio.$[$RANDOM%100]"
    useradd ${users_ven[user]} -G GRP_VEN -m -s /bin/bash -p $(openssl passwd $password) && echo "-> Usuário ${users_ven[user]} criado - Senha: $password"
    passwd ${users_ven[user]} --expire > /dev/null && echo "-- Usuário adicionado ao grupo GRP_VEN"
    echo ""
done

##########################
###  USUÁRIOS GRP_SEC  ###
users_sec=("josefina" "amanda" "rogerio")
users_sec_number=${#users_sec[@]}

for user in $(seq 0 $[users_sec_number-1]);
do
    password="dio.$[$RANDOM%100]"
    useradd ${users_sec[user]} -G GRP_SEC -m -s /bin/bash -p $(openssl passwd $password) && echo "-> Usuário ${users_sec[user]} criado - Senha: $password"
    passwd ${users_sec[user]} --expire > /dev/null && echo "-- Usuário adicionado ao grupo GRP_SEC"
    echo ""
done

##########################
echo "##########################"
echo "#   CRIANDO DIRETÓRIOS   #"
echo "##########################"

public_folders=("/publico")
public_folders_number=${#public_folders[@]}

for public_folder in $(seq 0 $[public_folders_number-1]);
do
    mkdir ${public_folders[public_folder]} && echo "-> Pasta ${public_folders[public_folder]} criada";
    chmod 777 ${public_folders[public_folder]} && echo "-- Alterado PERMISSÃO da pasta ${public_folders[public_folder]} para 777"
    echo ""
done

folders=("/adm" "/ven" "/sec")
folders_number=${#folders[@]}

for folder in $(seq 0 $[folders_number-1]);
do
    mkdir ${folders[folder]} && echo "-> Pasta ${folders[folder]} criada";
    chmod 770 ${folders[folder]} && echo "-- Alterado PERMISSÃO da pasta ${folders[folder]} para 770"
    chown root:${groups[folder]} ${folders[folder]} && echo "-- Alterado GRUPO da pasta ${folders[folder]} para ${groups[folder]}"
    echo ""
done

# rm -rf publico/ adm/ ven/ sec/ && groupdel -f GRP_ADM && groupdel -f GRP_VEN && groupdel -f GRP_SEC && userdel -rf carlos && userdel -rf maria && userdel -rf joao && userdel -rf debora && userdel -rf sebastiana && userdel -rf roberto && userdel -rf josefina && userdel -rf amanda && userdel -rf rogerio