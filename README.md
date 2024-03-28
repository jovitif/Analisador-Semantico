<h1>Implementação de um Analisador Sintático para OWL Manchester Syntax</h1>
<h2>Objetivo</h2>
<p>Especificar um analisador sintático somente para a análise de declarações de classes na linguagem OWL, de acordo com o formato Manchester Syntax, de acordo com as seguintes diretrizes:

Os exemplos acima dão noções de como uma classe pode ser declarada;

Elaborar uma gramática livre de contexto, sem ambiguidade, fatorada e sem recursividade à esquerda;

Construir uma tabela de análise preditiva (para implementação manual) ou utilizar um gerador de analisador sintático com base em análise ascendente;

Simular a leitura de uma especificação de classe como entrada para verificação da consistência da declaração da classe;

Por “consistência”, entende-se que a declaração das classes seguem uma ordem que varia de acordo com o tipo de classe (p.ex.: separação dos nomes das classes por vírgulas nas classes enumeradas, disjunções entre as subclasses de uma classe coberta, separação de cláusulas pela palavra-chave AND ou por espaçamento, no caso das classes definidas e primitivas, respectivamente).</p>

<h2>Equipe</h2>
<ul>
  <li>João Vitor Fernandes de Sales</li>
  <li>Rafael Lucas de Azevedo Nunes</li>
</ul>

<h2>Tutorial de Execução:</h2>
<ol>
  <li>
    <p>É necessário baixar o projeto que foi hospedado no Github. Para isso, é necessario fazer o donwload ou em formato zip ou utilizando a ferramenta do Git</p>
    <p>Para baixar o zip é necessário apenas ir em code e depois em Download ZIP e após isso extrair a pasta</p>
    <p>Se for utilizando o a ferramenta Git é necessário apenas ir no terminal e digitar o seguinte comando:</p>
    <code>git clone https://github.com/Compass-pb-aws-2024-IFSUL-UFERSA/sprint-4-pb-aws-ifsul-ufersa.git</code>
    <p>Esse comando irá salvar o código em sua máquina local</p>
  </li>
  <li>
    <p>Após o projeto salvo é necessário entrar dentro da pasta Analisador-Sintatico e em seguida entrar na pasta projeto</p>
    <code>cd Analisador-Sintatico/</code>
     <code>cd projeto/</code>
  </li>
  <li>
    <p>Importante: é necessário ter o flex e o bison configurado no Visual Studio Code para poder funcionar a compilação do projeto</p>
  </li>
  <li>
    <p>Agora para compilar o analisador usando o makeFile devemos digitar o comando make</p>
    <code>make</code>
    <p>Ele irá gerar os arquivos lex.yy.c, sintatico.tab.c, sintatico.tab.h e a.out</p>
</li>
  <li>
    <p>Para executar é preciso somente digitar o comando ./a.out e depois digitar o nome do arquivo .txt a ser analisado </p>
    <p>Exemplo:</p>
    <code>./a.out classe_aninhada.txt</code>
    <p>Dentro da pasta projeto tem 8 arquivos .txt para testes. Desses arquivos 6 são de classes separadas e 2 são de junção de várias classes</p>
  </li>
  <li>
    <p>O programa irá gerar a análise sintática e mostrar se teve algum erro ou não encontrado no processo de análise</p>
    <p>Exemplo de saída:</p>
      Realizando analise sintatica...

linha 0: uma classe primitiva 
linha 8: uma classe primitiva 
linha 15: uma classe primitiva 
linha 24: uma classe primitiva 
linha 31: uma classe primitiva com axioma de fechamento 
linha 40: uma classe definida com axioma de fechamento 
linha 54: uma classe primitiva 
linha 63: uma classe primitiva com axioma de fechamento 
linha 74: uma classe primitiva com axioma de fechamento 
linha 84: uma classe primitiva 
linha 93: uma classe primitiva 
linha 100: uma classe primitiva 
linha 108: uma classe primitiva com axioma de fechamento 
linha 117: uma classe primitiva com axioma de fechamento 
linha 126: uma classe primitiva 
linha 137: uma classe primitiva 
linha 156: uma classe definida 
linha 170: uma classe primitiva com axioma de fechamento 
linha 179: uma classe primitiva 
linha 189: uma classe primitiva 
linha 211: uma classe primitiva 
linha 220: uma classe primitiva 
linha 229: uma classe definida com axioma de fechamento 
linha 241: uma classe definida com axioma de fechamento 
linha 256: uma classe especial 
linha 265: uma classe primitiva com axioma de fechamento 
linha 274: uma classe definida com axioma de fechamento 
linha 286: uma classe primitiva 
linha 295: uma classe primitiva 
linha 303: uma classe primitiva 
linha 310: uma classe primitiva 
linha 323: uma classe primitiva 
linha 333: uma classe primitiva 
linha 344: uma classe primitiva 
linha 355: uma classe definida com axioma de fechamento 
linha 367: uma classe primitiva com axioma de fechamento 
linha 376: uma classe primitiva com axioma de fechamento 
linha 385: uma classe primitiva com axioma de fechamento 
linha 396: uma classe primitiva com axioma de fechamento 
linha 407: uma classe primitiva 
linha 416: uma classe primitiva 

Quantidade de classes: 41

Quantidade de classes primitivas: 34

Quantidade de classes definidas: 6

Quantidade de classes enumeradas: 0

Quantidade de classes cobertas: 0

Quantidade de axiomas de fechamento: 29

Quantidade de aninhadas: 0

Quantidade de especiais: 1

  </li>
</ol>
