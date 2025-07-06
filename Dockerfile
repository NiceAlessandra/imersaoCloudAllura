# Etapa 1: Imagem base
# Usamos uma imagem oficial do Python. A versão 'slim' é menor e boa para produção.
FROM PYTHON:3.13.5-alpine3.22
# Etapa 2: Diretório de trabalho
# Define o diretório de trabalho dentro do contêiner para /app.
WORKDIR /app

# Etapa 3: Copiar e instalar dependências
# Copia primeiro o requirements.txt para aproveitar o cache de camadas do Docker.
# Se o arquivo não mudar, o Docker reutiliza a camada, acelerando o build.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
# Copia todos os outros arquivos do projeto para o diretório de trabalho no contêiner.
COPY . .

# Etapa 5: Expor a porta
# Informa ao Docker que o contêiner escutará na porta 8000.
EXPOSE 8000

# Etapa 6: Comando de execução
# Comando para iniciar a aplicação Uvicorn.
# O host '0.0.0.0' é necessário para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

