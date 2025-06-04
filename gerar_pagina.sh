#!/bin/bash

# Verifica se o arquivo alunos.txt existe
if [ ! -f alunos.txt ]; then
    echo "O arquivo alunos.txt não foi encontrado!"
    exit 1
fi

# Cria o arquivo HTML
cat <<EOF > alunos.html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Sistemas Operacionais</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { text-align: center; }
        .aluno {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 10px;
            float: left;
            width: 120px;
        }
        .aluno img {
            width: 64px;
            height: 64px;
        }
        .sistema {
            clear: both;
            margin-top: 40px;
        }
        pre {
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
    </style>
</head>
    <h1>UNIFEBE<br>Sistemas de Informação - Sistemas Operacionais</h1>
    <h2>Lista de Alunos</h2>
<body>
EOF

# Adiciona cada aluno com um ícone acima do nome
while IFS= read -r aluno; do
    echo "    <div class=\"aluno\">" >> alunos.html
    echo "        <img src=\"https://cdn-icons-png.flaticon.com/512/847/847969.png\" alt=\"Aluno\">" >> alunos.html
    echo "        <p>$aluno</p>" >> alunos.html
    echo "    </div>" >> alunos.html
done < alunos.txt

# Pega as informações do sistema operacional
HOSTNAME=$(hostname)
KERNEL=$(uname -r)
LINUX_VERSION=$(cat /etc/*release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
CPU=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//')
MEMORIA=$(free -h | grep Mem | awk '{print $2 " total, " $3 " usados, " $4 " livres"}')
DISCO=$(df -h / | grep / | awk '{print $2 " total, " $3 " usados, " $4 " livres"}')
DOCKER=$(docker --version 2>/dev/null || echo "Docker não instalado")

# Adiciona as informações do sistema ao HTML
cat <<EOF >> alunos.html

    <div class="sistema">
        <h2>Informações do Sistema</h2>
        <pre>
Hostname: $HOSTNAME
Kernel: $KERNEL
Distribuição Linux: $LINUX_VERSION
CPU: $CPU
Memória: $MEMORIA
Disco: $DISCO
Docker: $DOCKER
        </pre>
    </div>
</body>
</html>
EOF

echo "Arquivo alunos.html gerado com sucesso!"

