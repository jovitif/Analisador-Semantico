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
  </li>
  <li>
    <p>O programa irá gerar a análise sintática e mostrar se teve algum erro ou não encontrado no processo de análise</p>
  </li>
</ol>
